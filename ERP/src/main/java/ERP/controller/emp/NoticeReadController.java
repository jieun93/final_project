package ERP.controller.emp;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ERP.service.emp.INoticeService;
import board.service.IBoardService;
import vo.BoardVO;
import vo.PagingVO;
import vo.SearchVO;
import vo.emp.EmployeeVO;
import vo.emp.NoticeVO;

@Controller
@RequestMapping("/notice")
public class NoticeReadController {
	@Inject
	INoticeService service;
	
	@GetMapping(produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<NoticeVO> ajaxForlist(
		@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
		SearchVO searchVO, Model model
		){
		list(currentPage, searchVO, model);
		return (PagingVO<NoticeVO>) model.asMap().get("pagingVO");
	}
	@GetMapping
	public String list(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			SearchVO searchVO, Model model
			){
		PagingVO<NoticeVO> pagingVO = new PagingVO<>();
		pagingVO.setSearchVO(searchVO);
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = service.readNoticeCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<NoticeVO> prodList = service.readNoticeList(pagingVO);
		pagingVO.setDataList(prodList);
		
		model.addAttribute("pagingVO", pagingVO);
		
		return "emp/noticeList";
	}
	
	
	
	@GetMapping("{notice_no}")
	public String view(@PathVariable(required = true)  int notice_no, 
			Model model,
			HttpSession session
			) {
		EmployeeVO emp = (EmployeeVO) session.getAttribute("authUser");
		
		NoticeVO notice = service.readNotice(notice_no);
		model.addAttribute("notice", notice);
		return "emp/noticeView";
	}
	
	
	
	
	
	
	
}











