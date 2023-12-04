<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Doctor" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>预约信息添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>OrderInfo/frontlist">预约信息列表</a></li>
			    	<li role="presentation" class="active"><a href="#orderInfoAdd" aria-controls="orderInfoAdd" role="tab" data-toggle="tab">添加预约信息</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="orderInfoList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="orderInfoAdd"> 
				      	<form class="form-horizontal" name="orderInfoAddForm" id="orderInfoAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="orderInfo_userObj_user_name" class="col-md-2 text-right">预约用户:</label>
						  	 <div class="col-md-8">
							    <select id="orderInfo_userObj_user_name" name="orderInfo.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="orderInfo_doctorObj_doctorNumber" class="col-md-2 text-right">预约医生:</label>
						  	 <div class="col-md-8">
							    <select id="orderInfo_doctorObj_doctorNumber" name="orderInfo.doctorObj.doctorNumber" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="orderInfo_orderDateDiv" class="col-md-2 text-right">预约日期:</label>
						  	 <div class="col-md-8">
				                <div id="orderInfo_orderDateDiv" class="input-group date orderInfo_orderDate col-md-12" data-link-field="orderInfo_orderDate" data-link-format="yyyy-mm-dd">
				                    <input class="form-control" id="orderInfo_orderDate" name="orderInfo.orderDate" size="16" type="text" value="" placeholder="请选择预约日期" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="orderInfo_timeInterval" class="col-md-2 text-right">时段:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="orderInfo_timeInterval" name="orderInfo.timeInterval" class="form-control" placeholder="请输入时段">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="orderInfo_telephone" class="col-md-2 text-right">联系电话:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="orderInfo_telephone" name="orderInfo.telephone" class="form-control" placeholder="请输入联系电话">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="orderInfo_orderTimeDiv" class="col-md-2 text-right">下单时间:</label>
						  	 <div class="col-md-8">
				                <div id="orderInfo_orderTimeDiv" class="input-group date orderInfo_orderTime col-md-12" data-link-field="orderInfo_orderTime">
				                    <input class="form-control" id="orderInfo_orderTime" name="orderInfo.orderTime" size="16" type="text" value="" placeholder="请选择下单时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="orderInfo_checkState" class="col-md-2 text-right">处理状态:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="orderInfo_checkState" name="orderInfo.checkState" class="form-control" placeholder="请输入处理状态">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="orderInfo_replyContent" class="col-md-2 text-right">医生回复:</label>
						  	 <div class="col-md-8">
							    <textarea id="orderInfo_replyContent" name="orderInfo.replyContent" rows="8" class="form-control" placeholder="请输入医生回复"></textarea>
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxOrderInfoAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#orderInfoAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加预约信息信息
	function ajaxOrderInfoAdd() { 
		//提交之前先验证表单
		$("#orderInfoAddForm").data('bootstrapValidator').validate();
		if(!$("#orderInfoAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "OrderInfo/add",
			dataType : "json" , 
			data: new FormData($("#orderInfoAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#orderInfoAddForm").find("input").val("");
					$("#orderInfoAddForm").find("textarea").val("");
				} else {
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
	//验证预约信息添加表单字段
	$('#orderInfoAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"orderInfo.orderDate": {
				validators: {
					notEmpty: {
						message: "预约日期不能为空",
					}
				}
			},
			"orderInfo.timeInterval": {
				validators: {
					notEmpty: {
						message: "时段不能为空",
					}
				}
			},
			"orderInfo.telephone": {
				validators: {
					notEmpty: {
						message: "联系电话不能为空",
					}
				}
			},
			"orderInfo.orderTime": {
				validators: {
					notEmpty: {
						message: "下单时间不能为空",
					}
				}
			},
			"orderInfo.checkState": {
				validators: {
					notEmpty: {
						message: "处理状态不能为空",
					}
				}
			},
			"orderInfo.replyContent": {
				validators: {
					notEmpty: {
						message: "医生回复不能为空",
					}
				}
			},
		}
	}); 
	//初始化预约用户下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#orderInfo_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#orderInfo_userObj_user_name").html(html);
    	}
	});
	//初始化预约医生下拉框值 
	$.ajax({
		url: basePath + "Doctor/listAll",
		type: "get",
		success: function(doctors,response,status) { 
			$("#orderInfo_doctorObj_doctorNumber").empty();
			var html="";
    		$(doctors).each(function(i,doctor){
    			html += "<option value='" + doctor.doctorNumber + "'>" + doctor.doctorName + "</option>";
    		});
    		$("#orderInfo_doctorObj_doctorNumber").html(html);
    	}
	});
	//预约日期组件
	$('#orderInfo_orderDateDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd',
		minView: 2,
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#orderInfoAddForm').data('bootstrapValidator').updateStatus('orderInfo.orderDate', 'NOT_VALIDATED',null).validateField('orderInfo.orderDate');
	});
	//下单时间组件
	$('#orderInfo_orderTimeDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd hh:ii:ss',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#orderInfoAddForm').data('bootstrapValidator').updateStatus('orderInfo.orderTime', 'NOT_VALIDATED',null).validateField('orderInfo.orderTime');
	});
})
</script>
</body>
</html>
