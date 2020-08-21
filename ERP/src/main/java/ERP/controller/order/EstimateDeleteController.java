package ERP.controller.order;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.service.order.IEstimateService;
import enums.ServiceResult;
import vo.order.EstimateVO;

@Controller
@RequestMapping("/order/estimate/delete")
public class EstimateDeleteController {
	@Inject
	IEstimateService service;
	
	//상품삭제------------------------------------------------------------------
	
		//이부분 리드로 옮겨야 하지 않을까?
//	@PostMapping(produces="text/plain;charset=UTF-8")
//	@ResponseBody
//	public String delete(@RequestBody EstimateVO estVO) {
//		String str = "";
//		ServiceResult result = service.removeEstimate(estVO);
//		if(ServiceResult.OK.equals(result)) {
//			str = "해당 견적서가 삭제되었습니다.";
//		}else {
//			str = "삭제실패. 잠시후 다시 시도해주세요.";
//		}
//		return str;
//	}
	
	@PostMapping(produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String delete(@RequestBody EstimateVO estimate) {
		System.out.println(" 견적서 삭제 컨트롤러");
		String str = "";
		ServiceResult result = service.removeEstimate(estimate);
		if(ServiceResult.OK.equals(result)) {
			str = "해당 견적서가 삭제되었습니다.";
		}else {
			str = "삭제실패. 잠시후 다시 시도해주세요.";
		}
		return str;
	}
	
}
