<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/leaveword.css" />
<div id="leavewordAddDiv">
	<form id="leavewordAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">留言标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="leaveword_leaveTitle" name="leaveword.leaveTitle" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">留言内容:</span>
			<span class="inputControl">
				<textarea id="leaveword_leaveContent" name="leaveword.leaveContent" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">留言人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="leaveword_userObj_user_name" name="leaveword.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">留言时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="leaveword_leaveTime" name="leaveword.leaveTime" />

			</span>

		</div>
		<div>
			<span class="label">管理回复:</span>
			<span class="inputControl">
				<textarea id="leaveword_replyContent" name="leaveword.replyContent" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">回复时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="leaveword_replyTime" name="leaveword.replyTime" />

			</span>

		</div>
		<div class="operation">
			<a id="leavewordAddButton" class="easyui-linkbutton">添加</a>
			<a id="leavewordClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Leaveword/js/leaveword_add.js"></script> 
