<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!--footer-->
<footer style="    position: fixed;
    bottom: 0;
    width: 100%;">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
            	<a href="https://armycodes.com/" target=_blank>© 从戎源码网 from 2023</a> |
				<a href="http://www.baidu.com">本站招聘</a> | 
				<a href="http://www.baidu.com">联系站长</a> | 
				<a href="http://www.baidu.com">意见与建议</a> | 
				<a href="http://www.baidu.com" target=_blank>湘ICP备xxxxx号</a> |
				<a href="<%=basePath%>login.jsp">后台登录</a>
            </div>
        </div>
    </div>
</footer>
<!--footer--> 

 


 