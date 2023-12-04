<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/news.css" />
<div id="news_editDiv">
	<form id="newsEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">新闻id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="news_newsId_edit" name="news.newsId" value="<%=request.getParameter("newsId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">新闻标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="news_newsTitle_edit" name="news.newsTitle" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">新闻图片:</span>
			<span class="inputControl">
				<img id="news_newsPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="news_newsPhoto" name="news.newsPhoto"/>
				<input id="newsPhotoFile" name="newsPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">新闻内容:</span>
			<span class="inputControl">
				<script id="news_newsContent_edit" name="news.newsContent" type="text/plain"   style="width:750px;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">新闻日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="news_newsDate_edit" name="news.newsDate" />

			</span>

		</div>
		<div>
			<span class="label">新闻来源:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="news_newsFrom_edit" name="news.newsFrom" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="newsModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/News/js/news_modify.js"></script> 
