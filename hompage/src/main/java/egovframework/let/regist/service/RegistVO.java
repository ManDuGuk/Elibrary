package egovframework.let.regist.service;

import java.io.Serializable;

import egovframework.com.cmm.ComDefaultVO;


public class RegistVO extends ComDefaultVO implements Serializable {

	
	//유저id
	private String registId;
	
	//유저pw
	private String registPw;
	
	//유저name
	private String registName;

	//권한 온,오프(기본상태가 no)
	private String grant="no";
	
	//고유한 pk 값인 auto-increment값을 담는
	private int id;
	
	//유저정보의 사용여부를 체크하는 
	private String registAt;
	
	//게터세터
	public String getRegistId() {
		return registId;
	}

	public void setRegistId(String registId) {
		this.registId = registId;
	}

	public String getRegistPw() {
		return registPw;
	}

	public void setRegistPw(String registPw) {
		this.registPw = registPw;
	}

	public String getRegistName() {
		return registName;
	}

	public void setRegistName(String registName) {
		this.registName = registName;
	}

	public String getGrant() {
		return grant;
	}

	public void setGrant(String grant) {
		this.grant = grant;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getRegistAt() {
		return registAt;
	}

	public void setRegistAt(String registAt) {
		this.registAt = registAt;
	}

	

	

	

	
	
	
	
	
	

}