<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href=<%=basePath%>>
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
		$("#register").mouseover(function() {
			$("#reg").show();
			$("#log").hide();
		});
	}); 
	
	$(document).ready(function() {
		$("#login").mouseover(function() {
			$("#reg").hide();
			$("#log").show();
		});
	}); 
	
	$().ready(function() {
		  $("#regform").validate({
		    rules: {
		      regname: {
		        required: true,
		        minlength: 2
		         },
		      regpwd: {
		        required: true,
		        minlength: 5
		          },
		      regpwd2: {
		        required: true,
		        minlength: 5,
		        equalTo: "#regpwd"
		        },
		      regemail: {
		        required: true,
		        email: true
		        },
		        },
		        
		    messages: {
		      regname: {
		        required: "请输入用户名",
		        minlength: "用户名必需由两个字母组成"
		        },
		      regpwd: {
		        required: "请输入密码",
		        minlength: "密码长度不能小于 5 个字母"
		      	},
		      regpwd2: {
		        required: "请输入密码",
		        minlength: "密码长度不能小于 5 个字母",
		        equalTo: "两次密码输入不一致"
		      	},
		      regemail: "请输入一个正确的邮箱",
		       }
		       });
		       });
	 
	 $(document).ready(function() {
		 $("#regbut").click(function() {
			 var arr = $('#regform').serialize();
			 var b = arr.replace(/%20/g,"");
			 b = decodeURIComponent(b);
			
				$.ajax({
					url: "user_add",     
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
							 window.location.href="success.jsp";
						}else if(result.code == -1){
							$("#adderror").show();
							}
							},
					error: function () {
					console.log("error");
					}
					});
					});
					});
		 
	$(document).ready(function() {
		 $("#logbut").click(function() {
			 var arr = $('#logform').serialize();
			 var b = arr.replace(/%20/g,"");
			 b = decodeURIComponent(b);
				
				$.ajax({
					url: "user_log",     
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
							 window.location.href="success.jsp";
						}else if(result.code == -1){
							$("#logerror").show();
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
    <button id="register">用户注册</button>
    <button id="login">用户登录</button>

		<div id="logerror" style="display:none">
			<p>密码或用户名不对</p>
		</div>
		<div id="adderror" style="display:none">
			<p>邮箱或用户名已经存在</p>
		</div>

    <div id="reg"  style="display:none">
	    <form action="user_add" id="regform" >
	    	<input type="hidden" name="action" value="useradd"/>
	    	<table >
	    		<tr>
	    			<td >邮箱</td>
	    			<td><input name="regemail" id="regemail" type="text" ><tr>
	    			<td >用户名</td>
	    			<td><input name="regname" id="regname" type="password"><tr>
	    			<td >密码</td>
	    			<td><input name="regpwd" id="regpwd"  type="password"><tr>
	    			<td >密码确认</td>
	    			<td><input name="regpwd2" id="regpwd2" type="password"><tr>
	    			<td colspan="2" >
	    			<input type="button" value="注册" id="regbut" name="regbut">
	    			</td>
	    	</table>
	    </form>
    </div>
    
	<div id="log" style="display:none">
		<form action="user_log" id="logform">
			<input type="hidden" name="action" value="userlog" />
			<table>
				<tr>
					<td >邮箱or用户名</td>
					<td><input id="logid" name="logid" type="text">
				<tr>
					<td >密码</td>
					<td><input id="logpwd" name="logpwd" type="password">
				<tr>
					<td colspan="2"><input type="button" value="登录"
						id="logbut" name="logbut"  />
				</tr>
			</table>
		</form>
	</div>
	</body>
</html>
