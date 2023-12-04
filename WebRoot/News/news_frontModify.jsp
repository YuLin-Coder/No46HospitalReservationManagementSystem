<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.News" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    News news = (News)request.getAttribute("news");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改新闻信息信息</TITLE>
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
  		<li class="active">新闻信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="newsEditForm" id="newsEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="news_newsId_edit" class="col-md-3 text-right">新闻id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="news_newsId_edit" name="news.newsId" class="form-control" placeholder="请输入新闻id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="news_newsTitle_edit" class="col-md-3 text-right">新闻标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="news_newsTitle_edit" name="news.newsTitle" class="form-control" placeholder="请输入新闻标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="news_newsPhoto_edit" class="col-md-3 text-right">新闻图片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="news_newsPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="news_newsPhoto" name="news.newsPhoto"/>
			    <input id="newsPhotoFile" name="newsPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="news_newsContent_edit" class="col-md-3 text-right">新闻内容:</label>
		  	 <div class="col-md-9">
			    <script name="news.newsContent" id="news_newsContent_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="news_newsDate_edit" class="col-md-3 text-right">新闻日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date news_newsDate_edit col-md-12" data-link-field="news_newsDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="news_newsDate_edit" name="news.newsDate" size="16" type="text" value="" placeholder="请选择新闻日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="news_newsFrom_edit" class="col-md-3 text-right">新闻来源:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="news_newsFrom_edit" name="news.newsFrom" class="form-control" placeholder="请输入新闻来源">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxNewsModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#newsEditForm .form-group {margin-bottom:5px;}  </style>
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
var news_newsContent_editor = UE.getEditor('news_newsContent_edit'); //新闻内容编辑框
var basePath = "<%=basePath%>";
/*弹出修改新闻信息界面并初始化数据*/
function newsEdit(newsId) {
  news_newsContent_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(newsId);
  });
}
 function ajaxModifyQuery(newsId) {
	$.ajax({
		url :  basePath + "News/" + newsId + "/update",
		type : "get",
		dataType: "json",
		success : function (news, response, status) {
			if (news) {
				$("#news_newsId_edit").val(news.newsId);
				$("#news_newsTitle_edit").val(news.newsTitle);
				$("#news_newsPhoto").val(news.newsPhoto);
				$("#news_newsPhotoImg").attr("src", basePath +　news.newsPhoto);
				news_newsContent_editor.setContent(news.newsContent, false);
				$("#news_newsDate_edit").val(news.newsDate);
				$("#news_newsFrom_edit").val(news.newsFrom);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交新闻信息信息表单给服务器端修改*/
function ajaxNewsModify() {
	$.ajax({
		url :  basePath + "News/" + $("#news_newsId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#newsEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#newsQueryForm").submit();
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
    /*新闻日期组件*/
    $('.news_newsDate_edit').datetimepicker({
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
    newsEdit("<%=request.getParameter("newsId")%>");
 })
 </script> 
</body>
</html>

