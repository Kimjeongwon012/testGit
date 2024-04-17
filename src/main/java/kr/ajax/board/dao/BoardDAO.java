package kr.ajax.board.dao;

import java.util.List;

import kr.ajax.board.dto.BoardDTO;

public interface BoardDAO {

	List<BoardDTO> list();

	List<String> photo(String del_PostIdx);

	void delete(String del_PostIdx);

	int del(String idx);

	List<String> getFiles(String idx);

}
