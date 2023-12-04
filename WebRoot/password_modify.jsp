<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>  
 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 

%>
<!DOCTYPE html>
<html>
<HEAD><TITLE>修改密码</TITLE> 
<STYLE type=text/css>
BODY {
	MARGIN-LEFT: 0px; BACKGROUND-COLOR: #ffffff
}
.STYLE1 {color: #ECE9D8}
.label {font-style.:italic; }
.errorLabel {font-style.:italic;  color:red; }
.errorMessage {font-weight:bold; color:red; } 
</STYLE>
 <script src="<%=basePath %>calendar.js"></script>
</HEAD>
<%
	String username=(String)session.getAttribute("username");
	if(username==null){
		response.getWriter().println("<script>top.location.href='" + basePath + "login';</script>"); 
	}
%>
<BODY>
 
<TABLE align="center"   cellSpacing=0 cellPadding=0 width="80%" border=0>
  <TBODY>
  <TR>
    <TD align="left" vAlign=top ><br><form action="<%=basePath %>changePassword" method="post" name="form1" target="submitFrame">
<table width='100%' cellspacing='1' cellpadding='3' bgcolor='#CCCCCC' class="tablewidth">
  
  
  <tr>
  	<td align="right" width="35%">以前的密码:</td>
    <td width=65%><input name="oldPassword" type=password /></td>   
  </tr>
 <tr>
  	<td align="right" width="35%">输入新密码:</td>
    <td width=65%><input name="newPassword" type=password /></td>   
  </tr>
  <tr>
  	<td align="right" width="35%">再输入新密码:</td>
    <td width=65%><input name="newPassword2" type=password /></td>   
  </tr>
  <tr bgcolor='#FFFFFF'> 
      <td colspan="4" align="center"> 
        <input type='submit' name='button' value='修改' >
        &nbsp;&nbsp;
       
      </td>
    </tr>
	
</table>
</form>
<iframe name="submitFrame" frameborder="0" scrolling="yes" width="100%" height="300px"></iframe>
   </TD>
	</TR>
  </TBODY>
</TABLE>
</BODY> 
</HTML>
