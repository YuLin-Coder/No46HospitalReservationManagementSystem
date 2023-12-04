<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Doctor" %>
<%@ page import="com.chengxusheji.po.Department" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Doctor> doctorList = (List<Doctor>)request.getAttribute("doctorList");
    //获取所有的departmentObj信息
    List<Department> departmentList = (List<Department>)request.getAttribute("departmentList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String doctorNumber = (String)request.getAttribute("doctorNumber"); //医生工号查询关键字
    Department departmentObj = (Department)request.getAttribute("departmentObj");
    String doctorName = (String)request.getAttribute("doctorName"); //医生姓名查询关键字
    String birthDate = (String)request.getAttribute("birthDate"); //出生日期查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>医生信息查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Doctor/frontlist">医生信息信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>Doctor/doctor_frontAdd.jsp" style="display:none;">添加医生信息</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<doctorList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		Doctor doctor = doctorList.get(i); //获取到医生信息对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>Doctor/<%=doctor.getDoctorNumber() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=doctor.getDoctorPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		医生工号:<%=doctor.getDoctorNumber() %>
			     	</div>
			     	<div class="field">
	            		所在科室:<%=doctor.getDepartmentObj().getDepartmentName() %>
			     	</div>
			     	<div class="field">
	            		医生姓名:<%=doctor.getDoctorName() %>
			     	</div>
			     	<div class="field">
	            		性别:<%=doctor.getSex() %>
			     	</div>
			     	<div class="field">
	            		出生日期:<%=doctor.getBirthDate() %>
			     	</div>
			     	<div class="field">
	            		医生职位:<%=doctor.getPosition() %>
			     	</div>
			     	<div class="field">
	            		工作经验:<%=doctor.getExperience() %>
			     	</div>
			     	<div class="field">
	            		联系方式:<%=doctor.getContactWay() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>Doctor/<%=doctor.getDoctorNumber() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="doctorEdit('<%=doctor.getDoctorNumber() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="doctorDelete('<%=doctor.getDoctorNumber() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

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

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>医生信息查询</h1>
		</div>
		<form name="doctorQueryForm" id="doctorQueryForm" action="<%=basePath %>Doctor/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="doctorNumber">医生工号:</label>
				<input type="text" id="doctorNumber" name="doctorNumber" value="<%=doctorNumber %>" class="form-control" placeholder="请输入医生工号">
			</div>
            <div class="form-group">
            	<label for="departmentObj_departmentId">所在科室：</label>
                <select id="departmentObj_departmentId" name="departmentObj.departmentId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Department departmentTemp:departmentList) {
	 					String selected = "";
 					if(departmentObj!=null && departmentObj.getDepartmentId()!=null && departmentObj.getDepartmentId().intValue()==departmentTemp.getDepartmentId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=departmentTemp.getDepartmentId() %>" <%=selected %>><%=departmentTemp.getDepartmentName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="doctorName">医生姓名:</label>
				<input type="text" id="doctorName" name="doctorName" value="<%=doctorName %>" class="form-control" placeholder="请输入医生姓名">
			</div>
			<div class="form-group">
				<label for="birthDate">出生日期:</label>
				<input type="text" id="birthDate" name="birthDate" class="form-control"  placeholder="请选择出生日期" value="<%=birthDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="doctorEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;医生信息信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="doctorEditForm" id="doctorEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="doctor_doctorNumber_edit" class="col-md-3 text-right">医生工号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="doctor_doctorNumber_edit" name="doctor.doctorNumber" class="form-control" placeholder="请输入医生工号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="doctor_password_edit" class="col-md-3 text-right">登录密码:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="doctor_password_edit" name="doctor.password" class="form-control" placeholder="请输入登录密码">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="doctor_departmentObj_departmentId_edit" class="col-md-3 text-right">所在科室:</label>
		  	 <div class="col-md-9">
			    <select id="doctor_departmentObj_departmentId_edit" name="doctor.departmentObj.departmentId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="doctor_doctorName_edit" class="col-md-3 text-right">医生姓名:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="doctor_doctorName_edit" name="doctor.doctorName" class="form-control" placeholder="请输入医生姓名">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="doctor_sex_edit" class="col-md-3 text-right">性别:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="doctor_sex_edit" name="doctor.sex" class="form-control" placeholder="请输入性别">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="doctor_doctorPhoto_edit" class="col-md-3 text-right">医生照片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="doctor_doctorPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="doctor_doctorPhoto" name="doctor.doctorPhoto"/>
			    <input id="doctorPhotoFile" name="doctorPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="doctor_birthDate_edit" class="col-md-3 text-right">出生日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date doctor_birthDate_edit col-md-12" data-link-field="doctor_birthDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="doctor_birthDate_edit" name="doctor.birthDate" size="16" type="text" value="" placeholder="请选择出生日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="doctor_position_edit" class="col-md-3 text-right">医生职位:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="doctor_position_edit" name="doctor.position" class="form-control" placeholder="请输入医生职位">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="doctor_experience_edit" class="col-md-3 text-right">工作经验:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="doctor_experience_edit" name="doctor.experience" class="form-control" placeholder="请输入工作经验">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="doctor_contactWay_edit" class="col-md-3 text-right">联系方式:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="doctor_contactWay_edit" name="doctor.contactWay" class="form-control" placeholder="请输入联系方式">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="doctor_goodAt_edit" class="col-md-3 text-right">擅长:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="doctor_goodAt_edit" name="doctor.goodAt" class="form-control" placeholder="请输入擅长">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="doctor_doctorDesc_edit" class="col-md-3 text-right">医生介绍:</label>
		  	 <div class="col-md-9">
			 	<textarea name="doctor.doctorDesc" id="doctor_doctorDesc_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		</form> 
	    <style>#doctorEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxDoctorModify();">提交</button>
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
var doctor_doctorDesc_edit = UE.getEditor('doctor_doctorDesc_edit'); //医生介绍编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.doctorQueryForm.currentPage.value = currentPage;
    document.doctorQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.doctorQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.doctorQueryForm.currentPage.value = pageValue;
    documentdoctorQueryForm.submit();
}

/*弹出修改医生信息界面并初始化数据*/
function doctorEdit(doctorNumber) {
	$.ajax({
		url :  basePath + "Doctor/" + doctorNumber + "/update",
		type : "get",
		dataType: "json",
		success : function (doctor, response, status) {
			if (doctor) {
				$("#doctor_doctorNumber_edit").val(doctor.doctorNumber);
				$("#doctor_password_edit").val(doctor.password);
				$.ajax({
					url: basePath + "Department/listAll",
					type: "get",
					success: function(departments,response,status) { 
						$("#doctor_departmentObj_departmentId_edit").empty();
						var html="";
		        		$(departments).each(function(i,department){
		        			html += "<option value='" + department.departmentId + "'>" + department.departmentName + "</option>";
		        		});
		        		$("#doctor_departmentObj_departmentId_edit").html(html);
		        		$("#doctor_departmentObj_departmentId_edit").val(doctor.departmentObjPri);
					}
				});
				$("#doctor_doctorName_edit").val(doctor.doctorName);
				$("#doctor_sex_edit").val(doctor.sex);
				$("#doctor_doctorPhoto").val(doctor.doctorPhoto);
				$("#doctor_doctorPhotoImg").attr("src", basePath +　doctor.doctorPhoto);
				$("#doctor_birthDate_edit").val(doctor.birthDate);
				$("#doctor_position_edit").val(doctor.position);
				$("#doctor_experience_edit").val(doctor.experience);
				$("#doctor_contactWay_edit").val(doctor.contactWay);
				$("#doctor_goodAt_edit").val(doctor.goodAt);
				doctor_doctorDesc_edit.setContent(doctor.doctorDesc, false);
				$('#doctorEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除医生信息信息*/
function doctorDelete(doctorNumber) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Doctor/deletes",
			data : {
				doctorNumbers : doctorNumber,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#doctorQueryForm").submit();
					//location.href= basePath + "Doctor/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交医生信息信息表单给服务器端修改*/
function ajaxDoctorModify() {
	$.ajax({
		url :  basePath + "Doctor/" + $("#doctor_doctorNumber_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#doctorEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#doctorQueryForm").submit();
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

    /*出生日期组件*/
    $('.doctor_birthDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
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

