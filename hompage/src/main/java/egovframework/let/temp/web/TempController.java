package egovframework.let.temp.web;
import java.util.List;
import java.util.Map;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.cop.bbs.service.BoardMaster;
import egovframework.let.cop.bbs.service.BoardMasterVO;
import egovframework.let.cop.bbs.service.EgovBBSAttributeManageService;
import egovframework.let.temp.service.TempService;
import egovframework.let.temp.service.TempVO;
import egovframework.let.utl.fcc.service.EgovStringUtil;

import egovframework.rte.fdl.cmmn.exception.EgovBizException;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;


@Controller
public class TempController {

	@Resource(name ="tempService")
	private TempService tempService;
	
	@RequestMapping(value ="/temp/select.do")
	public String select(@ModelAttribute("searchVO") TempVO searchVO,
			HttpServletRequest request, ModelMap model) throws Exception{
		
		TempVO result =tempService.selectTemp(searchVO);
		model.addAttribute("result",result);
		return "temp/TempSelect";
	}
	
	@RequestMapping(value="/temp/selectList.do")
	public String selectList(@ModelAttribute("searchVO") TempVO searchVO,HttpServletRequest request,ModelMap model) throws Exception{
		
//		List<EgovMap> resultList = tempService.selectTempList(searchVO);
//		model.addAttribute("resultList",resultList);
		PaginationInfo paginationInfo =new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		int totCnt=tempService.selectTempListCnt(searchVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo",paginationInfo);
		
		List<EgovMap> resultList = tempService.selectTempList(searchVO);
		model.addAttribute("resultList",resultList);
		
		return "temp/TempSelectList";
	}
	//??????????????? ??????,??????
	@RequestMapping(value="/temp/tempRegist.do")
	public String tempRegist(@ModelAttribute("searchVO") TempVO tempVO,HttpServletRequest request,ModelMap model) throws Exception{
		
		TempVO result=new TempVO();
		if(!EgovStringUtil.isEmpty(tempVO.getTempId())) {
			result=tempService.selectTemp(tempVO);
		}
		model.addAttribute("result",result);
		
		return "temp/TempRegist";
	}
	
	@RequestMapping(value="/temp/insert.do")
	public String insert(@ModelAttribute("searchVO") TempVO searchVO,HttpServletRequest request,ModelMap model) throws Exception{
		
		tempService.insertTemp(searchVO);
		return "forward:/temp/selectList.do";
	}
	
	@RequestMapping(value="/temp/update.do")
	public String update(@ModelAttribute("searchVO") TempVO searchVO,HttpServletRequest request,ModelMap model) throws Exception{
		
		tempService.updateTemp(searchVO);
		return "forward:/temp/selectList.do";
	}
	
	@RequestMapping(value="/temp/delete.do")
	public String delete(@ModelAttribute("searchVO") TempVO searchVO,HttpServletRequest request,ModelMap model) throws Exception{
		
		tempService.deleteTemp(searchVO);
		return "forward:/temp/selectList.do";
	}
	
	//JSTL
	@RequestMapping(value="/temp/jstl.do")
	public String jstl(@ModelAttribute("searchVO") TempVO searchVO,HttpServletRequest request,ModelMap model) throws Exception{
		return "/temp/Jstl";
	}
	//JSTL Import
	@RequestMapping(value="/temp/jstlImport.do")
	public String jstlImport(@ModelAttribute("searchVO") TempVO searchVO,HttpServletRequest request,ModelMap model) throws Exception{
		return "/temp/JstlImport";
	}
	
	
	//2022.07.13 ??????
	
	//ajax??????
	@RequestMapping(value= "/temp/ajaxRegist.do")
	public String tempAjaxRegist(@ModelAttribute("searchVO")TempVO searchVO,HttpServletRequest request,ModelMap model)throws Exception{
		return "/temp/TempAjaxRegist";
	}
	
	//ajax??????
	@RequestMapping(value="/temp/ajaxList.do")
	public String tempAjaxList(@ModelAttribute("searchVO") TempVO searchVO,HttpServletRequest request,ModelMap model)throws Exception{
		//????????????
		if(!EgovStringUtil.isEmpty(searchVO.getTempVal())) {
			tempService.insertTemp(searchVO);
		}
		
		searchVO.setRecordCountPerPage(Integer.MAX_VALUE);
		searchVO.setFirstIndex(0);
		
		List<EgovMap> resultList=tempService.selectTempList(searchVO);
		model.addAttribute("resultList",resultList);
		
		return "/temp/TempAjaxList";
	}
	
}
