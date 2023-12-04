<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Leaveword" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    Leaveword leaveword = (Leaveword)request.getAttribute("leaveword");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改留言信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">留言信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="leavewordEditForm" id="leavewordEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="leaveword_leaveWordId_edit" class="col-md-3 text-right">留言id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="leaveword_leaveWordId_edit" name="leaveword.leaveWordId" class="form-control" placeholder="请输入留言id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="leaveword_leaveTitle_edit" class="col-md-3 text-right">留言标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="leaveword_leaveTitle_edit" name="leaveword.leaveTitle" class="form-control" placeholder="请输入留言标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="leaveword_leaveContent_edit" class="col-md-3 text-right">留言内容:</label>
		  	 <div class="col-md-9">
			    <textarea id="leaveword_leaveContent_edit" name="leaveword.leaveContent" rows="8" class="form-control" placeholder="请输入留言内容"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="leaveword_userObj_user_name_edit" class="col-md-3 text-right">留言人:</label>
		  	 <div class="col-md-9">
			    <select id="leaveword_userObj_user_name_edit" name="leaveword.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="leaveword_leaveTime_edit" class="col-md-3 text-right">留言时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date leaveword_leaveTime_edit col-md-12" data-link-field="leaveword_leaveTime_edit">
                    <input class="form-control" id="leaveword_leaveTime_edit" name="leaveword.leaveTime" size="16" type="text" value="" placeholder="请选择留言时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="leaveword_replyContent_edit" class="col-md-3 text-right">管理回复:</label>
		  	 <div class="col-md-9">
			    <textarea id="leaveword_replyContent_edit" name="leaveword.replyContent" rows="8" class="form-control" placeholder="请输入管理回复"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="leaveword_replyTime_edit" class="col-md-3 text-right">回复时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date leaveword_replyTime_edit col-md-12" data-link-field="leaveword_replyTime_edit">
                    <input class="form-control" id="leaveword_replyTime_edit" name="leaveword.replyTime" size="16" type="text" value="" placeholder="请选择回复时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxLeavewordModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#leavewordEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改留言界面并初始化数据*/
function leavewordEdit(leaveWordId) {
	$.ajax({
		url :  basePath + "Leaveword/" + leaveWordId + "/update",
		type : "get",
		dataType: "json",
		success : function (leaveword, response, status) {
			if (leaveword) {
				$("#leaveword_leaveWordId_edit").val(leaveword.leaveWordId);
				$("#leaveword_leaveTitle_edit").val(leaveword.leaveTitle);
				$("#leaveword_leaveContent_edit").val(leaveword.leaveContent);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#leaveword_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#leaveword_userObj_user_name_edit").html(html);
		        		$("#leaveword_userObj_user_name_edit").val(leaveword.userObjPri);
					}
				});
				$("#leaveword_leaveTime_edit").val(leaveword.leaveTime);
				$("#leaveword_replyContent_edit").val(leaveword.replyContent);
				$("#leaveword_replyTime_edit").val(leaveword.replyTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交留言信息表单给服务器端修改*/
function ajaxLeavewordModify() {
	$.ajax({
		url :  basePath + "Leaveword/" + $("#leaveword_leaveWordId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#leavewordEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#leavewordQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    /*留言时间组件*/
    $('.leaveword_leaveTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    /*回复时间组件*/
    $('.leaveword_replyTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    leavewordEdit("<%=request.getParameter("leaveWordId")%>");
 })
 </script> 
</body>
</html>

