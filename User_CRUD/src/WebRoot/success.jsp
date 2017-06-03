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
	        required: "�������û���",
	        minlength: "�û���������������ĸ���"
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
	        required: "����������",
	        minlength: "���볤�Ȳ���С�� 5 ����ĸ"
	         },
	      npwd1: {
	        required: "����������",
	        minlength: "���볤�Ȳ���С�� 5 ����ĸ",
	        equalTo: "�����������벻һ��"
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
					 //�൱��form������� action="AdminAction_login"
					type: "post",   
					//�൱��form������� method="post"
					data: b,
					//��Ҫ����Action�����ֵ
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
					 //�൱��form������� action="AdminAction_login"
					type: "post",   
					//�൱��form������� method="post"
					data: arr,
					//��Ҫ����Action�����ֵ
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
 	<p>���������ǣ�<%=u.getEmail() %><br>
	<p>�����û����ǣ� <%=u.getUserName() %><br>
	<p>����ע�������ǣ�<%=u.getRig_date() %><br>
	<p>��ǰ����������</p>
	<p>��ʷ����������</p>
  	<button onclick="location.reload();">ˢ��</button>

  <button id="modify">�û��޸�</button>

  <div id="mod" style="display:none">
		<form action="user_mod" id="modform" >
			<input type="hidden" name="action" value="usermod" />
				<table>
					<tr>
						<td>����</td>
						<td><input name="email" id="email" type="text" readonly="true" value="<%=u.getEmail() %>" />
					<tr>
						<td>�û���</td>
						<td><input name="modname" id="modname" type="text" value="<%=u.getUserName() %>" />
						<td>
							<div id="errorplace" style="display:none">
								<p>�û����Ѿ�����</p>
							</div>
						</td>
					<tr>
						<td><input type="button" id="modbut" name="modbut"
							value="�޸�" />
						<td><div id="modplace" style="display:none">
								<p>�޸ĳɹ�</p>
								</div>
				</table>
		</form>
		<button id="modifypwd">�����޸�</button>
	</div>
	
	<div id="modpwd" style="display:none">
		<form action="user_pwdmod" id="pwdmodform" >
			<input type="hidden" name="action" value="userpwdmod" />
				<table>
					<tr>
						<td>ԭʼ����</td>
						<td><input name="pwd" id="pwd" type="password"  />
						<td>
							<div id="pwderrorplace" style="display:none">
								<p>�������</p>
							</div>
						</td>
					</tr>
					<tr>
						<td>������</td>
						<td><input name="npwd" id="npwd" type="password" />
					</tr>
					<tr>
						<td>������ȷ��</td>
						<td><input name="npwd1" id="npwd1" type="password" />
					</tr>
					<tr>
						<td><input type="button" id="modpwdbut" name="modpwdbut"
							value="�޸�" />
						<td><div id="pwdmodplace" style="display:none">
									<p>�޸ĳɹ�</p>
									<a href="index.jsp">�����µ�¼</a>
							</div>
				</table>
		</form>
		
	</div>
  </body>
    
  