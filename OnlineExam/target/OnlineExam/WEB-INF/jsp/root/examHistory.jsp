<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.exam.model.Exam" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
   <title>在线考试系统</title>
   <link rel="stylesheet" type="text/css" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
   <link rel="stylesheet" type="text/css" href="https://cdn.bootcss.com/jquery-datetimepicker/2.4.1/jquery.datetimepicker.css">
   <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
   <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
   <script src="https://cdn.bootcss.com/jquery-datetimepicker/2.4.1/jquery.datetimepicker.js"></script>
   
   <script>
      function dateTransfer(dateTime){
    	  var date = new Date(dateTime);
    	  return date.getFullYear() + "/" + getzf(date.getMonth() + 1) + "/" + getzf(date.getDate()) + "/ " 
    	      + getzf(date.getHours()) + ":" + getzf(date.getMinutes()) + ":" + getzf(date.getSeconds());
      }
      
      //补0操作  
      function getzf(num){  
          if(parseInt(num) < 10){  
        	  num = '0'+num;  
          }  
          return num;  
      }  
      

   </script>
   <style type="text/css">
   		body{background:aliceblue;}
   </style>
</head>
<body>
  <div class="container">
      <!-- Static navbar -->
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <div><img src="image/logo.jpg" width=50px height=50px/>博考</div>
          </div>
          <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
              <li><a href="/OnlineExam/main.html">上传考试</a></li>
              <li class="active"><a href="#">历史考试</a></li>
              <li><a href="/OnlineExam/class/">课程管理</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">${user.name} <span class="caret"></span></a>
                <ul class="dropdown-menu">
                  <li><a href="/OnlineExam/userInfo.html">个人信息</a></li>
                  <li><a href="/OnlineExam/logout.html">退出登录</a></li>
                </ul>
              </li>
            </ul>
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->


      <!-- Main component for a primary marketing message or call to action -->

      		<div class="container-fluid">
      			<div class="row-fluid">
      				<div class="span12">
      				<!-- <h3>
      					还未开始的考试
      					</h3>
      					<table class="table"  id="unstartExamList">
      						<thead>
      							<tr>
      								<th>序号</th>
      								<th>课程名称</th>
      								<th>考试密码</th>
      								<th>开始时间</th>
      								<th>结束时间</th>
      								<th>试题数量</th>
      								<th>操作</th>
      							</tr>
      						</thead>
      						<tbody>
      											
      						</tbody>
      					</table> -->
      					<h3>
      					正在进行的考试
      					</h3>
      					<table class="table"  id="nowExamList">
      						<thead>
      							<tr>
      								<th>序号</th>
      								<th>课程名称</th>
      								<th>考试密码</th>
      								<th>开始时间</th>
      								<th>结束时间</th>
      								<th>试题数量</th>
      								<th>操作</th>
      							</tr>
      						</thead>
      						<tbody>
      											
      						</tbody>
      					</table>
      					<h3>
      					已经结束的考试
      					</h3>
      					<table class="table"  id="historyExamList">
      						<thead>
      							<tr>
      								<th>序号</th>
      								<th>课程名称</th>
      								<th>考试密码</th>
      								<th>开始时间</th>
      								<th>结束时间</th>
      								<th>试题数量</th>
      								<th>操作</th>
      							</tr>
      						</thead>
      						<tbody>
      											
      						</tbody>
      					</table>
      				</div>
      			</div>
      		</div>

      <%		
        //获得考试列表，转换为字符串
        String classStr="";
        HttpSession s=request.getSession();
        List<Exam> list = (List)s.getAttribute("examList");
        //获取系统当前时间
        long nowDate = System.currentTimeMillis();
        String nowExam = "<thead><tr><th>序号</th><th>课程名称</th><th>考试密码</th><th>开始时间</th><th>结束时间</th><th>试题数量</th><th>操作</th></tr>";
        String historyExam = "<thead><tr><th>序号</th><th>课程名称</th><th>考试密码</th><th>开始时间</th><th>结束时间</th><th>试题数量</th><th>操作</th></tr>";
        String unstartExam="<thead><tr><th>序号</th><th>课程名称</th><th>考试密码</th><th>开始时间</th><th>结束时间</th><th>试题数量</th><th>操作</th></tr>";
        int nowInd = 0;
        int historyInd = 0;
        int unstartInd=0;
        for(int i=0;i<list.size();i++){
        	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        	String endTime = list.get(i).getEndTime().toLocaleString();
        	long endDate = sdf.parse(endTime).getTime();
        	if(endDate>nowDate){
        		nowInd++;
        		nowExam=nowExam+"<tr><td>"+nowInd+"</td>"
     			         +"<td>"+list.get(i).getName()+"</td>"
     			         +"<td>"+list.get(i).getPassword()+"</td>"
     			         +"<td>"+list.get(i).getStartTime().toLocaleString()+"</td>"
     			         +"<td>"+list.get(i).getEndTime().toLocaleString()+"</td>"
     			         +"<td>"+list.get(i).getNumber()+"</td>"
     			        +"<td>"+"<a href=\\\"/OnlineExam/exam/examDetail?examId="+list.get(i).getId()+"\\\">查看详情</button>"+"</td></tr>";
        	}
        	else if(endDate<=nowDate){
        		historyInd++;
        		historyExam=historyExam+"<tr><td>"+historyInd+"</td>"
     			         +"<td>"+list.get(i).getName()+"</td>"
     			         +"<td>"+list.get(i).getPassword()+"</td>"
     			         +"<td>"+list.get(i).getStartTime().toLocaleString()+"</td>"
     			         +"<td>"+list.get(i).getEndTime().toLocaleString()+"</td>"
     			         +"<td>"+list.get(i).getNumber()+"</td>"
     			         +"<td>"+"<a href=\\\"/OnlineExam/exam/examDetail?examId="+list.get(i).getId()+"\\\">查看详情</button>"+"</td></tr>";
        	}
        	/* else if(endDate>nowDate){
        		unstartInd++;
        		unstartExam=unstartExam+"<tr><td>"+unstartInd+"</td>"
    			         +"<td>"+list.get(i).getName()+"</td>"
    			         +"<td>"+list.get(i).getPassword()+"</td>"
    			         +"<td>"+list.get(i).getStartTime().toLocaleString()+"</td>"
    			         +"<td>"+list.get(i).getEndTime().toLocaleString()+"</td>"
    			         +"<td>"+list.get(i).getNumber()+"</td>"
    			         +"<td>"+"<a href=\\\"/OnlineExam/exam/examDetail?examId="+list.get(i).getId()+"\\\">查看详情</button>"+"</td></tr>";
       	} */
   		}
        %>
    
    <script>
    	$(function(){
    		document.getElementById("nowExamList").innerHTML="<%=nowExam%>";
    		document.getElementById("historyExamList").innerHTML="<%=historyExam%>";
    		<%-- document.getElementById("unstartExamList").innerHTML="<%=unstartExam%>"; --%>
    	});
    </script>
</body>
</html>