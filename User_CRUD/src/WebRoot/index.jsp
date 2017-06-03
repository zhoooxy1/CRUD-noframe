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
		        required: "�������û���",
		        minlength: "�û���������������ĸ���"
		        },
		      regpwd: {
		        required: "����������",
		        minlength: "���볤�Ȳ���С�� 5 ����ĸ"
		      	},
		      regpwd2: {
		        required: "����������",
		        minlength: "���볤�Ȳ���С�� 5 ����ĸ",
		        equalTo: "�����������벻һ��"
		      	},
		      regemail: "������һ����ȷ������",
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
    <button id="register">�û�ע��</button>
    <button id="login">�û���¼</button>

		<div id="logerror" style="display:none">
			<p>������û�������</p>
		</div>
		<div id="adderror" style="display:none">
			<p>������û����Ѿ�����</p>
		</div>

    <div id="reg"  style="display:none">
	    <form action="user_add" id="regform" >
	    	<input type="hidden" name="action" value="useradd"/>
	    	<table >
	    		<tr>
	    			<td >����</td>
	    			<td><input name="regemail" id="regemail" type="text" ><tr>
	    			<td >�û���</td>
	    			<td><input name="regname" id="regname" type="password"><tr>
	    			<td >����</td>
	    			<td><input name="regpwd" id="regpwd"  type="password"><tr>
	    			<td >����ȷ��</td>
	    			<td><input name="regpwd2" id="regpwd2" type="password"><tr>
	    			<td colspan="2" >
	    			<input type="button" value="ע��" id="regbut" name="regbut">
	    			</td>
	    	</table>
	    </form>
    </div>
    
	<div id="log" style="display:none">
		<form action="user_log" id="logform">
			<input type="hidden" name="action" value="userlog" />
			<table>
				<tr>
					<td >����or�û���</td>
					<td><input id="logid" name="logid" type="text">
				<tr>
					<td >����</td>
					<td><input id="logpwd" name="logpwd" type="password">
				<tr>
					<td colspan="2"><input type="button" value="��¼"
						id="logbut" name="logbut"  />
				</tr>
			</table>
		</form>
	</div>
	</body>
</html>
