<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%> <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!--导航开始-->
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <!--小屏幕导航按钮和logo-->
        <div class="navbar-header">
            <button class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a href="<%=basePath %>index.jsp" class="navbar-brand">XX设计网</a>
        </div>
        <!--小屏幕导航按钮和logo-->
        <!--导航-->
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-left">
                <li><a href="<%=basePath %>index.jsp">首页</a></li>
                 <li><a href="<%=basePath %>Department/frontlist">科室信息</a></li>
                <li><a href="<%=basePath %>Doctor/frontlist">医生信息</a></li>
                <li><a href="<%=basePath %>Patient/frontlist">病人信息</a></li>
                <li><a href="<%=basePath %>OrderInfo/frontlist">预约信息</a></li>
                <li><a href="<%=basePath %>News/frontlist">新闻信息</a></li>
                <li><a href="<%=basePath %>Leaveword/frontlist">留言</a></li>
                <li><a href="<%=basePath %>UserInfo/frontlist">用户</a></li>
 
            </ul>
            
             <ul class="nav navbar-nav navbar-right">
             	<%
				  	String user_name = (String)session.getAttribute("user_name");
				    if(user_name==null){
	  			%> 
	  			<li><a href="#" onclick="register();"><i class="fa fa-sign-in"></i>&nbsp;&nbsp;注册</a></li>
                <li><a href="#" onclick="login();"><i class="fa fa-user"></i>&nbsp;&nbsp;登录</a></li>
                
                <% } else { %>
                <li class="dropdown">
                    <a id="dLabel" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <%=session.getAttribute("user_name") %>
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="dLabel">
                        <li><a href="<%=basePath %>index.jsp"><span class="glyphicon glyphicon-screenshot"></span>&nbsp;&nbsp;首页</a></li>
                        <li><a href="<%=basePath %>index.jsp"><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;发布信息</a></li>
                        <li><a href="<%=basePath %>index.jsp"><span class="glyphicon glyphicon-cog"></span>&nbsp;&nbsp;我发布的信息</a></li>
                        <li><a href="<%=basePath %>index.jsp"><span class="glyphicon glyphicon-credit-card"></span>&nbsp;&nbsp;修改个人资料</a></li>
                        <li><a href="<%=basePath %>index.jsp"><span class="glyphicon glyphicon-heart"></span>&nbsp;&nbsp;我的收藏</a></li>
                    </ul>
                </li>
                <li><a href="<%=basePath %>logout.jsp"><span class="glyphicon glyphicon-off"></span>&nbsp;&nbsp;退出</a></li>
                <% } %> 
            </ul>
            
        </div>
        <!--导航--> 
    </div>
</nav>
<!--导航结束--> 


<div id="loginDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-key"></i>&nbsp;系统登录</h4>
      </div>
      <div class="modal-body">
      	<form class="form-horizontal" name="loginForm" id="loginForm" enctype="multipart/form-data" method="post"  class="mar_t15">
      	  
      	  <div class="form-group">
			 <label for="userName" class="col-md-3 text-right">用户名:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="userName" name="userName" class="form-control" placeholder="请输入用户名">
			 </div>
		  </div> 
		  
      	  <div class="form-group">
		  	 <label for="password" class="col-md-3 text-right">密码:</label>
		  	 <div class="col-md-9">
			    <input type="password" id="password" name="password" class="form-control" placeholder="登录密码">
			 </div>
		  </div> 
		  
		</form> 
	    <style>#bookTypeAddForm .form-group {margin-bottom:10px;}  </style>
      </div>
      <div class="modal-footer"> 
		<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		<button type="button" class="btn btn-primary" onclick="ajaxLogin();">登录</button> 
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->




 
<div id="registerDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-sign-in"></i>&nbsp;用户注册</h4>
      </div>
      <div class="modal-body">
      	<form class="form-horizontal" name="registerForm" id="registerForm" enctype="multipart/form-data" method="post"  class="mar_t15">
      	  
      	   
		  
		</form> 
	    <style>#bookTypeAddForm .form-group {margin-bottom:10px;}  </style>
      </div>
      <div class="modal-footer"> 
		<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		<button type="button" class="btn btn-primary" onclick="ajaxRegister();">注册</button> 
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->






<script>

function register() {
	$("#registerDialog input").val("");
	$("#registerDialog textarea").val("");
	$('#registerDialog').modal('show');
}
function ajaxRegister() {
	$("#registerForm").data('bootstrapValidator').validate();
	if(!$("#registerForm").data('bootstrapValidator').isValid()){
		return;
	}

	jQuery.ajax({
		type : "post" , 
		url : basePath + "UserInfo/add",
		dataType : "json" , 
		data: new FormData($("#registerForm")[0]),
		success : function(obj) { 
			if(obj.success){ 
                alert("注册成功！");
                $("#registerForm").find("input").val("");
                $("#registerForm").find("textarea").val("");
            }else{
                alert(obj.message);
            }
		},
		processData: false,  
	    contentType: false, 
	});
}


function login() {
	$("#loginDialog input").val("");
	$('#loginDialog').modal('show');
}
function ajaxLogin() {
	$.ajax({
		url : "<%=basePath%>frontLogin",
		type : 'post',
		dataType: "json",
		data : {
			"userName" : $('#userName').val(),
			"password" : $('#password').val(),
		}, 
		success : function (obj, response, status) {
			if (obj.success) {
                location.href = "<%=basePath%>index.jsp";
			} else {
				alert(obj.msg);
			}
		}
	});
}


</script> 
