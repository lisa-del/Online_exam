<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
   <title>在线考试系统</title>
   <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">  
   <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
   <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
   
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
      
      $().ready(function() {
    	  $.ajax({
    		    url:'/OnlineExam/exam/list.html',
    		    type:'POST', //GET
    		    async:true,    //或false,是否异步
    		    data:null,
    		    timeout:5000,    //超时时间
    		    dataType:'json',    //返回的数据格式：json/xml/html/script/jsonp/text
    		    beforeSend:function(xhr){
    		        console.log(xhr)
    		        console.log('发送前')
    		    },
    		    success:function(data,textStatus,jqXHR){
    		        console.log("data:"+data)
    		        console.log("textStatus"+textStatus)
    		        console.log("jqXHR"+jqXHR)
    		        
    		        var str = "<thead><tr> <th width=3%>考试名称</th>"
    		        +"<th width=2%>开始时间</th><th width=2%>结束时间</th><th width=2%>时长</th>"
    		        +"<th width=2%>状态</th><th width=2%>操作</th></tr></thead><tbody>"
    		        for(var i=0;i<data.inList.length;i++){
    		        	str=str+"<tr>"
						+"<td>"+data.inList[i].name+"</td>"
						+"<td>"+dateTransfer(data.inList[i].startTime)+"</td>"
						+"<td>"+dateTransfer(data.inList[i].endTime)+"</td>"
						+"<td>"+data.inList[i].length+"</td>"
						+"<td>未参加</td>"
						+"<td><button style=\"border:none;color:blue;\" onclick=\"queryExam("+data.inList[i].id+")\">进入考试</button></td>"
					    +"</tr>"
    		        }
    		       /*  for(var i=0;i<data.before.length;i++){
    		        	str=str+"<tr>"
						+"<td>"+data.inList[i].name+"</td>"
						+"<td>"+dateTransfer(data.inList[i].startTime)+"</td>"
						+"<td>"+dateTransfer(data.inList[i].endTime)+"</td>"
						+"<td>"+data.beforeList[i].length+"</td>"
						+"<td>未开始</td>"
						+"<td><button style=\"border:none;color:blue;\" onclick=\"queryExam("+data.beforeList[i].id+")\">请等待</button></td>"
					    +"</tr>"
    		        } */
        		    for(var i=0;i<data.lastList.length;i++){
        		    	str=str+"<tr>"
						+"<td>"+data.lastList[i].name+"</td>"
						+"<td>"+dateTransfer(data.lastList[i].startTime)+"</td>"
						+"<td>"+dateTransfer(data.lastList[i].endTime)+"</td>"
						+"<td>"+data.lastList[i].length+"</td>"
						+"<td>已结束</td>"
						+"<td><button style=\"border:none;color:blue;\" onclick=\"queryExamDetail("+data.lastList[i].id+")\">查看结果</button></td>"
					    +"</tr>"
        		    	
        		    }
        		    str=str+"</tbody>"
        		    document.getElementById("inExamTable").innerHTML=str
        		    	
    		    },
    		    error:function(xhr,textStatus){
    		        console.log('错误')
    		        console.log(xhr)
    		        console.log(textStatus)
    		    },
    		    complete:function(){
    		        console.log('结束')
    		    }
    		})
      });
   </script>
   <style type="text/css">
   	body{
   	background:aliceblue;
   	}	
   
   </style>
</head>
<body>
  <div class="container">
      <!-- Static navbar -->
        <div class="container-fluid">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <div><img src="/OnlineExam/image/logo.jpg" width=50px height=50px/>博考</div>
          </div>
          <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
              <li class="active"><a href="#">考试</a></li>
              <li><a href="/OnlineExam/exam/studentExamHistory.html">历史记录</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">${user.name} <span class="caret"></span></a>
                <ul class="dropdown-menu">
                  <li><a href="/OnlineExam/userInfo.html">个人信息</a></li>
                  <li><a href="/OnlineExam/logout">退出登录</a></li>
                </ul>
              </li>
            </ul>
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->

      <!-- Main component for a primary marketing message or call to action -->
 
        <div class="container-fluid">
	    <div class="row-fluid">
		<div class="span12">
			<h3>考试</h3>
			<table class="table" id="inExamTable">
				<thead>
					<tr>
						<th>考试名称</th>
						<th>开始时间</th>
						<th>结束时间</th>
						<th>时长</th>
						<th>状态</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				
				</tbody>
			</table>
		</div>
	</div>
</div>
      </div>

 <!-- /container -->
    
    <script>
    	function queryExam(id){
      	   window.location.href = "/OnlineExam/exam/queryExam.html?examId="+id;
    	}
    	
    	function queryExamDetail(id){
    		window.location.href = "/OnlineExam/exam/paperDetail.html?examId="+id+"&studentNumb=${user.numb}";
    	}
    </script>
</body>
</html>