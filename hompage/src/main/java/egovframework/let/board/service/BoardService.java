package egovframework.let.board.service;

import java.util.List;
import java.util.Map;

import egovframework.let.regist.service.RegistVO;
import egovframework.let.temp2.service.Temp2VO;
import egovframework.rte.psl.dataaccess.util.EgovMap;


public interface BoardService {
	

	
	//board 리스트 목록 가져오기
	public List<EgovMap> selectBoardList(BoardVO vo)throws Exception;
	
	
	//board 카운트 게시물 목록수
	public int selectBoardListCnt(BoardVO vo)throws Exception;
	
	//board 게시물 등록하기
	public String insertBoard(BoardVO vo) throws Exception;
	
	
	//board 가져오기
	public BoardVO selectBoard(BoardVO vo) throws Exception;


	//board 게시물 수정하기
	public void updateBoard(BoardVO vo) throws Exception;

	//board 게시물 삭제하기
	public void deleteBoard(BoardVO vo)throws Exception;

	//찜하기 버튼 클릭시 보드디비에 유저아이디값 저장하기
	public void updateMemo(BoardVO selectVO)throws Exception;

	//조건없이 모든 리스트 가져옴
	public List<EgovMap> selectAllBoardList(BoardVO searchVO)throws Exception;
	
	//찜된 리스트가져옴
	public List<EgovMap> selectMemoBoardList(RegistVO registVO)throws Exception;

	//반납버튼 클릭시 보드디비에 저장된 유저 아이디 지우기
	public void delmemo(BoardVO selectVO)throws Exception;
	
	

	
	
	
	
	
	
	
	
	
	
	
}