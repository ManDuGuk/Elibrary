package egovframework.let.board.web;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.board.service.BoardService;
import egovframework.let.board.service.BoardVO;
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


@Controller
public class BoardController {

	
	@Resource(name = "boardService")
    private BoardService boardService;
	
	@Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;
	
	@Resource(name ="fileMngUtil")
	private FileMngUtil fileUtil;
	
	
	//게시물 목록 가져오기
	@RequestMapping(value = "/board/selectList.do")
	public String selectList(@ModelAttribute("searchVO") BoardVO searchVO,  
			HttpServletRequest request, ModelMap model) throws Exception{
		
		//공지 게시글
		searchVO.setNoticeAt("Y");
		//모든 공지글을 가져온다.
		List<EgovMap> noticeResultList = boardService.selectBoardList(searchVO);
		model.addAttribute("noticeResultList", noticeResultList);
		
		//페이지 네이션		
		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		//공지 게시글 아닌것
		searchVO.setNoticeAt("N");
		//모든 일반글을 가져온다.
		List<EgovMap> resultList = boardService.selectBoardList(searchVO);
		model.addAttribute("resultList", resultList);
		
		int totCnt = boardService.selectBoardListCnt(searchVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		//페이지 네이션
		
		//회원정보를 가져온다.
		LoginVO user=(LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		model.addAttribute("USER_INFO", user);
		//
		return "board/BoardSelectList";
	}
	
	
	//메인페이지
	@RequestMapping(value = "/home.do")
	public String home(@ModelAttribute("searchVO") BoardVO searchVO,ModelMap model,RegistVO vo) throws Exception{	
		
		//디비의 list정보를 가져와서 쏴줌
		List<EgovMap> resultList = boardService.selectAllBoardList(searchVO);
		System.out.println(resultList);
		model.addAttribute("resultList", resultList);
		
		//vo정보를 가져와서 쏴줌
		model.addAttribute("registVO",vo);
		
		return "board/Home";
	}

	//게시물 등록/수정
	@RequestMapping(value = "/board/boardRegist.do")
	public String boardRegist(@ModelAttribute("searchVO") BoardVO BoardVO, 
		HttpServletRequest request, ModelMap model) throws Exception{
		
		//로그인 관련
		//로그인에 대한 정보(세션에 저장되어있음)를 가져온다.
		LoginVO user=(LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		//유저가 없거나 아이디가 없으면
		if(user==null||user.getId()==null) {
			model.addAttribute("adiminmessage","관리자 로그인이 필요합니다.");
			//로그인후 사용가능하게 돌려보낸다.
			return "forward:/board/selectList.do";
		}else {
			model.addAttribute("USER_INFO",user);
		}
		
		BoardVO result = new BoardVO();
		if(!EgovStringUtil.isEmpty(BoardVO.getBoardId())) {
			
			result = boardService.selectBoard(BoardVO);
			//본인 및 관리자만 허용(변조 방지)
			//유저아이디와 관리자 아이디와 같지 않으면
			if(!user.getId().equals(result.getFrstRegisterId()) && !"admin".equals(user.getId())) {
				//작성자 본인만 확인 가능
				model.addAttribute("adiminmessage","관리자 로그인이 필요합니다.");
				//그리고 리스트로 돌려보낸다.
				return "forward:/board/selectList.do";
			}
		}
		model.addAttribute("result", result);
		
		//아래 인설트의 //이중 서브밋 방지 체크 에서 이어지는 내용이다.
		//글쓰기 페이지나 수정하는 페이지로 이동될시 세션을 지워준다. 세센이 삭제되어다 다시 등록이 가능하니까 들어가는 것이다.
		//즉 f5아 아닌 글쓰기를 통해서 들어가는 등록은 가능하게 만들어주는 코드이다.
		request.getSession().removeAttribute("sessionBoard");
		
		return "board/BoardRegist";
	}
	
	//게시물 등록하기
	@RequestMapping(value = "/board/insert.do")
	public String insert(final MultipartHttpServletRequest multiRequest,@ModelAttribute("searchVO") BoardVO searchVO, 
		HttpServletRequest request, ModelMap model) throws Exception{
		
		//이중 서브밋 방지 체크 (f5누르면 계속 등록 되는거 방지하기위해서)
		//2.다시 f5를 누른순간 sessionBoard에 들어가있는 파라미터값이 있는지 여부를 검사해서 중복등록되지 않게 루트를 짰다.
		if(request.getSession().getAttribute("sessionBoard") !=null) {
			return "forward:/board/selectList.do";
		}
		
		//로그인 정보를 가져와서
		//로그인이 풀려있는지 검사한다. 작성하다가 밥먹으로 가거나 오랜시간이 흐르면 자동으로 로그 아웃되게 만드는 기능이 있다고 하면
		//로그인이 풀려있을것이고 해당 유무를 검사해서 다시 로그인 하겠끔 루트를 짠다.
		//여기서 로그인후 다시 메인으로 돌려보낼지 중단지점으로 다시 보낼지 루트를 짜는것이다.
		LoginVO user=(LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		//유저가 없거나 아이디가 없으면
		if(user==null||user.getId()==null) {
			model.addAttribute("adiminmessage","관리자 로그인이 필요합니다.");
			//로그인후 사용가능하게 돌려보낸다.
			return "forward:/board/selectList.do";
		}
		
		List<FileVO> result =null;
		String atchFileId="";
		
		final Map<String,MultipartFile> files = multiRequest.getFileMap();
		if(!files.isEmpty()) {
			result=fileUtil.parseFileInf(files, "BOARD_", 0, "", "board.fileStorePath");
			atchFileId =fileMngService.insertFileInfs(result);
		}
		searchVO.setAtchFileId(atchFileId);
	
		
		
		//작성자 기준의 아이피를 셋한다. 이코드는 공인 아이피주소를 넣는다.
		searchVO.setCreatIp(request.getRemoteAddr());
		//유저 아이디에 셋한다. 이는 나중에 firstRegistId랑 lastRegistId 이런 곳에 쓰인다.
		searchVO.setUserId(user.getId());
		
		//인설트시행
		boardService.insertBoard(searchVO);
		
		//이중 서브밋 방지
		//1.등록이 일어날때 파라미터를 세션에 저장한다.
		request.getSession().setAttribute("sessionBoard", searchVO);
		//그리고 다시 리스트로 이동시킨다. 
		return "forward:/board/selectList.do";
	}
	
	//board 가져오기
	//regist 유저정보 가져오기(세션에 담긴값확인)
	@RequestMapping(value = "/board/select.do")
	public String select(@ModelAttribute("searchVO") BoardVO searchVO, HttpServletRequest request, ModelMap model,HttpSession session) throws Exception{
		
		//로그인 유저정보를 받아온다.
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		//jsp로 넘겨준다.
		model.addAttribute("USER_INFO", user);
		
		//세션에 저장된 유저의 정보를 가져와서 ,jsp로 쏴준다.
		RegistVO registVO=(RegistVO)session.getAttribute("inputVO");
		
		//쏴주기전에 한번 콘솔로 출력해서 확인해보자 //로그인하고 눌러보면 값이 잘넘어가는걸 확인했다.
		System.out.println(registVO);
		//쏴주자
		model.addAttribute("registVO",registVO);
		
		//게시물의 상세정보를 가져온다.쿼리를 타고 가져온다.
		BoardVO result=boardService.selectBoard(searchVO);
		
		//비밀글 여부 체크
		if("Y".equals(result.getOthbcAt())) {
			//본인 및 관리자만 허용
			if(user ==null || user.getId() ==null || (!user.getId().equals(user.getId()) && !"admin".equals(user.getId()))) {
				//if문을 통해 걸러진 허용권한이 없는 사람에겐 메세지 전송
				model.addAttribute("adiminmessage","관리자 로그인이 필요합니다.");
				return "forward:/board/selectList.do";
			}
			
		}
		model.addAttribute("result",result);
		
		//memo.do에서도 쓰게하기위해서
		//세션에다가도 담아주자
		session.setAttribute("selectVO", result);
		
		return "board/BoardSelect";
	}
	
	
	//board게시물 수정하기
	@RequestMapping(value = "/board/update.do")
	public String update(final MultipartHttpServletRequest multiRequest,@ModelAttribute("searchVO") BoardVO searchVO, HttpServletRequest request, ModelMap model) throws Exception{
		
	
		//이중 서브밋 방지 체크 (f5누르면 계속 등록 되는거 방지하기위해서)
		//2.다시 f5를 누른순간 sessionBoard에 들어가있는 파라미터값이 있는지 여부를 검사해서 중복등록되지 않게 루트를 짰다.
		if(request.getSession().getAttribute("sessionBoard") !=null) {
			return "forward:/board/selectList.do";
		}
		
		//로그인 유저정보를 받아온다.
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		
		//유저가 없거나 아이디가 없으면
		if(user==null||user.getId()==null) {
			model.addAttribute("adiminmessage","관리자 로그인이 필요합니다.");
			//로그인후 사용가능하게 돌려보낸다.
			return "forward:/board/selectList.do";
		//관리자가 유저의 아이디와 같다면	
		}else if("admin".equals(user.getId())) {
			//MnAt는 관리자 여부 = y
			searchVO.setMngAt("Y");
		}
		
		String atchFileId=searchVO.getAtchFileId();
		final Map<String,MultipartFile> files= multiRequest.getFileMap();
		if(!files.isEmpty()) {
			if(EgovStringUtil.isEmpty(atchFileId)) {
				List<FileVO> result =fileUtil.parseFileInf(files, "BOARD_", 0,"","board.fileStorePath");
				atchFileId=fileMngService.insertFileInfs(result);
				searchVO.setAtchFileId(atchFileId);
			}else {
				FileVO fvo=new FileVO();
				fvo.setAtchFileId(atchFileId);
				int cnt=fileMngService.getMaxFileSN(fvo);
				List<FileVO> _result=fileUtil.parseFileInf(files, "BOARD_", cnt,atchFileId,"board.fileStorePath");
				fileMngService.updateFileInfs(_result);
			}
		}
		
		
		//유저 아이디에 셋한다.
		searchVO.setUserId(user.getId());
		
		boardService.updateBoard(searchVO);
		
		//이중 서브밋 방지
		//1.등록이 일어날때 파라미터를 세션에 저장한다.
		request.getSession().setAttribute("sessionBoard", searchVO);
		//그리고 다시 리스트로 이동시킨다. 
		return "forward:/board/select.do";
	}
	
	//board게시물 삭제하기
		@RequestMapping(value = "/board/delete.do")
		public String delete(@ModelAttribute("searchVO") BoardVO searchVO, HttpServletRequest request, ModelMap model) throws Exception{
			
			
			//로그인 유저정보를 받아온다.
			LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
			
			//유저가 없거나 아이디가 없으면
			if(user==null||user.getId()==null) {
				model.addAttribute("adiminmessage","관리자 로그인이 필요합니다.");
				//로그인후 사용가능하게 돌려보낸다.
				return "forward:/board/selectList.do";
			//관리자가 유저의 아이디와 같다면	
			}else if("admin".equals(user.getId())) {
				//MnAt는 관리자 여부 = y
				searchVO.setMngAt("Y");
			}
			
			//유저 아이디에 셋한다.
			searchVO.setUserId(user.getId());
			
			boardService.deleteBoard(searchVO);
			
			//그리고 다시 리스트로 이동시킨다. 
			return "forward:/board/selectList.do";
		}
	
	
			
		//로그인	
		@RequestMapping(value = "/login.do")
		public String index(HttpServletRequest request, ModelMap model) throws Exception {
			
			LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
			model.addAttribute("USER_INFO", user);
			
			return "board/Index";
		}		
		
				
		//구글맵
		@RequestMapping(value = "/map.do")
		public String map() throws Exception{			
			return "board/GoogleMap";
		}
	
		//슬라이드 테스트
		@RequestMapping(value = "/slide.do")
		public String slide() throws Exception{			
			return "board/Slide";
		}
	
		//찜버튼 누를시 유저의 id정보를 보드의 찜속성에다가 저장하는 과정	
		@RequestMapping(value = "/memo.do")
		public String memo(@ModelAttribute("searchVO") BoardVO searchVO,HttpSession session,ModelMap model,@RequestHeader("Referer") String referer) throws Exception {
			
			//세션을 불러와서 값을 받고 
			RegistVO registVO=(RegistVO)session.getAttribute("inputVO");
			//유저 아이디를 가져오고
			String registId=registVO.getRegistId();
			
			//확인
			//System.out.println("momo.do에서 받아온 아이디"+registId);
			
			//세션에 저장된 보드의 vo값을 받아오고
			BoardVO selectVO=(BoardVO)session.getAttribute("selectVO");
		
			//확인
			//System.out.println(selectVO);
			
			
			//boarVO안에다가 set해준다.
			selectVO.setMemoId(registId);
			
			//확인
			//System.out.println(selectVO);
			
			//보드디비에 인서트 해주고 업데이트시 boarVO 객체를 넘긴다.
			boardService.updateMemo(selectVO);
			
			
			//게시물의 상세정보를 가져온다.쿼리를 타고 가져온다.
			BoardVO result=boardService.selectBoard(searchVO);
			//세션 업데이트해준다.
			session.setAttribute("selectVO",result );
			
			return "redirect:" + referer;
		}
		
		//찜버튼 누를시 찜속성에 있던 유저의 id정보를 삭제하는  
		@RequestMapping(value = "/delmemo.do")
		public String delmemo(@ModelAttribute("searchVO") BoardVO searchVO,HttpSession session,ModelMap model,@RequestHeader("Referer") String referer) throws Exception {
			
			//확인
			//System.out.println("momo.do에서 받아온 아이디"+registId);
			
			//세션에 저장된 보드의 vo값을 받아오고
			BoardVO selectVO=(BoardVO)session.getAttribute("selectVO");
		
			//확인
			//System.out.println(selectVO);
			
			
			//확인
			//System.out.println(selectVO);
			
			
			//보드디비에 인서트 해주고 딜리트시 boarVO 객체를 넘긴다.
			boardService.delmemo(selectVO);
			
			//게시물의 상세정보를 가져온다.쿼리를 타고 가져온다.
			BoardVO result=boardService.selectBoard(searchVO);
			//세션 업데이트해준다.
			session.setAttribute("selectVO",result );
			
			return "redirect:" + referer;
		}
		
		
	
	
}