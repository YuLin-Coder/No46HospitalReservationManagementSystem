<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Leaveword" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Leaveword> leavewordList = (List<Leaveword>)request.getAttribute("leavewordList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String leaveTitle = (String)request.getAttribute("leaveTitle"); //留言标题查询关键字
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String leaveTime = (String)request.getAttribute("leaveTime"); //留言时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>留言查询</title>
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
			    	<li role="presentation" class="active"><a href="#leavewordListPanel" aria-controls="leavewordListPanel" role="tab" data-toggle="tab">留言列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Leaveword/leaveword_frontAdd.jsp" style="display:none;">添加留言</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="leavewordListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>留言id</td><td>留言标题</td><td>留言人</td><td>留言时间</td><td>管理回复</td><td>回复时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<leavewordList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Leaveword leaveword = leavewordList.get(i); //获取到留言对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=leaveword.getLeaveWordId() %></td>
 											<td><%=leaveword.getLeaveTitle() %></td>
 											<td><%=leaveword.getUserObj().getName() %></td>
 											<td><%=leaveword.getLeaveTime() %></td>
 											<td><%=leaveword.getReplyContent() %></td>
 											<td><%=leaveword.getReplyTime() %></td>
 											<td>
 												<a href="<%=basePath  %>Leaveword/<%=leaveword.getLeaveWordId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="leavewordEdit('<%=leaveword.getLeaveWordId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="leavewordDelete('<%=leaveword.getLeaveWordId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>留言查询</h1>
		</div>
		<form name="leavewordQueryForm" id="leavewordQueryForm" action="<%=basePath %>Leaveword/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="leaveTitle">留言标题:</label>
				<input type="text" id="leaveTitle" name="leaveTitle" value="<%=leaveTitle %>" class="form-control" placeholder="请输入留言标题">
			</div>






            <div class="form-group">
            	<label for="userObj_user_name">留言人：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="leaveTime">留言时间:</label>
				<input type="text" id="leaveTime" name="leaveTime" class="form-control"  placeholder="请选择留言时间" value="<%=leaveTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="leavewordEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;留言信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="leavewordEditForm" id="leavewordEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="leaveword_leaveWordId_edit" class="col-md-3 text-right">留言id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="leaveword_leaveWordId_edit" name="leaveword.leaveWordId" class="form-control" placeholder="请输入留言id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="leaveword_leaveTitle_edit" class="col-md-3 text-right">留言标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="leaveword_leaveTitle_edit" name="leaveword.leaveTitle" class="form-control" placeholder="请输入留言标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="leaveword_leaveContent_edit" class="col-md-3 text-right">留言内容:</label>
		  	 <div class="col-md-9">
			    <textarea id="leaveword_leaveContent_edit" name="leaveword.leaveContent" rows="8" class="form-control" placeholder="请输入留言内容"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="leaveword_userObj_user_name_edit" class="col-md-3 text-right">留言人:</label>
		  	 <div class="col-md-9">
			    <select id="leaveword_userObj_user_name_edit" name="leaveword.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="leaveword_leaveTime_edit" class="col-md-3 text-right">留言时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date leaveword_leaveTime_edit col-md-12" data-link-field="leaveword_leaveTime_edit">
                    <input class="form-control" id="leaveword_leaveTime_edit" name="leaveword.leaveTime" size="16" type="text" value="" placeholder="请选择留言时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="leaveword_replyContent_edit" class="col-md-3 text-right">管理回复:</label>
		  	 <div class="col-md-9">
			    <textarea id="leaveword_replyContent_edit" name="leaveword.replyContent" rows="8" class="form-control" placeholder="请输入管理回复"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="leaveword_replyTime_edit" class="col-md-3 text-right">回复时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date leaveword_replyTime_edit col-md-12" data-link-field="leaveword_replyTime_edit">
                    <input class="form-control" id="leaveword_replyTime_edit" name="leaveword.replyTime" size="16" type="text" value="" placeholder="请选择回复时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		</form> 
	    <style>#leavewordEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxLeavewordModify();">提交</button>
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
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.leavewordQueryForm.currentPage.value = currentPage;
    document.leavewordQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.leavewordQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.leavewordQueryForm.currentPage.value = pageValue;
    documentleavewordQueryForm.submit();
}

/*弹出修改留言界面并初始化数据*/
function leavewordEdit(leaveWordId) {
	$.ajax({
		url :  basePath + "Leaveword/" + leaveWordId + "/update",
		type : "get",
		dataType: "json",
		success : function (leaveword, response, status) {
			if (leaveword) {
				$("#leaveword_leaveWordId_edit").val(leaveword.leaveWordId);
				$("#leaveword_leaveTitle_edit").val(leaveword.leaveTitle);
				$("#leaveword_leaveContent_edit").val(leaveword.leaveContent);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#leaveword_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#leaveword_userObj_user_name_edit").html(html);
		        		$("#leaveword_userObj_user_name_edit").val(leaveword.userObjPri);
					}
				});
				$("#leaveword_leaveTime_edit").val(leaveword.leaveTime);
				$("#leaveword_replyContent_edit").val(leaveword.replyContent);
				$("#leaveword_replyTime_edit").val(leaveword.replyTime);
				$('#leavewordEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除留言信息*/
function leavewordDelete(leaveWordId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Leaveword/deletes",
			data : {
				leaveWordIds : leaveWordId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#leavewordQueryForm").submit();
					//location.href= basePath + "Leaveword/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交留言信息表单给服务器端修改*/
function ajaxLeavewordModify() {
	$.ajax({
		url :  basePath + "Leaveword/" + $("#leaveword_leaveWordId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#leavewordEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#leavewordQueryForm").submit();
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

    /*留言时间组件*/
    $('.leaveword_leaveTime_edit').datetimepicker({
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
    /*回复时间组件*/
    $('.leaveword_replyTime_edit').datetimepicker({
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

