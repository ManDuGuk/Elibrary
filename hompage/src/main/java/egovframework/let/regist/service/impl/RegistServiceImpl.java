package egovframework.let.regist.service.impl;


import egovframework.let.board.service.BoardService;
import egovframework.let.board.service.BoardVO;
import egovframework.let.crud.service.CrudService;
import egovframework.let.crud.service.CrudVO;
import egovframework.let.regist.service.RegistService;
import egovframework.let.regist.service.RegistVO;
import egovframework.let.temp2.service.Temp2Service;
import egovframework.let.temp2.service.Temp2VO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;


@Service("registService")
public class RegistServiceImpl extends EgovAbstractServiceImpl implements RegistService {

    @Resource(name="registMapper")
	private RegistMapper registMapper;
    

	@Override
	public List<EgovMap> selectRegistList(RegistVO vo) throws Exception {
		return registMapper.selectRegistList(vo);
	}


	@Override
	public int doinsertregist(RegistVO vo) {
		return registMapper.doinsertregist(vo);
		
	}


	@Override
	public int updateregist(RegistVO vo) {
		// TODO Auto-generated method stub
		return registMapper.updateregist(vo);
	}


	@Override
	public int deleteregist(RegistVO vo) {
		// TODO Auto-generated method stub
		return registMapper.deleteregist(vo);
	}
    

}
