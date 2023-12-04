<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
 
	session.removeAttribute("user_name");	//移除保存在session中的username属性
	session.removeAttribute("user_name");
	session.invalidate();
	out.println("<script>top.location='" + basePath +"index.jsp';</script>");
%>