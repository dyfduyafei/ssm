<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>后台管理系统</title>
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta http-equiv="Cache-Control" content="no-siteapp" />

    <jsp:include page="${pageContext.request.contextPath}/WEB-INF/view/jsp/common/common.jsp" flush="true"/>

</head>
<body class="login-bg">
    
    <div class="login">
        <div class="message">用户登录</div>
        <div id="darkbannerwrap"></div>
        
        <form method="post" class="layui-form" action="/sys/login" >
            <input name="name" placeholder="用户名"  type="text" lay-verify="required" class="layui-input" >
            <hr class="hr15">
            <input name="password" lay-verify="required" placeholder="密码"  type="password" class="layui-input">
            <hr class="hr15">
            <input class="loginin" value="登录" lay-submit lay-filter="login" style="width:100%;" type="submit">
            <hr class="hr20" >
            <div>
            	<%--前端静态展示，请随意输入，即可登录。--%>
            </div>
        </form>
    </div>

    <script type="text/javascript">
        
        /*	layui.extend({
				admin: '{/}./static/js/admin'
			});
            layui.use(['form','admin'], function(){
              var form = layui.form
              	,admin = layui.admin;
              // layer.msg('玩命卖萌中', function(){
              //   //关闭后的操作
              //   });
              //监听提交
              form.on('submit(login)', function(data){
                // alert(888)
                layer.msg(JSON.stringify(data.field),function(){
                    location.href='./index.html'
                });
                return false;
              });
            });   */
    </script>  
    <!-- 底部结束 -->
</body>
</html>