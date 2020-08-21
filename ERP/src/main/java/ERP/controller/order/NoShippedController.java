package ERP.controller.order;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.service.order.IDeliveryOrderService;
import ERP.service.order.IShipmentService;
import vo.PagingVO;
import vo.order.DeliveryOrderVO;
import vo.order.EstimateVO;

@Controller
@RequestMapping("/order/shipment/noshipped")
public class NoShippedController {
	
	@Inject
	IDeliveryOrderService deliveryService;
	
	@Inject
	IShipmentService shipmentService;
	
	@GetMapping(produces = "application/json;charset=UTF-8")
	@ResponseBody
	public PagingVO<DeliveryOrderVO> ajaxList(
			@RequestParam(name = "page", required = false, defaultValue = "1")int currentPage,
			DeliveryOrderVO detailSearch, Model model
	){
		list(currentPage, detailSearch, model);
		PagingVO<DeliveryOrderVO> pagingVO = (PagingVO<DeliveryOrderVO>) model.asMap().get("pagingVO");
		return pagingVO;
		
	}
	
	
	//미출하현황 리스트
	@GetMapping
	public String list(
			@RequestParam(name = "page", required = false, defaultValue = "1")int currentPage,
			DeliveryOrderVO detailSearch, Model model
	) {
		PagingVO<DeliveryOrderVO> pagingVO = new PagingVO<>();
		pagingVO.setDetailSearch(detailSearch);
		pagingVO.setCurrentPage(currentPage);
		
//		int totalRecord = deliveryService.readDeliveryCount(pagingVO);
		
		System.err.println("	미출하리스트 도착?");
		
		List<DeliveryOrderVO> noShipList = shipmentService.readNoShippedList();
		
		System.err.println(noShipList +"시작");
		
//		pagingVO.setTotalRecord(totalRecord);
		pagingVO.setDataList(noShipList);
		
		System.err.println("-------- 끝");
		
		//페이징 vo에 데이터가 다있으니까 보내주기!
		model.addAttribute("pagingVO", pagingVO);
		
		//논리적인 view name
		
		return "order/noShipped/noShippedList";
	}
	
	//미출하현황 상세
	@GetMapping("{deliv_no}")
	public String view(
			@PathVariable(name = "deliv_no", required = true) String deliv_no, Model model
	) {
		System.out.println("	noshippent 상세페이지");
		int deliv_num = Integer.parseInt(deliv_no);
//		DeliveryOrderVO deliveryList = deliveryService.readDelivery(deliv_no);
		DeliveryOrderVO deliveryList = deliveryService.readDelivery(deliv_num);
		List<DeliveryOrderVO> list = new ArrayList<>();
		list.add(deliveryList);
		model.addAttribute("delivery", list);
		
		return "order/delivery/{deliv_no}";
	}
	
	//선택출하
//	@PostMapping
	public String shipment() {
		
		return "order/noShipped/noShippedList";
	}
	
	@PostMapping(value = "print/all", produces = "text/html;charset=UTF-8" )
	public String printAll(@RequestBody Map<String, Object> map, Model model) {
		System.out.println("      map값 : "+map);
		List<String> lista = (List<String>) map.get("list");
		int[] list = new int[lista.size()];
		for(int i = 0; i < lista.size(); i++) 
//			System.err.println(lista.get(i));
//			list[i] = lista.get(i);
			list[i] = Integer.parseInt(lista.get(i));
		
		List<DeliveryOrderVO> delivery = deliveryService.readDelivPrint(list);
		model.addAttribute("delivery", delivery);
		return "/order/noShipped/noShippedView";
	}
}
