package com.zhoooxy.crud.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.zhoooxy.crud.mgr.UserMgr;
import com.zhoooxy.crud.model.User;



public class UserAddServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
			if(action != null && action.trim().equals("useradd")) {
				String username = request.getParameter("regname");
				String password = request.getParameter("regpwd");
				String email = request.getParameter("regemail");
				User u = new User();
				u.setUserName(username);
				u.setPassWord(password);
				u.setEmail(email);
				u.setRig_date(new Date());
				boolean exist = UserMgr.getUserMgr().UserAddExist(u);
				JSONObject jb = new JSONObject();
				if(exist){
					jb.put("code", -1);
				}else{
					jb.put("code", 1);
					request.getSession().setAttribute("Userlog",u);
				}
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.print(jb);
				out.flush();
				out.close();
				return;
			}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

	

}
