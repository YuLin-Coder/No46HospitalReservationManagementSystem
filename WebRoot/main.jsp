<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<jsp:include page="check_logstate.jsp"/>
 
<!DOCTYPE html>
<html>
<head>
<title>信息管理系统</title>
<meta charset="UTF-8" />
<link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css" />
<link rel="stylesheet" type="text/css" href="css/admin.css" />
</head>
<body class="easyui-layout">

<div data-options="region:'north',title:'header',split:true,noheader:true" style="height:60px;background-color:#01B1EA;">
	<div class="logo">XXX系统后台管理</div>
	<div class="logout">您好，<%=session.getAttribute("username")%> | <a href="logout">退出</a></div>
</div>   
<div data-options="region:'south',title:'footer',split:true,noheader:true" style="height:35px;line-height:30px;text-align:center;">
	&copy; Powered by <a style="color: #0f0f0f" href="https://armycodes.com/">从戎源码网</a>
</div>    
<div data-options="region:'west',title:'导航',split:true,iconCls:'icon-world'" style="width:200px;padding:10px;">
	<ul id="nav"></ul>
</div>   
<div data-options="region:'center'" style="overflow:hidden;">
	<div id="tabs">
		<div title="起始页" iconCls="icon-house" style="padding:0 10px;display:block;font-size:70px">
			<br/><br/> <center>欢迎来到后台管理系统！</center>
		</div>
	</div>
</div> 


<script type="text/javascript" src="easyui/jquery.min.js"></script>
<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js" ></script>

<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>

<script type="text/javascript" src="js/admin.js"></script>


</body>
</html>
