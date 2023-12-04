<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/orderInfo.css" />
<div id="orderInfoAddDiv">
	<form id="orderInfoAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">预约用户:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_userObj_user_name" name="orderInfo.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">预约医生:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_doctorObj_doctorNumber" name="orderInfo.doctorObj.doctorNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">预约日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_orderDate" name="orderInfo.orderDate" />

			</span>

		</div>
		<div>
			<span class="label">时段:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_timeInterval" name="orderInfo.timeInterval" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_telephone" name="orderInfo.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">下单时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_orderTime" name="orderInfo.orderTime" />

			</span>

		</div>
		<div>
			<span class="label">处理状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_checkState" name="orderInfo.checkState" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">医生回复:</span>
			<span class="inputControl">
				<textarea id="orderInfo_replyContent" name="orderInfo.replyContent" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="orderInfoAddButton" class="easyui-linkbutton">添加</a>
			<a id="orderInfoClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/OrderInfo/js/orderInfo_add.js"></script> 
