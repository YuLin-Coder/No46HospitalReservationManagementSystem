<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/news.css" /> 

<div id="news_manage"></div>
<div id="news_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="news_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="news_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="news_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="news_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="news_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="newsQueryForm" method="post">
			新闻标题：<input type="text" class="textbox" id="newsTitle" name="newsTitle" style="width:110px" />
			新闻日期：<input type="text" id="newsDate" name="newsDate" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="news_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="newsEditDiv">
	<form id="newsEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">新闻id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="news_newsId_edit" name="news.newsId" style="width:200px" />
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
				<script name="news.newsContent" id="news_newsContent_edit" type="text/plain"   style="width:100%;height:500px;"></script>

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
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var news_newsContent_editor = UE.getEditor('news_newsContent_edit'); //新闻内容编辑器
</script>
<script type="text/javascript" src="News/js/news_manage.js"></script> 
