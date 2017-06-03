package test.java;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.junit.Test;

import com.zhoooxy.crud.util.DB;


public class test {

	@Test
	public void testMod(){
		String sql = "select count(*) as c from t_user where username = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DB.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "sss");
			rs = pstmt.executeQuery();
			while(rs.next()){
				int i = rs.getInt(1);
				System.out.print(i);
				}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
	}
	
}
