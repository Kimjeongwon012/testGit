package kr.ajax.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.ajax.board.dto.BoardDTO;
import kr.ajax.board.service.BoardService;

@Controller
public class BoardController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired BoardService boardService;
	
	// 동기 방식
	@RequestMapping(value="/") // "/" 요청이 오면..
	public String list(Model model) {
		logger.info("list 요청");
		//List<BoardDTO> list = boardService.list(); // 데이터를 담아서
		//model.addAttribute("list", list); // 모델에 실어서
		return "list"; // 페이지를 보여준다 (동기 방식)
	}
	
	// 비동기 방식 : 일단 페이지에 도착한 다음
	@RequestMapping(value="/list.ajax")
	@ResponseBody
	public Map<String,Object> listCall() {
		Map<String,Object> map = new HashMap<String, Object>();
		List<BoardDTO> list = boardService.list();
		map.put("list", list);  
		return map; // map 을 모델처럼 사용하자
	}
	
	// 배열 형태로 들어올 경우 따로 명시를 해줘야 한다
	@RequestMapping(value="/del.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> del(@RequestParam(value="delList[]") List<String> delList) {
		Map<String,Object> map = new HashMap<String,Object>();
		logger.info("del list : {}", delList);
		int deleteCount = boardService.delList(delList);
		map.put("cnt", deleteCount); 
		return map; // 프론트엔드에게 게시글을 몇개 지웠는지 알려주고
		// 그에 대한 사용자에게 알려줄 메시지는 프론트엔드에서 정한다!
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
