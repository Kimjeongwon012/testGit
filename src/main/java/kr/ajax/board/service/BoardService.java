package kr.ajax.board.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ajax.board.dao.BoardDAO;
import kr.ajax.board.dto.BoardDTO;

@Service
public class BoardService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	String upload_root = "C:/upload/";

	@Autowired BoardDAO boardDAO;
	
	public List<BoardDTO> list() {
		return boardDAO.list();
	}

	public int delList(List<String> delList) {
		int cnt = 0; 
		for (String idx : delList) {
			// 2. 그렇기 떄문에 먼저 photo 테이블에서 서버에 저장된 파일명을 가져와야한다
			List<String> files = boardDAO.getFiles(idx);
			// 1. bbs 의 한행을 삭제하면 자식인 photo, author 테이블의 정보도 사라진다
			// boardDAO.delete(del_PostIdx);
			// 3. 저장된 파일들을 삭제한다
			cnt += boardDAO.del(idx);
			logger.info("files : {}", files);
			delFile(files);
		}
		return cnt;
	}
	
	private void delFile(List<String> files) {
		for(String name : files) {
			File file = new File(upload_root + name);
			if(file.exists()) {
				file.delete();
			}
		}
	}
		

}
