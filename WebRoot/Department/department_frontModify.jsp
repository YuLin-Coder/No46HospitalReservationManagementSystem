<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Department" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Department department = (Department)request.getAttribute("department");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改科室信息信息</TITLE>
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
  		<li class="active">科室信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="departmentEditForm" id="departmentEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="department_departmentId_edit" class="col-md-3 text-right">科室id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="department_departmentId_edit" name="department.departmentId" class="form-control" placeholder="请输入科室id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="department_departmentName_edit" class="col-md-3 text-right">科室名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="department_departmentName_edit" name="department.departmentName" class="form-control" placeholder="请输入科室名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="department_departmentDesc_edit" class="col-md-3 text-right">科室介绍:</label>
		  	 <div class="col-md-9">
			    <script name="department.departmentDesc" id="department_departmentDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="department_birthDate_edit" class="col-md-3 text-right">成立日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date department_birthDate_edit col-md-12" data-link-field="department_birthDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="department_birthDate_edit" name="department.birthDate" size="16" type="text" value="" placeholder="请选择成立日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="department_chargeMan_edit" class="col-md-3 text-right">负责人:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="department_chargeMan_edit" name="department.chargeMan" class="form-control" placeholder="请输入负责人">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxDepartmentModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#departmentEditForm .form-group {margin-bottom:5px;}  </style>
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
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
var department_departmentDesc_editor = UE.getEditor('department_departmentDesc_edit'); //科室介绍编辑框
var basePath = "<%=basePath%>";
/*弹出修改科室信息界面并初始化数据*/
function departmentEdit(departmentId) {
  department_departmentDesc_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(departmentId);
  });
}
 function ajaxModifyQuery(departmentId) {
	$.ajax({
		url :  basePath + "Department/" + departmentId + "/update",
		type : "get",
		dataType: "json",
		success : function (department, response, status) {
			if (department) {
				$("#department_departmentId_edit").val(department.departmentId);
				$("#department_departmentName_edit").val(department.departmentName);
				department_departmentDesc_editor.setContent(department.departmentDesc, false);
				$("#department_birthDate_edit").val(department.birthDate);
				$("#department_chargeMan_edit").val(department.chargeMan);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交科室信息信息表单给服务器端修改*/
function ajaxDepartmentModify() {
	$.ajax({
		url :  basePath + "Department/" + $("#department_departmentId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#departmentEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#departmentQueryForm").submit();
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
    /*成立日期组件*/
    $('.department_birthDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    departmentEdit("<%=request.getParameter("departmentId")%>");
 })
 </script> 
</body>
</html>

