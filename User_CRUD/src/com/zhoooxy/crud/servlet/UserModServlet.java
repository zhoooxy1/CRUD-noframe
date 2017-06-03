package com.zhoooxy.crud.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.zhoooxy.crud.mgr.UserMgr;
import com.zhoooxy.crud.model.User;

public class UserModServlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		if (action != null && action.trim().equals("usermod")) {
			String email = req.getParameter("email");
			String username = req.getParameter("modname");
			User u = new User();
			u.setEmail(email);
			u.setUserName(username);
			Boolean exist = UserMgr.getUserMgr().UserModExist(u);
			User user = UserMgr.getUserMgr().findUser(u);
			JSONObject jb = new JSONObject();
			if(exist){
					jb.put("code", -1);
			}else{
				req.getSession().setAttribute("Userlog", user);
					jb.put("code", 1);
			}
			resp.setContentType("text/html;charset=UTF-8");
			PrintWriter out = resp.getWriter();
			out.print(jb);
			out.flush();
			out.close();
			return;
		}
	}

}

