<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <title>在线考试系统</title>

   <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">  
   <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
   <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
   
   <%		
     //获取cookie内保存的用户信息
	Cookie[] cookies = request.getCookies();
	String cookieNumb="";
	String cookiePassword="";
	String cookieType="";
	if(cookies!=null){
		for(int i=0;i<cookies.length;i++) {
			if(cookies[i].getName().equals("numb")) {
				cookieNumb=cookies[i].getValue();
			}
			if(cookies[i].getName().equals("password")) {
				cookiePassword=cookies[i].getValue();
			}
			if(cookies[i].getName().equals("type")) {
				cookieType=cookies[i].getValue();
			}
		} 
	}%>
	
	
 	<script type="text/javascript">
	    $().ready(function() {
	    	//实现选择框根据cookie数据自动选定
	    	if("<%=cookieNumb%>" != ""){
	    		$("#numb").val("<%=cookieNumb%>");
	    	}
	    	if("<%=cookiePassword%>" != ""){
	    		$("#password").val("<%=cookiePassword%>");
	    	}
	    });
	</script>
     <style type="text/css">
     
     body{
        background:aliceblue;
        background-image: url("image/login.jpg");
        background-size:100%;
             }
               #footer {

                height: 40px;

                line-height: 40px;

                position: absolute;
                margin:100px auto;

                bottom: 20px;

                width: 100%;

                text-align: center;

                background: #333;

                color: #fff;

                font-family: Arial;

                font-size: 12px;

                letter-spacing: 1px;

            }
        
    </style>
</head>
<body >

  <div class="container">
               <div class="header" align="center">
               <h2><img src="image/logo.jpg" width=50px height=50px/></h2>
                    <h2>博考在线考试系统</h2>
                </div>
                <div class="content">
                    <form id="loginForm" class="form-horizontal" role="form" method="POST" action="/OnlineExam/?operate=login">
                        <input type="hidden" name="_token" value="QFe0UARw5ThQWOQTtEetutiShrDpBZbCQBd87ypf">
                        <div class="form-group">
                            <label for="numb" class="col-md-4 control-label" >账号</label>
                            <div class="col-md-6">
                                <input id="numb" type="text" style="background:white;"
                                 class="form-control" name="numb" value="" required >
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="password" class="col-md-4 control-label">密码</label>

                            <div class="col-md-6">
                                <input id="password" type="password" style="background:white;"
                                 class="form-control" name="password" value="" required >
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="userType" class="col-md-4 control-label">身份</label>

                            <div class="col-md-6">
                                <select class="form-control" id="userType" style="background:white;"
                                 name="userType" required>
							         <option value="1">学生</option>
							         <option value="0">管理员</option>
						        </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-md-6 col-md-offset-4">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="remember" > Remember Me
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-md-8 col-md-offset-4">
                                <button type="submit" class="btn btn-primary">
                                                                                                登录
                                </button>
                                <a class="btn btn-link" href="register.html">
                           		         注册
                                </a>
                            </div>
                        </div>
                    </form>
               <div class="footer">
             <h4 align="center">作者:李凤玲 康莹 麦尔哈巴</h4>
             <h4 align="center">时间:2020-6-20</h4>
             <hr/>
             <h5 align="center">CopyRight@copy2020</h5>
         </div>
          </div>
          </div>
</body>
</html>


