package egovframework.let.login.web;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.let.regist.service.RegistService;
import egovframework.let.regist.service.RegistVO;
import egovframework.let.uat.uia.service.EgovLoginService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class LoginController {

	@Resource(name="loginService")
	private EgovLoginService loginService;
	
	@Resource(name= "egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	@Resource(name="registService")
	private RegistService registService;
	
	//로그인
	@RequestMapping(value="/login/actionLogin.do")
	public String actionLogin(@ModelAttribute("loginVO") LoginVO loginVO, HttpSession session,ModelMap model, @RequestHeader("Referer") String referer)throws Exception{
			
		
		//로그인한 사람의 상세정보를가져옴
		LoginVO resultVO=loginService.actionLogin(loginVO);
		
		//상세정보가 있으면
		if(resultVO !=null && resultVO.getId() !=null && !resultVO.getId().equals("")) {
			//세션에 담아줌
			session.setAttribute("LoginVO", resultVO);
			
			//jsp로 전송
			return "redirect:" + referer; // /home.do";
		}else {
			//없으면 메세지를 전송함
			//단순히 문자열이 아니라 만들어진 코드를 출력해줌,국제화 규격을 위해 만들어놓은 코드를 가져와서 씀
			model.addAttribute("loginMessage",egovMessageSource.getMessage("fail.common.login"));
			return "redirect:" + referer;
		}
	}
	
	//로그아웃
	@RequestMapping(value="/login/actionLogout.do")
	public String actionLogout(HttpSession session,ModelMap model, @RequestHeader("Referer") String referer,RegistVO vo)throws Exception{
		
		//세션의 "LoginVO"로 담긴 정보만 지우는 코드
		//RequestContextHolder.getRequestAttributes().removeAttribute("LoginVO",RequestAttributes.SCOPE_SESSION);
		
		//그냥 세션에 담긴 정보를 전부 날리는 코드
		session.invalidate();
		
		vo.setGrant("no");
		
		return "redirect:/home.do";
	}
}