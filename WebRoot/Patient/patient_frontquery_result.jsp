<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Patient" %>
<%@ page import="com.chengxusheji.po.Doctor" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Patient> patientList = (List<Patient>)request.getAttribute("patientList");
    //获取所有的doctorObj信息
    List<Doctor> doctorList = (List<Doctor>)request.getAttribute("doctorList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Doctor doctorObj = (Doctor)request.getAttribute("doctorObj");
    String patientName = (String)request.getAttribute("patientName"); //病人姓名查询关键字
    String cardNumber = (String)request.getAttribute("cardNumber"); //身份证号查询关键字
    String telephone = (String)request.getAttribute("telephone"); //联系电话查询关键字
    String addTime = (String)request.getAttribute("addTime"); //登记时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>病人信息查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#patientListPanel" aria-controls="patientListPanel" role="tab" data-toggle="tab">病人信息列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Patient/patient_frontAdd.jsp" style="display:none;">添加病人信息</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="patientListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>病人id</td><td>医生</td><td>病人姓名</td><td>性别</td><td>身份证号</td><td>联系电话</td><td>登记时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<patientList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Patient patient = patientList.get(i); //获取到病人信息对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=patient.getPatientId() %></td>
 											<td><%=patient.getDoctorObj().getDoctorName() %></td>
 											<td><%=patient.getPatientName() %></td>
 											<td><%=patient.getSex() %></td>
 											<td><%=patient.getCardNumber() %></td>
 											<td><%=patient.getTelephone() %></td>
 											<td><%=patient.getAddTime() %></td>
 											<td>
 												<a href="<%=basePath  %>Patient/<%=patient.getPatientId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="patientEdit('<%=patient.getPatientId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="patientDelete('<%=patient.getPatientId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

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
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>病人信息查询</h1>
		</div>
		<form name="patientQueryForm" id="patientQueryForm" action="<%=basePath %>Patient/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="doctorObj_doctorNumber">医生：</label>
                <select id="doctorObj_doctorNumber" name="doctorObj.doctorNumber" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Doctor doctorTemp:doctorList) {
	 					String selected = "";
 					if(doctorObj!=null && doctorObj.getDoctorNumber()!=null && doctorObj.getDoctorNumber().equals(doctorTemp.getDoctorNumber()))
 						selected = "selected";
	 				%>
 				 <option value="<%=doctorTemp.getDoctorNumber() %>" <%=selected %>><%=doctorTemp.getDoctorName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="patientName">病人姓名:</label>
				<input type="text" id="patientName" name="patientName" value="<%=patientName %>" class="form-control" placeholder="请输入病人姓名">
			</div>






			<div class="form-group">
				<label for="cardNumber">身份证号:</label>
				<input type="text" id="cardNumber" name="cardNumber" value="<%=cardNumber %>" class="form-control" placeholder="请输入身份证号">
			</div>






			<div class="form-group">
				<label for="telephone">联系电话:</label>
				<input type="text" id="telephone" name="telephone" value="<%=telephone %>" class="form-control" placeholder="请输入联系电话">
			</div>






			<div class="form-group">
				<label for="addTime">登记时间:</label>
				<input type="text" id="addTime" name="addTime" class="form-control"  placeholder="请选择登记时间" value="<%=addTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="patientEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;病人信息信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="patientEditForm" id="patientEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="patient_patientId_edit" class="col-md-3 text-right">病人id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="patient_patientId_edit" name="patient.patientId" class="form-control" placeholder="请输入病人id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="patient_doctorObj_doctorNumber_edit" class="col-md-3 text-right">医生:</label>
		  	 <div class="col-md-9">
			    <select id="patient_doctorObj_doctorNumber_edit" name="patient.doctorObj.doctorNumber" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="patient_patientName_edit" class="col-md-3 text-right">病人姓名:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="patient_patientName_edit" name="patient.patientName" class="form-control" placeholder="请输入病人姓名">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="patient_sex_edit" class="col-md-3 text-right">性别:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="patient_sex_edit" name="patient.sex" class="form-control" placeholder="请输入性别">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="patient_cardNumber_edit" class="col-md-3 text-right">身份证号:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="patient_cardNumber_edit" name="patient.cardNumber" class="form-control" placeholder="请输入身份证号">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="patient_telephone_edit" class="col-md-3 text-right">联系电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="patient_telephone_edit" name="patient.telephone" class="form-control" placeholder="请输入联系电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="patient_illnessCase_edit" class="col-md-3 text-right">病人病例:</label>
		  	 <div class="col-md-9">
			 	<textarea name="patient.illnessCase" id="patient_illnessCase_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="patient_addTime_edit" class="col-md-3 text-right">登记时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date patient_addTime_edit col-md-12" data-link-field="patient_addTime_edit">
                    <input class="form-control" id="patient_addTime_edit" name="patient.addTime" size="16" type="text" value="" placeholder="请选择登记时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		</form> 
	    <style>#patientEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxPatientModify();">提交</button>
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
var patient_illnessCase_edit = UE.getEditor('patient_illnessCase_edit'); //病人病例编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.patientQueryForm.currentPage.value = currentPage;
    document.patientQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.patientQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.patientQueryForm.currentPage.value = pageValue;
    documentpatientQueryForm.submit();
}

/*弹出修改病人信息界面并初始化数据*/
function patientEdit(patientId) {
	$.ajax({
		url :  basePath + "Patient/" + patientId + "/update",
		type : "get",
		dataType: "json",
		success : function (patient, response, status) {
			if (patient) {
				$("#patient_patientId_edit").val(patient.patientId);
				$.ajax({
					url: basePath + "Doctor/listAll",
					type: "get",
					success: function(doctors,response,status) { 
						$("#patient_doctorObj_doctorNumber_edit").empty();
						var html="";
		        		$(doctors).each(function(i,doctor){
		        			html += "<option value='" + doctor.doctorNumber + "'>" + doctor.doctorName + "</option>";
		        		});
		        		$("#patient_doctorObj_doctorNumber_edit").html(html);
		        		$("#patient_doctorObj_doctorNumber_edit").val(patient.doctorObjPri);
					}
				});
				$("#patient_patientName_edit").val(patient.patientName);
				$("#patient_sex_edit").val(patient.sex);
				$("#patient_cardNumber_edit").val(patient.cardNumber);
				$("#patient_telephone_edit").val(patient.telephone);
				patient_illnessCase_edit.setContent(patient.illnessCase, false);
				$("#patient_addTime_edit").val(patient.addTime);
				$('#patientEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除病人信息信息*/
function patientDelete(patientId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Patient/deletes",
			data : {
				patientIds : patientId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#patientQueryForm").submit();
					//location.href= basePath + "Patient/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交病人信息信息表单给服务器端修改*/
function ajaxPatientModify() {
	$.ajax({
		url :  basePath + "Patient/" + $("#patient_patientId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#patientEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#patientQueryForm").submit();
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

    /*登记时间组件*/
    $('.patient_addTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
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

