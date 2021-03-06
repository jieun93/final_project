package ERP.controller.order;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import ERP.dao.IBuyerDAO;
import ERP.service.IBuyerService;

@Controller
@RequestMapping("/order/buyer/buyerList")
public class OR_BuyerReadConroller {
	IBuyerService service;
	@Inject
	IBuyerDAO dao;
	
	@GetMapping
	public String list() {
		return "order/buyer/or_buyerList";
	}
}
