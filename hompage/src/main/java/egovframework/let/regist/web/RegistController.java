package egovframework.let.regist.web;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.board.service.BoardService;
import egovframework.let.board.service.BoardVO;
import egovframework.let.regist.service.RegistService;
import egovframework.let.regist.service.RegistVO;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.let.utl.fcc.service.FileMngUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
public class RegistController {

	//레지스트의 서비스
	@Resource(name = "registService")
    private RegistService registService;
	
	//보드의 서비스
	@Resource(name = "boardService")
    private BoardService boardService;

	
	//회원 리스트확인
	//보드 리스트확인
	@RequestMapping(value = "/regist.do")
	public String regist(@ModelAttribute("searchVO") RegistVO searchVO,ModelMap model,@ModelAttribute("boardVO") BoardVO boardVO,HttpSession session) throws Exception{	
		
		//보드에 있는 모든 값을 담은 리스트를 모델로 넘기고 세션에도 담았다.
		List<EgovMap> myboardselectlist = boardService.selectAllBoardList(boardVO);
		model.addAttribute("myboardselectlist", myboardselectlist);
		session.setAttribute("myboardselectlist", myboardselectlist);
		
		//registDB에 있는 값을 확인하기 위해 리스트에 담아왔다.
		List<EgovMap> registList = registService.selectRegistList(searchVO);
		model.addAttribute("registList", registList);
		
		
		
		
		return "board/RegistList";
	}
	
	//회원 회원가입
	@RequestMapping(value = "/insertregist.do")
	public String insertregist() throws Exception{	
	
		//회원정보를 입력할수있는 jsp로 보내자
		
		
		
		return "board/RegistInput";
	}
	
	//회원 회원가입 처리
		@RequestMapping(value = "/doinsertregist.do")
		public String doinsertregist(RegistVO vo,ModelMap model) throws Exception{	
		
			if(egovframework.rte.fdl.string.EgovStringUtil.isEmpty(vo.getRegistId())) {
				model.addAttribute("message", "id정보가없습니다.");
				return "forward:/insertregist.do";
			} else if(egovframework.rte.fdl.string.EgovStringUtil.isEmpty(vo.getRegistPw())) {
				model.addAttribute("message", "pw정보가없습니다.");
				return "forward:/insertregist.do";
			} else if (egovframework.rte.fdl.string.EgovStringUtil.isEmpty(vo.getRegistName())) {
				model.addAttribute("message", "Name정보가없습니다.");
				return "forward:/insertregist.do";
			}
			
			//service부터 시작해서 디비까지 도달하는 메소드를 하나 만들자
			registService.doinsertregist(vo);
			
			return "redirect:/home.do";
		}
	
	//유저로그인	
	@RequestMapping(value = "/userlogin.do")
	public String userlogin() throws Exception {
		//해당 .do는 입력을 받을수 있는 화면으로 보낸다.	
		return "board/UserLogin";
	}	
	
	
	//입력한 값과 디비의 값을 비교해서 일치하는지의 차이를 보기위한 컨트롤러
	//일단은 아이디만 비교하게했는데 비번 비교한는 코드로 수정해야한다.
	@RequestMapping(value = "/contrast.do")
	public String contrast(@ModelAttribute("searchVO") RegistVO searchVO, ModelMap model,RegistVO vo,RedirectAttributes redirect,HttpSession session, @RequestHeader("Referer") String referer) throws Exception {
		
		//디비에 저장되어있는값 //확인을 위해 모델로 넘김
		List<EgovMap> registList = registService.selectRegistList(searchVO);
		model.addAttribute("registList", registList);
		
		//입력으로 넘어온값 //확인을 위해 모델로 점김
		model.addAttribute("userVo",vo);
		
		//디비의 id값과 입력의 id값 비교 // 대조결과를 모델로 넘김
		String inputId=vo.getRegistId();
		String inputPw=vo.getRegistPw();
		
		String yesNo="";
		for(int i=0; i<registList.size(); i++) {
			 String listId=registList.get(i).get("registId").toString();
			 if(inputId.equals(listId)) {
				yesNo="아이디가 일치합니다.";
				
				//vo에 이름을 추가해줌
				vo.setRegistName(registList.get(i).get("registName").toString());
				
				//vo에 고유id값을 추가해줌
				vo.setId((int)registList.get(i).get("id"));
				
				
				//vo의 사용여부를 추가해줌
				vo.setRegistAt(registList.get(i).get("registAt").toString());
				
				//vo의 권한을 yes로 바꿔줌
				vo.setGrant("yes");
				
								
				//값확인을 위해 모델로 다시 보내봄 나중에 지우면됨
				/*model.addAttribute("userVo2",vo);*/
				
				//세션에 담아줌
				session.setAttribute("inputVO",vo);
				
				//아이디가 일치할시 더이상 for문을 돌지 않고 끝내기 위해 나중엔 비밀번호도 검사해야됨
				break;
			 }
			 //입력id의 스트링값이 admin일시
			 else if(inputId.equals("admin")) {
				 
			
				 
				 /* 기존의 입력값을 입력하고 로그인버튼을 눌렀을시 연결되는 주소
				<form action="/login/actionLogin.do
				  */
				 
				 /* 파라미터를 넘겨주는 이름 id,password
				<div class="ipt-row">
					<input type="text" id="loginId" name="id" placeholder="아이디"  required="required">
				</div>
				<div class="ipt-row">
					<input type="password" id="loginPw" name="password" placeholder="비밀번호" required="required">
				</div>
				  */
				 
				 /*
				 내생각은 vo에 입력된 값을 가져와서 
				 /login/actionLogin.do로 리다이렉트 시키고
				 리타이렉트 시킬시 파라미터의 이름을 id와 password로 변경하여 파라미터값을 넘겨주면 어떨까 생각중임
				  
				 */
				 
				//방법1.직접 loginVO에 set해봄 안됨 
				/*  
				loginVO.setIp(inputId); 
				loginVO.setPassword(inputPw); 
				*/
				redirect.addAttribute("id", inputId);
				redirect.addAttribute("password", inputPw);
				redirect.addAttribute("userSe", "USR");
				
			
				 
				 
				return "redirect:/login/actionLogin.do";
				 
			 }
			 else {
				yesNo="아이디가 일치하지 않습니다.";
			 }
		}
		
		model.addAttribute("result",yesNo);
		
		if("아이디가 일치합니다.".equals(yesNo)) {
			model.addAttribute("loginMessage",vo.getRegistName() + "님 환영합니다.");
			return "forward:/home.do";
		}
		
		
		return "board/contrast";
	}		

	//회원 정보수정
	@RequestMapping(value = "/updateregist.do")
	public String updateregist(RegistVO vo,HttpSession session, ModelMap model) throws Exception{	
		
		//넘어온값 확인차
		System.out.println(vo);
		
		//입력으로 넘어온값을 받아서 업데이트 메소드 시행
		registService.updateregist(vo);
		
		//세션비우기//다시로그인 하겠끔
		session.invalidate();
		
		
		return "redirect:/home.do";
	}
	
	//회원 정보삭제
	@RequestMapping(value = "/deleteregist.do")
	public String deleteregist(RegistVO vo,HttpSession session, ModelMap model) throws Exception{	
		
		//넘어온값 확인차
		System.out.println(vo);
		
		//입력으로 넘어온값을 받아서 업데이트 메소드 시행
		registService.deleteregist(vo);
		
		//세션비우기//다시로그인 하겠끔
		session.invalidate();
		
		
		return "redirect:/home.do";
	}
	
	
	//유저페이지
	@RequestMapping(value = "/userpage.do")
	public String userpage(@ModelAttribute("searchVO") BoardVO searchVO,ModelMap model,HttpSession session,RegistVO vo) throws Exception{	
		
		/* 앤 왜안되는지 잘 모르겠다. 나중에 확인
		RegistVO registvo=(RegistVO)session.getAttribute("inputVO");
		if(egovframework.rte.fdl.string.EgovStringUtil.equals((String)registvo.getGrant(),"no")) {
			model.addAttribute("loginMessage", "2.로그인 하세요");
			return "forward:/home.do";
		}
		*/
		
		//세션을 불러와서 값을 받는다.
		RegistVO registVO=(RegistVO)session.getAttribute("inputVO");
		model.addAttribute("registVO",registVO);
		
		//보드의 리스트를 불러오기 위한 코드
		List<EgovMap> resultList = boardService.selectMemoBoardList(registVO);
		model.addAttribute("resultList", resultList);
		
		
	

		return "board/UserPage";
	}
	
	
}