<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/orderInfo.css" /> 

<div id="orderInfo_manage"></div>
<div id="orderInfo_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="orderInfo_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="orderInfo_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="orderInfo_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="orderInfo_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="orderInfo_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="orderInfoQueryForm" method="post">
			预约用户：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			预约医生：<input class="textbox" type="text" id="doctorObj_doctorNumber_query" name="doctorObj.doctorNumber" style="width: auto"/>
			预约日期：<input type="text" id="orderDate" name="orderDate" class="easyui-datebox" editable="false" style="width:100px">
			时段：<input type="text" class="textbox" id="timeInterval" name="timeInterval" style="width:110px" />
			联系电话：<input type="text" class="textbox" id="telephone" name="telephone" style="width:110px" />
			处理状态：<input type="text" class="textbox" id="checkState" name="checkState" style="width:110px" />
			下单时间：<input type="text" id="orderTime" name="orderTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="orderInfo_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="orderInfoEditDiv">
	<form id="orderInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">预约id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="orderInfo_orderId_edit" name="orderInfo.orderId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="OrderInfo/js/orderInfo_manage.js"></script> 
