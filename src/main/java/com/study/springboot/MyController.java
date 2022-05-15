package com.study.springboot;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.springboot.dao.IBoardDao;
import com.study.springboot.dto.BoardDto;

@Controller
public class MyController {
	
	@Autowired
	IBoardDao boardDao;
	
	@RequestMapping("/")
	//@ResponseBody
	public String root() {
		System.out.println("listForm으로 리다이렉트 됨.");
		return "redirect:listForm"; //listForm으로 리다이렉트 됨.
	}
	
	@RequestMapping("/listForm")
	public String listForm( Model model ) {
		List<BoardDto> list = boardDao.list();
		model.addAttribute("list", list);
		
		System.out.println( list );
		
		return "listForm"; //"listForm.jsp"으로 디스패치해줌.
	}
	
	
	@RequestMapping("/writeForm")
	public String writeForm() {
		
		return "writeForm"; //"writeFrom.jsp"으로 디스패치해줌.
	}
	
	@RequestMapping("/writeAction")
	public String writeAction( @RequestParam("board_name") String board_name,
								@RequestParam("board_title") String board_title,
								@RequestParam("board_content") String board_content, 
								HttpServletRequest request) 
	{
		int result = boardDao.write(board_name, board_title, board_content);
		if( result == 1) {
			System.out.println("글쓰기 성공!");
			request.getSession().setAttribute("alert_message", "글쓰기 성공!");
			return "redirect:listForm"; //listForm으로 리다이렉트 됨.
		} else {
			System.out.println("글쓰기 실패!");
			request.getSession().setAttribute("alert_message", "글쓰기 실패!");
			return "redirect:writeForm"; //contentForm으로 리다이렉트 됨.
		}
	}
	
	@RequestMapping("/contentForm")
	public String contentForm( @RequestParam("board_idx") String board_idx, 
								Model model) 
	{
		BoardDto dto = boardDao.viewDto( board_idx );
		System.out.println( dto );
		
		model.addAttribute("dto", dto);
		
		return "contentForm"; //"contentFrom.jsp"으로 디스패치해줌.
	}
	
	@RequestMapping("/updateAction")
	public String updateAction( @RequestParam("board_idx") String board_idx,
								@RequestParam("board_name") String board_name,
								@RequestParam("board_title") String board_title,
								@RequestParam("board_content") String board_content,
								HttpServletRequest request ) {
		
		int result = boardDao.updateDto(board_idx,board_name, board_title, board_content);
		if( result == 1) {
			System.out.println("글수정 성공!");
			request.getSession().setAttribute("alert_message", "글수정 성공!");
			return "redirect:listForm"; //listForm으로 리다이렉트 됨.
		} else {
			System.out.println("글수정 실패!");
			request.getSession().setAttribute("alert_message", "글수정 실패!");
			return "redirect:contentForm?board_idx=" + board_idx; //contentForm으로 리다이렉트 됨.
		}
	}
		
		@RequestMapping("/deleteAction")
		public String deleteAction( @RequestParam("board_idx") String board_idx,
									HttpServletRequest request ) {
			
			int result = boardDao.deleteDto(board_idx);
			if( result == 1) {
				System.out.println("글삭제 성공!");
				request.getSession().setAttribute("alert_message", "글삭제 성공!");
				return "redirect:listForm"; //listForm으로 리다이렉트 됨.
			} else {
				System.out.println("글삭제 실패!");
				request.getSession().setAttribute("alert_message", "글삭제 실패!");
				return "redirect:contentForm?board_idx=" + board_idx; //contentForm으로 리다이렉트 됨.
			}
	}
}