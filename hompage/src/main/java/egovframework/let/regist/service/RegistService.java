package egovframework.let.regist.service;

import java.util.List;
import java.util.Map;

import egovframework.let.temp2.service.Temp2VO;
import egovframework.rte.psl.dataaccess.util.EgovMap;


public interface RegistService {
	

	
	//regist 유저id 리스트 목록 가져오기
	public List<EgovMap> selectRegistList(RegistVO vo)throws Exception;

	public int doinsertregist(RegistVO vo);

	public int updateregist(RegistVO vo);

	public int deleteregist(RegistVO vo);
	
	
	
	
	
	
	
	
	
	
	
}