<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String username=(String)session.getAttribute("username");
if(username==null){
    response.getWriter().println("<script>top.location.href='" + basePath + "login.jsp';</script>");
}
%>