package egovframework.let.board.service.impl;

import java.util.List;

import egovframework.let.board.service.BoardVO;
import egovframework.let.crud.service.CrudVO;
import egovframework.let.regist.service.RegistVO;
import egovframework.let.temp2.service.Temp2VO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("boardMapper")
public interface BoardMapper {
	
	
	//board 목록 가져오기
	List<EgovMap> selectBoardList(BoardVO vo) throws Exception;
	
	//board 목록 수
	int selectBoardListCnt(BoardVO vo) throws Exception;
	
	//board 게시물 등록
	void insertBoard(BoardVO vo)throws Exception;

	//board 상세정보
	BoardVO selectBoard(BoardVO vo) throws Exception;
	
	//board 조회수 업
	void updateViewCnt(BoardVO vo) throws Exception;

	//board 게시물 수정
	void updateBoard(BoardVO vo)throws Exception;

	//board 게시물 삭제
	void deleteBoard(BoardVO vo)throws Exception;

	//찜하기 버튼 클릭시 보드디비에 유저아이디값 저장하기
	void updateMemo(BoardVO selectVO)throws Exception;

	//조건 없이 모든 리스트 불러오기
	List<EgovMap> selectAllBoardList(BoardVO searchVO)throws Exception;


	List<EgovMap> selectMemoBoardList(RegistVO registVO) throws Exception;

	void delmemo(BoardVO selectVO)throws Exception;

	
	
	

	
	
	
	
	
	
	
}
