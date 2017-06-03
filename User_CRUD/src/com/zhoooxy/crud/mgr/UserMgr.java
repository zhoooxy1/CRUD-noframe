package com.zhoooxy.crud.mgr;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.zhoooxy.crud.model.User;
import com.zhoooxy.crud.util.DB;

public class UserMgr{

	private  static final class inner{ 
		private static final UserMgr instance = new UserMgr();
	}
	
	private UserMgr(){
		
	}
	
	public static final UserMgr getUserMgr(){
		return inner.instance;
	}
	
	
	
	public void addUser(User u){
		PreparedStatement pstmt = null;
		Connection conn = null;
		
		String sql = "insert into t_user (id, username, password, email, rig_date)"
				+ "values(?,?,?,?,?)";
		try {
			conn = DB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, u.getUserId());
			pstmt.setString(2, u.getUserName());
			pstmt.setString(3, u.getPassWord());
			pstmt.setString(4, u.getEmail());
			java.util.Date utilDate = u.getRig_date();
			java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
			pstmt.setDate(5, sqlDate);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.close(pstmt);
			DB.close(conn);
		}
	}

	
	public List<User> getUser() {
		Connection conn = null;
		String sql = "select * from t_user ";
		ResultSet rs = null;
		
		List<User> u = new ArrayList<User>();
		try {
			conn = DB.getConnection();
			rs = conn.createStatement().executeQuery(sql);
			while(rs.next()){
				User user = new User();
				user.setUserId(rs.getString("id"));
				user.setUserName(rs.getString("username"));
				user.setEmail(rs.getString("email"));
				user.setRig_date(rs.getDate("rig_date"));
				u.add(user);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.close(rs);
			DB.close(conn);
		}
		
		return u;
		
	}

	
	public void modUser(User u) {
		PreparedStatement pstmt = null;
		Connection conn = null;
		String sql = "update t_user set username = ? where email = ?";
		try {
			conn = DB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, u.getUserName());
			pstmt.setString(2, u.getEmail());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.close(pstmt);
			DB.close(conn);
		}

	}

	
	public User findUser(User u) {
		String sql = "select * from t_user where username = ? or email = ? ";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		User user = null;
		try {
			conn = DB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, u.getUserName());
			pstmt.setString(2, u.getEmail());
			rs = pstmt.executeQuery();
			while(rs.next()){
				user = new User();
				user.setUserId(rs.getString("id"));
				user.setUserName(rs.getString("username"));
				user.setPassWord(rs.getString("password"));
				user.setEmail(rs.getString("email"));
				user.setRig_date(rs.getDate("rig_date"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return user;
	}
	
	public boolean UserModExist(User u) {
		String sql = "select count(*) as c from t_user where username = ? ";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, u.getUserName());
			rs = pstmt.executeQuery();
			while(rs.next()){
				if(rs.getInt(1) > 0 ){
					return true;
				}else{
					modUser(u);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return false;
	}
	
	public boolean UserAddExist(User u) {
		String sql = "select count(*) as c from t_user where username = ? or email= ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, u.getUserName());
			pstmt.setString(2, u.getEmail());
			rs = pstmt.executeQuery();
			while(rs.next()){
				if(rs.getInt(1) > 0 ){
					return true;
				}else{
					addUser(u);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return false;
	}

	public Boolean varifypwd(User u) {
		String sql = "select * from t_user where email = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, u.getEmail());
			rs = pstmt.executeQuery();
			while(rs.next()){
				String p = rs.getString("password");
				if(u.getPassWord().equals(p)){
					return true;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return false;
	}

	public void modPwd(User u) {
		String sql = "update t_user set password = ? where email = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, u.getPassWord());
			pstmt.setString(2, u.getEmail());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.close(pstmt);
			DB.close(conn);
		}
	}
	
	

}
