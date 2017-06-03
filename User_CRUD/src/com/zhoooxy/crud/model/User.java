package com.zhoooxy.crud.model;

import java.util.Date;

public class User {
	private String UserId;
	private String UserName;
	private String PassWord;
	private String Email;
	private Date rig_date;

	public String getUserId() {
		return UserId;
	}
	public void setUserId(String userId) {
		UserId = userId;
	}
	public String getUserName() {
		return UserName;
	}
	public void setUserName(String userName) {
		UserName = userName;
	}
	public String getPassWord() {
		return PassWord;
	}
	public void setPassWord(String passWord) {
		PassWord = passWord;
	}
	public String getEmail() {
		return Email;
	}
	public void setEmail(String email) {
		Email = email;
	}
	public Date getRig_date() {
		return rig_date;
	}
	public void setRig_date(Date rig_date) {
		this.rig_date = rig_date;
	}

}
