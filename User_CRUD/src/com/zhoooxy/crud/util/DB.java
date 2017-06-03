package com.zhoooxy.crud.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DB {
	
	public static Connection getConnection(){
		Connection conn = null;
		try{
			Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/znt?"
						+ "useUnicode=true&characterEncoding=utf-8&useSSL=false&serverTimezone=GMT","root","root");
		}catch (SQLException e) {
			e.printStackTrace();
				}
		catch (InstantiationException | IllegalAccessException | ClassNotFoundException e1) {
			e1.printStackTrace();
			}
	return conn;
	}
	
	public static void close(Connection conn){
		if(conn != null){
			try {
				conn.close();
				conn = null;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		}
	
	public static void close(PreparedStatement pstmt){
		if(pstmt != null){
			try {
				pstmt.close();
				pstmt = null;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		}
	
	public static void close(Statement stmt){
		if(stmt != null){
			try {
				stmt.close();
				stmt = null;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		}
	
	public static void close(ResultSet rs){
		if(rs != null){
			try {
				rs.close();
				rs = null;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		}
}
