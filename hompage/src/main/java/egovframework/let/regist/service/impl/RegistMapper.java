package egovframework.let.regist.service.impl;

import java.util.List;

import egovframework.let.board.service.BoardVO;
import egovframework.let.crud.service.CrudVO;
import egovframework.let.regist.service.RegistVO;
import egovframework.let.temp2.service.Temp2VO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("registMapper")
public interface RegistMapper {
	
	
	//regist 유저id 리스트 목록 가져오기
	public List<EgovMap> selectRegistList(RegistVO vo)throws Exception;

	public int doinsertregist(RegistVO vo);

	public int updateregist(RegistVO vo);

	public int deleteregist(RegistVO vo);


	
	
}
