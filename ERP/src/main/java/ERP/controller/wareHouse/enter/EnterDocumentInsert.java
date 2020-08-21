package ERP.controller.wareHouse.enter;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import ERP.service.buy.IBuy_DocService;
import enums.ServiceResult;
import validate.groups.InsertGroup;
import vo.buy.Buy_DocumentVO;

@Controller
@RequestMapping("/ware/enter/buy")
public class EnterDocumentInsert {
	
	@Inject
	IBuy_DocService service;
	
	@GetMapping("form")
	public String form() {
		return "wh/enter/endocumentForm";
	}
	
	@PostMapping
	public String insert(@Validated(InsertGroup.class) Buy_DocumentVO vo, BindingResult errors
						, Model model) {	//구매요청서 insert
		System.out.println(vo);
		String goPage = null;
		String message = null;
		if(!errors.hasErrors()) {
			ServiceResult result = service.createBuyDoc(vo);
			switch(result) {
			case FAIL:
				message = "잠시 후 다시 시도해주세요";
				goPage = "wh/enter/endocumentForm";
				break;
			default:
				System.out.println("등록 성공");
				goPage = "redirect:/ware/enter/buy";
			}
		}else {
			goPage = "wh/enter/endocumentForm";
		}
		model.addAttribute("message", message);
		return goPage;
	}
	
	
}
