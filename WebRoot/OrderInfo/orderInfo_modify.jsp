<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/orderInfo.css" />
<div id="orderInfo_editDiv">
	<form id="orderInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">预约id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_orderId_edit" name="orderInfo.orderId" value="<%=request.getParameter("orderId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">预约用户:</span>
			<span class="inputControl">
				<input class="textbox"  id="orderInfo_userObj_user_name_edit" name="orderInfo.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">预约医生:</span>
			<span class="inputControl">
				<input class="textbox"  id="orderInfo_doctorObj_doctorNumber_edit" name="orderInfo.doctorObj.doctorNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">预约日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_orderDate_edit" name="orderInfo.orderDate" />

			</span>

		</div>
		<div>
			<span class="label">时段:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_timeInterval_edit" name="orderInfo.timeInterval" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_telephone_edit" name="orderInfo.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">下单时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_orderTime_edit" name="orderInfo.orderTime" />

			</span>

		</div>
		<div>
			<span class="label">处理状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_checkState_edit" name="orderInfo.checkState" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">医生回复:</span>
			<span class="inputControl">
				<textarea id="orderInfo_replyContent_edit" name="orderInfo.replyContent" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="orderInfoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/OrderInfo/js/orderInfo_modify.js"></script> 
