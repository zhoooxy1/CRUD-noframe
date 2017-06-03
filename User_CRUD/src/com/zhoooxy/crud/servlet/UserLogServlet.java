package com.zhoooxy.crud.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.mysql.cj.api.Session;
import com.zhoooxy.crud.mgr.UserMgr;
import com.zhoooxy.crud.model.User;

public class UserLogServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		if (action != null && action.trim().equals("userlog")) {
			String username = req.getParameter("logid");
			String email = req.getParameter("logid");
			String password = req.getParameter("logpwd");
			User u = new User();
			u.setEmail(email);
			u.setUserName(username);
			u.setPassWord(password);
			User user= UserMgr.getUserMgr().findUser(u);
			JSONObject jb = new JSONObject();
			if(user != null ){
				if(u.getPassWord().equals(user.getPassWord())){
					req.getSession().setAttribute("Userlog", user);
					jb.put("code", 1);
				}else{
					jb.put("code", -1);
				}
			}else{
					jb.put("code", -1);
			}
			resp.setContentType("text/html;charset=UTF-8");
			PrintWriter out = resp.getWriter();
			out.print(jb);
			System.out.print(jb + req.getParameter("logpwd") + req.getParameter("logid"));
			out.flush();
			out.close();
			/*
			 * String login_suc = "success.jsp"; resp.sendRedirect(login_suc);
			 */
			return;
		}
	}

}
