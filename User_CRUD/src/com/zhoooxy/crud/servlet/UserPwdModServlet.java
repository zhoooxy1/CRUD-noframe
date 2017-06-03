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

public class UserPwdModServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		if (action != null && action.trim().equals("userpwdmod")) {
			String password = req.getParameter("pwd");
			String new_password = req.getParameter("npwd");
			User u = (User)req.getSession().getAttribute("Userlog");
			u.setPassWord(password);
			Boolean pwdright = UserMgr.getUserMgr().varifypwd(u);
			JSONObject jb = new JSONObject();
			if(pwdright){
				u.setPassWord(new_password);
				UserMgr.getUserMgr().modPwd(u);
				req.getSession().removeAttribute("Userlog");
					jb.put("code", 1);
			}else{
					jb.put("code", -1);
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
