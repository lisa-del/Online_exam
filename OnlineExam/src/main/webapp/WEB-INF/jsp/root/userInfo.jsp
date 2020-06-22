<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
   <title>在线考试系统</title>
   <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">  
   <script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
   <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    
       <script>
    $().ready(function() {
    	// 在键盘按下并释放及提交后验证提交表单
    	// jquery表单验证
    	  $("#pwdResetForm").validate({
    	    rules: {
    	      oldpassword: {
    	        required: true,
    	        minlength: 4
    	      },
    	      newpassword:{
    	    	required: true,
    	        minLength: 4
    	      },
    	      password_confirm: {
    	        required: true,
    	        minlength: 4,
    	        equalTo: "#newpassword"
    	        //equalTo定义了验证前后密码是否一致
    	      }
    	    }
    	    
    	   });  
    });
    </script>
    <style type="text/css">
    	body{
    			background-image:url(image/user.jpg);
    		background-size:100%;
    		background-repeat:no-repeat;
    		
    	}
    </style>
</head>
<body>
     <div class="container">
        <div class="container-fluid">
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
              <li><a href="/OnlineExam/examHistory.html">历史考试</a></li>
              <li><a href="/OnlineExam/class/">课程管理</a></li>
              
            </ul>
            <ul class="nav navbar-nav navbar-right">
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">${user.name} <span class="caret"></span></a>
                <ul class="dropdown-menu">
                  <li><a href="#">个人信息</a></li>
                  <li><a href="/OnlineExam/logout.html">退出登录</a></li>
                </ul>
              </li>
            </ul>
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
 

      <!-- Main component for a primary marketing message or call to action -->

        <div class="container-fluid">
	   <div class="panel-heading text-center">
                    <h2>用户信息管理</h2>
                </div>
               <div class="panel-body">
                    <form id="infoResetForm" class="form-horizontal" role="form" method="POST" action="userInfo.html?operate=userInfoReset">
                        <input type="hidden" name="_token" value="QFe0UARw5ThQWOQTtEetutiShrDpBZbCQBd87ypf">

                        <div class="form-group">
                            <label for="numb" class="col-md-4 control-label">账号</label>
                            <div class="col-md-6">
                                <input id="numb" type="text" class="form-control" name="numb" value="${user.numb}" autofocus>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="name" class="col-md-4 control-label">姓名</label>
                            <div class="col-md-6">
                                <input id="name" type="text" class="form-control" name="name" value="${user.name}" autofocus>
                            </div>
                        </div>

                        
                    </form>
                </div>

               
                
        	   <div class="panel-heading text-center">
                    <h2>密码重置</h2>
                </div>
                <div class="panel-body">
                    <form id="pwdResetForm" class="form-horizontal" role="form" method="POST" name="form2" action="userInfo.html?operate=passwordReset">
                        <input type="hidden" name="_token" value="QFe0UARw5ThQWOQTtEetutiShrDpBZbCQBd87ypf">

                        <div class="form-group">
                            <label for="oldpassword" class="col-md-4 control-label">旧密码</label>
                            <div class="col-md-6">
                                <input id="oldpassword" type="password" class="form-control" name="oldpassword"  required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="newpassword" class="col-md-4 control-label">新密码</label>
                            <div class="col-md-6">
                                <input id="newpassword" type="password" class="form-control" name="newpassword" required>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="password-confirm" class="col-md-4 control-label">确认密码</label>

                            <div class="col-md-6">
                                <input id="password-confirm" type="password" class="form-control" name="password_confirm"  required> 
                            </div>
                        </div>

                        <div class="form-group">

                            <label for="password-confirm" class="col-md-4 control-label"></label>
                            <div class="col-md-6">
                                <div class="g-recaptcha" data-sitekey="6Lc--SkUAAAAAFpxJNUtEhde4ACQlQySrjtL4rO9"></div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-6 col-md-offset-4">
                                <a href="userInfo.html" class="btn btn-primary">
                                    &nbsp;&nbsp;&nbsp;&nbsp;取消&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                                </a>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <button type="submit" class="btn btn-primary">
                                    &nbsp;&nbsp;&nbsp;&nbsp;确认重置&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
                
        </div>
      </div>
   <!-- /container -->
       
</body>
</html>