<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/leaveword.css" />
<div id="leaveword_editDiv">
	<form id="leavewordEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">留言id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="leaveword_leaveWordId_edit" name="leaveword.leaveWordId" value="<%=request.getParameter("leaveWordId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="leavewordModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Leaveword/js/leaveword_modify.js"></script> 
