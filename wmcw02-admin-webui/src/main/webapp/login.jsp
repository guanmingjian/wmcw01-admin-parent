<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html  class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>后台登录-智联麻涌</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" href="css/admin/font.css">
    <link rel="stylesheet" href="css/admin/xadmin.css">
    <link rel="stylesheet" href="css/admin/login.css">
    <script type="text/javascript" src="js/jquery-3.2.1.min.js"></script>
    <script src="lib/layui/layui.js" charset="utf-8"></script>
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <style>
        .layui-form-checked span, .layui-form-checked:hover span {
            background-color: #189F92;
        }
    </style>

</head>
<body class="login-bg">

    <div class="login layui-anim layui-anim-up">

        <c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION.message }">
            <div class="layui-elem-quote">
                <p style="color:#FF5722">${SPRING_SECURITY_LAST_EXCEPTION.message }</p>
            </div>
        </c:if>

        <div class="message">欢迎登录智联麻涌后台</div>
        <div id="darkbannerwrap"></div>

        <form action="security/do/login.html" method="post" class="layui-form" >
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <input name="name" placeholder="用户名" type="text" lay-verify="required" class="layui-input" >
            <hr class="hr15">

            <input name="password" lay-verify="required" placeholder="密码" type="password" class="layui-input">
            <hr class="hr15">

            <input type="checkbox" name="remember-me" title="14天免登陆">
            <hr class="hr15">

            <input value="登录" lay-submit lay-filter="login" style="width:100%;" type="submit">
            <hr class="hr20">

        </form>
    </div>

    <script>
        $(function  () {
            layui.use('form', function(){
                var form = layui.form;
                form.render();
            });
        })
    </script>

</body>
</html>

