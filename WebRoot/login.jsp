<%@ page language="java" pageEncoding="UTF-8"%>  
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>信息管理系统_用户登录</title>

<link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css" />
<link rel="stylesheet" type="text/css" href="css/login.css" />
</head>
<body>


<div id="login">
	<p>登录帐号：<input type="text"  id="manager" class="textbox"></p>
	<p>登录密码：<input type="password" id="password" class="textbox"></p>
	<p style="display:none;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;身份：
		<select name="identify" id="identify">
			<option value="admin">超级管理员</option>
			<option value="departAdmin">部门管理员</option>
			<option value="ssAdmin">实施人员</option>
			<option value="kfAdmin">客服人员</option>
		</select>
	</p>
	<p> <font color="#999">记住账号</font>
		<input  id="saveid" type="checkbox"  onclick="savePaw();"  />
	</p>
	 
</div>

<div id="btn">
	<a href="#" class="easyui-linkbutton">登录</a>
</div>

<script type="text/javascript" src="easyui/jquery.min.js"></script>
<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js" ></script>
<script type="text/javascript" src="easyui/jquery.cookie.js"></script>
<script type="text/javascript" src="js/login.js"></script>

</body>
</html>
</html>
