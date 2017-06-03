<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@ page import="com.zhoooxy.crud.model.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
User u = (User)request.getSession().getAttribute("Userlog");
if(u == null){
	response.sendRedirect("index.jsp");
	return;
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <base href=<%=basePath %>>
    <title>welcome</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script src="js/jquery-3.2.1.min.js"></script>
	<script src="js/jquery.validate.js"></script>
	<script src="js/messages_zh.js"></script>
	
	<!-- <script src="http://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script> -->
  </head>
  
  <script type="text/javascript">
  
   $(document).ready(function() {
		$("#modify").click(function() {
			$("#mod").show();
		});
	}); 
	
	$(document).ready(function() {
		$("#modifypwd").click(function() {
			$("#modpwd").show();
		});
	}); 
  
  
   $().ready(function() {
  	$("#modform").validate({
	    rules: {
	      modname: {
	        required: true,
	        minlength: 2
	         },
	           },
	    messages: {
	      modname: {
	        required: "请输入用户名",
	        minlength: "用户名必需由两个字母组成"
	         },
	       },
	      });
	
	$("#pwdmodform").validate({
		rules: {
	      npwd: {
	        required: true,
	        minlength: 5
	         },
     	 npwd1: {
	        required: true,
	        minlength: 5,
	        equalTo: "#npwd"
	        },
	     	  },
	    messages: {
	      npwd: {
	        required: "请输入密码",
	        minlength: "密码长度不能小于 5 个字母"
	         },
	      npwd1: {
	        required: "请输入密码",
	        minlength: "密码长度不能小于 5 个字母",
	        equalTo: "两次密码输入不一致"
	         },
	          }
	          });
	          });
	 
	 $(document).ready(function() {
		 $("#modbut").click(function() {
		  	var arr = $('#modform').serialize();
			var b = arr.replace(/%20/g,"");
			b = decodeURIComponent(b);

		  	$.ajax({
					url: "user_mod",     
					 //相当于form表单里面的 action="AdminAction_login"
					type: "post",   
					//相当于form表单里面的 method="post"
					data: b,
					//需要传到Action里面的值
					/* {"username":$("#logid").val(),"email":$("#logid").val(),
					"password":$("#logpwd").val()}, */
					dataType: "json",
					success: function(result) {
						if(result.code == 1){
							 $("#modplace").show();
							 $("#errorplace").hide();
						}else if(result.code == -1){
						 	$("#modplace").hide();
							$("#errorplace").show();
							}
							},
					error: function () {
					console.log("error");
					}
					});
				});
			});

	$(document).ready(function() {
	 	$("#modpwdbut").click(function() {
		 	var arr = $('#pwdmodform').serialize();
		  	$.ajax({
					url: "user_pwdmod",     
					 //相当于form表单里面的 action="AdminAction_login"
					type: "post",   
					//相当于form表单里面的 method="post"
					data: arr,
					//需要传到Action里面的值
					/* {"username":$("#logid").val(),"email":$("#logid").val(),
					"password":$("#logpwd").val()}, */
					dataType: "json",
					success: function(result) {
						if(result.code == 1){
							 $("#pwdmodplace").show();
							 $("#modify").hide();
							 $("#mod").hide();
							 $("#pwderrorplace").hide();
						}else if(result.code == -1){
						 	$("#pwdmodplace").hide();
							$("#pwderrorplace").show();
							}
							},
					error: function () {
					console.log("error");
					}
					});
					});
					});
					
	</script>

  <body>
   <br>welcome!<br>
 	<p>您的邮箱是：<%=u.getEmail() %><br>
	<p>您的用户名是： <%=u.getUserName() %><br>
	<p>您的注册日期是：<%=u.getRig_date() %><br>
	<p>当前在线人数：</p>
	<p>历史在线人数：</p>
  	<button onclick="location.reload();">刷新</button>

  <button id="modify">用户修改</button>

  <div id="mod" style="display:none">
		<form action="user_mod" id="modform" >
			<input type="hidden" name="action" value="usermod" />
				<table>
					<tr>
						<td>邮箱</td>
						<td><input name="email" id="email" type="text" readonly="true" value="<%=u.getEmail() %>" />
					<tr>
						<td>用户名</td>
						<td><input name="modname" id="modname" type="text" value="<%=u.getUserName() %>" />
						<td>
							<div id="errorplace" style="display:none">
								<p>用户名已经存在</p>
							</div>
						</td>
					<tr>
						<td><input type="button" id="modbut" name="modbut"
							value="修改" />
						<td><div id="modplace" style="display:none">
								<p>修改成功</p>
								</div>
				</table>
		</form>
		<button id="modifypwd">密码修改</button>
	</div>
	
	<div id="modpwd" style="display:none">
		<form action="user_pwdmod" id="pwdmodform" >
			<input type="hidden" name="action" value="userpwdmod" />
				<table>
					<tr>
						<td>原始密码</td>
						<td><input name="pwd" id="pwd" type="password"  />
						<td>
							<div id="pwderrorplace" style="display:none">
								<p>密码错误</p>
							</div>
						</td>
					</tr>
					<tr>
						<td>新密码</td>
						<td><input name="npwd" id="npwd" type="password" />
					</tr>
					<tr>
						<td>新密码确认</td>
						<td><input name="npwd1" id="npwd1" type="password" />
					</tr>
					<tr>
						<td><input type="button" id="modpwdbut" name="modpwdbut"
							value="修改" />
						<td><div id="pwdmodplace" style="display:none">
									<p>修改成功</p>
									<a href="index.jsp">请重新登录</a>
							</div>
				</table>
		</form>
		
	</div>
  </body>
    
  