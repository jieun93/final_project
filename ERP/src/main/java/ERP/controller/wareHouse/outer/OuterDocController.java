package ERP.controller.wareHouse.outer;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.dao.wareHouse.IWareOthersDAO;
import ERP.service.wareHouse.IOuterDocumentService;
import enums.ServiceResult;
import exception.DataNotFoundException;
import vo.PagingVO;
import vo.emp.EmployeeVO;
import vo.order.DeliveryOrderVO;
import vo.order.OrderListVO;
import vo.order.OrderVO;
import vo.wareHouse.OuterDocumentVO;
import vo.wareHouse.OuterStoreVO;
import vo.wareHouse.ProdVO;

@Controller
@RequestMapping("ware/outer/doc")
public class OuterDocController {
	
	private static Logger logger = LoggerFactory.getLogger(OuterDocController.class);
	
	@Inject
	IOuterDocumentService docService;
	
	@Inject
	IWareOthersDAO othersDao;

	// 출하지시서 목록 띄우기 
	@GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<OuterDocumentVO> ajaxForList(
		@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
		OuterDocumentVO detailSearch, Model model
	)throws IOException{
		DocList(currentPage,detailSearch, model);
		return (PagingVO<OuterDocumentVO>) model.asMap().get("pagingVO");
	}
	
	@GetMapping("list")
	public String DocList(
		@RequestParam(name="page",required = false, defaultValue = "1") int currentPage,
		OuterDocumentVO detailSearch, Model model) throws IOException{
		PagingVO<OuterDocumentVO> pagingVO = new PagingVO<>();
		pagingVO.setDetailSearch(detailSearch);
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = docService.readOuterDocCnt(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<OuterDocumentVO> outDocList = docService.readOuterDocList(pagingVO);
		pagingVO.setDataList(outDocList);
		
		model.addAttribute("pagingVO", pagingVO);
		return "wh/outer/outRequestListView";
	}

	// 7. 출하지시서 상세보기
	@GetMapping("order/{board_no}")
	public String OutOrderViewGet(
		@PathVariable(required = true) int board_no, Model model
		, HttpSession session 
	) {
		EmployeeVO emp = (EmployeeVO) session.getAttribute("authUser");
		
		DeliveryOrderVO delOrVO  = docService.readDeliveryOrder(board_no);
		model.addAttribute("delOrVO",delOrVO);
		
		List<OrderVO> delOrder = delOrVO.getOrder(); // ordervo를 꺼내고
		
		System.out.println("delOrVO   "+delOrVO);
		
		List<String> prod_no_list = new ArrayList<>();
		List<List<OuterStoreVO>> storeList = new ArrayList<>();
		
		for(int i = 0; i<delOrder.size(); i++) {
			List<OrderListVO> orderList = delOrder.get(i).getOrderList(); // orderlist 주문상품 목록을 꺼냄
			for(int j=0; j<orderList.size(); j++) {
				List<ProdVO> prodList = orderList.get(j).getProdList(); // 상품 
				for(int k=0; k<prodList.size(); k++) {
					String prod_no = prodList.get(k).getProd_no();
					prod_no_list.add(prod_no);
					storeList.add(othersDao.outerPStroeList(prod_no)); // 상품 각각의 store를 꺼내온다. 
					model.addAttribute("storeList",storeList);
					System.out.println("storeList   "+storeList);
				}
			}
		}
		return "/wh/outer/outProdOuterReqModalView";
	}
	
	// 7-1. 출하지시서를 토대로 상품 출고하기
	@PostMapping(produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String OutOrderPductPost(
		@RequestBody DeliveryOrderVO deliveryOrVO, HttpServletResponse resp
	) throws IOException{
		
		String resultStr =null;
		try {
			ServiceResult result = docService.updateOrDelivery(deliveryOrVO);
			if(ServiceResult.OK.equals(result)) {
				resultStr = "ok";
			}else {
				resultStr = "fail";
			}
		} catch (DataNotFoundException e) {
			resultStr = "fail";
		}
		return resultStr;
	}
}
