<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Department" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Department> departmentList = (List<Department>)request.getAttribute("departmentList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String departmentName = (String)request.getAttribute("departmentName"); //科室名称查询关键字
    String birthDate = (String)request.getAttribute("birthDate"); //成立日期查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>科室信息查询</title>
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
			    	<li role="presentation" class="active"><a href="#departmentListPanel" aria-controls="departmentListPanel" role="tab" data-toggle="tab">科室信息列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Department/department_frontAdd.jsp" style="display:none;">添加科室信息</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="departmentListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>科室id</td><td>科室名称</td><td>成立日期</td><td>负责人</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<departmentList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Department department = departmentList.get(i); //获取到科室信息对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=department.getDepartmentId() %></td>
 											<td><%=department.getDepartmentName() %></td>
 											<td><%=department.getBirthDate() %></td>
 											<td><%=department.getChargeMan() %></td>
 											<td>
 												<a href="<%=basePath  %>Department/<%=department.getDepartmentId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="departmentEdit('<%=department.getDepartmentId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="departmentDelete('<%=department.getDepartmentId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>科室信息查询</h1>
		</div>
		<form name="departmentQueryForm" id="departmentQueryForm" action="<%=basePath %>Department/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="departmentName">科室名称:</label>
				<input type="text" id="departmentName" name="departmentName" value="<%=departmentName %>" class="form-control" placeholder="请输入科室名称">
			</div>






			<div class="form-group">
				<label for="birthDate">成立日期:</label>
				<input type="text" id="birthDate" name="birthDate" class="form-control"  placeholder="请选择成立日期" value="<%=birthDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="departmentEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;科室信息信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="departmentEditForm" id="departmentEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="department_departmentId_edit" class="col-md-3 text-right">科室id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="department_departmentId_edit" name="department.departmentId" class="form-control" placeholder="请输入科室id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="department_departmentName_edit" class="col-md-3 text-right">科室名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="department_departmentName_edit" name="department.departmentName" class="form-control" placeholder="请输入科室名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="department_departmentDesc_edit" class="col-md-3 text-right">科室介绍:</label>
		  	 <div class="col-md-9">
			 	<textarea name="department.departmentDesc" id="department_departmentDesc_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="department_birthDate_edit" class="col-md-3 text-right">成立日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date department_birthDate_edit col-md-12" data-link-field="department_birthDate_edit"  data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="department_birthDate_edit" name="department.birthDate" size="16" type="text" value="" placeholder="请选择成立日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="department_chargeMan_edit" class="col-md-3 text-right">负责人:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="department_chargeMan_edit" name="department.chargeMan" class="form-control" placeholder="请输入负责人">
			 </div>
		  </div>
		</form> 
	    <style>#departmentEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxDepartmentModify();">提交</button>
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
var department_departmentDesc_edit = UE.getEditor('department_departmentDesc_edit'); //科室介绍编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.departmentQueryForm.currentPage.value = currentPage;
    document.departmentQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.departmentQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.departmentQueryForm.currentPage.value = pageValue;
    documentdepartmentQueryForm.submit();
}

/*弹出修改科室信息界面并初始化数据*/
function departmentEdit(departmentId) {
	$.ajax({
		url :  basePath + "Department/" + departmentId + "/update",
		type : "get",
		dataType: "json",
		success : function (department, response, status) {
			if (department) {
				$("#department_departmentId_edit").val(department.departmentId);
				$("#department_departmentName_edit").val(department.departmentName);
				department_departmentDesc_edit.setContent(department.departmentDesc, false);
				$("#department_birthDate_edit").val(department.birthDate);
				$("#department_chargeMan_edit").val(department.chargeMan);
				$('#departmentEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除科室信息信息*/
function departmentDelete(departmentId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Department/deletes",
			data : {
				departmentIds : departmentId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#departmentQueryForm").submit();
					//location.href= basePath + "Department/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交科室信息信息表单给服务器端修改*/
function ajaxDepartmentModify() {
	$.ajax({
		url :  basePath + "Department/" + $("#department_departmentId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#departmentEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#departmentQueryForm").submit();
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

    /*成立日期组件*/
    $('.department_birthDate_edit').datetimepicker({
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

