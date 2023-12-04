<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/leaveword.css" /> 

<div id="leaveword_manage"></div>
<div id="leaveword_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="leaveword_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="leaveword_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="leaveword_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="leaveword_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="leaveword_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="leavewordQueryForm" method="post">
			留言标题：<input type="text" class="textbox" id="leaveTitle" name="leaveTitle" style="width:110px" />
			留言人：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			留言时间：<input type="text" id="leaveTime" name="leaveTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="leaveword_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="leavewordEditDiv">
	<form id="leavewordEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">留言id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="leaveword_leaveWordId_edit" name="leaveword.leaveWordId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">留言标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="leaveword_leaveTitle_edit" name="leaveword.leaveTitle" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">留言内容:</span>
			<span class="inputControl">
				<textarea id="leaveword_leaveContent_edit" name="leaveword.leaveContent" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">留言人:</span>
			<span class="inputControl">
				<input class="textbox"  id="leaveword_userObj_user_name_edit" name="leaveword.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">留言时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="leaveword_leaveTime_edit" name="leaveword.leaveTime" />

			</span>

		</div>
		<div>
			<span class="label">管理回复:</span>
			<span class="inputControl">
				<textarea id="leaveword_replyContent_edit" name="leaveword.replyContent" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">回复时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="leaveword_replyTime_edit" name="leaveword.replyTime" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Leaveword/js/leaveword_manage.js"></script> 
