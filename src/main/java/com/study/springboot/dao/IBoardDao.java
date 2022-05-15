package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.BoardDto;

@Mapper
public interface IBoardDao {
	public List<BoardDto> list();
	public int write(String board_name, String board_title, String board_content);
	public BoardDto viewDto(String board_idx);
	public int updateDto(String board_idx, String board_name, String board_title, String board_content);
	public int deleteDto(String board_idx);
}