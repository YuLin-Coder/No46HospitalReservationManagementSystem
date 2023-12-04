<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.News" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<News> newsList = (List<News>)request.getAttribute("newsList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String newsTitle = (String)request.getAttribute("newsTitle"); //新闻标题查询关键字
    String newsDate = (String)request.getAttribute("newsDate"); //新闻日期查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>新闻信息查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>News/frontlist">新闻信息信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>News/news_frontAdd.jsp" style="display:none;">添加新闻信息</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<newsList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		News news = newsList.get(i); //获取到新闻信息对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>News/<%=news.getNewsId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=news.getNewsPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		新闻id:<%=news.getNewsId() %>
			     	</div>
			     	<div class="field">
	            		新闻标题:<%=news.getNewsTitle() %>
			     	</div>
			     	<div class="field">
	            		新闻日期:<%=news.getNewsDate() %>
			     	</div>
			     	<div class="field">
	            		新闻来源:<%=news.getNewsFrom() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>News/<%=news.getNewsId() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="newsEdit('<%=news.getNewsId() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="newsDelete('<%=news.getNewsId() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

			<div class="row">
				<div class="col-md-12">
					<nav class="pull-left">
						<ul class="pagination">
							<li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
							<%
								int startPage = currentPage - 5;
								int endPage = currentPage + 5;
								if(startPage < 1) startPage=1;
								if(endPage > totalPage) endPage = totalPage;
								for(int i=startPage;i<=endPage;i++) {
							%>
							<li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
							<%  } %> 
							<li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						</ul>
					</nav>
					<div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>新闻信息查询</h1>
		</div>
		<form name="newsQueryForm" id="newsQueryForm" action="<%=basePath %>News/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="newsTitle">新闻标题:</label>
				<input type="text" id="newsTitle" name="newsTitle" value="<%=newsTitle %>" class="form-control" placeholder="请输入新闻标题">
			</div>
			<div class="form-group">
				<label for="newsDate">新闻日期:</label>
				<input type="text" id="newsDate" name="newsDate" class="form-control"  placeholder="请选择新闻日期" value="<%=newsDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="newsEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;新闻信息信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
			 	<textarea name="news.newsContent" id="news_newsContent_edit" style="width:100%;height:500px;"></textarea>
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
		</form> 
	    <style>#newsEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxNewsModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
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
//实例化编辑器
var news_newsContent_edit = UE.getEditor('news_newsContent_edit'); //新闻内容编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.newsQueryForm.currentPage.value = currentPage;
    document.newsQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.newsQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.newsQueryForm.currentPage.value = pageValue;
    documentnewsQueryForm.submit();
}

/*弹出修改新闻信息界面并初始化数据*/
function newsEdit(newsId) {
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
				news_newsContent_edit.setContent(news.newsContent, false);
				$("#news_newsDate_edit").val(news.newsDate);
				$("#news_newsFrom_edit").val(news.newsFrom);
				$('#newsEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除新闻信息信息*/
function newsDelete(newsId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "News/deletes",
			data : {
				newsIds : newsId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#newsQueryForm").submit();
					//location.href= basePath + "News/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

