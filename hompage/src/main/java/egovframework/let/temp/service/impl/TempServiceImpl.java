package egovframework.let.temp.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.FileVO;
import egovframework.let.cop.bbs.service.Board;
import egovframework.let.cop.bbs.service.BoardVO;
import egovframework.let.cop.bbs.service.EgovBBSManageService;
import egovframework.let.temp.service.TempService;
import egovframework.let.temp.service.TempVO;
import egovframework.let.utl.fcc.service.EgovDateUtil;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;


@Service("tempService")
public class TempServiceImpl extends EgovAbstractServiceImpl
implements TempService {

	@Resource(name ="tempMapper")
	private TempMapper tempMapper;
	
	@Resource(name ="tempDAO")
	private TempDAO tempDAO;
	
	@Override
	public TempVO selectTemp(TempVO vo)	throws Exception{
		return tempMapper.selectTemp(vo);
	}
	
	public List<EgovMap> selectTempList(TempVO vo) throws Exception{
		return tempMapper.selectTempList(vo);
	}
	
	public String insertTemp(TempVO vo) throws Exception{
		tempMapper.insertTemp(vo);
		return null;
	}
	
	public void updateTemp(TempVO vo) throws Exception{
		tempMapper.updateTemp(vo);
		
	}
	
	public void deleteTemp(TempVO vo) throws Exception{
		tempMapper.deleteTemp(vo);
		
	}
	
	public int selectTempListCnt(TempVO vo) throws Exception{
		return tempMapper.selectTempListCnt(vo);
		
	}
	
//	@Override
//	public TempVO selectTemp(TempVO vo)	throws Exception{
//		return tempDAO.selectTemp(vo);
//	}
	
	
   
}
