<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html class="x-admin-sm">
<%@include file="/WEB-INF/main-head.jsp" %>
<body>
<div class="layui-fluid">
    <div class="layui-row">
        <form class="layui-form">
            <div class="layui-form-item">
                <label for="username" class="layui-form-label">
                    <span class="x-red">*</span>昵称
                </label>
                <div class="layui-input-inline">
                    <input type="text" id="username" name="name" value="关明健" required="" lay-verify="required"
                           autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux">
                    <span class="x-red">*</span>将会成为您唯一的登入名
                </div>
            </div>
            <div class="layui-form-item">
                <label for="L_email" class="layui-form-label">
                    <span class="x-red">*</span>邮箱
                </label>
                <div class="layui-input-inline">
                    <input type="text" id="L_email" name="email" value="1075322706@qq.com" required="" lay-verify="email"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">角色</label>
                <div class="layui-input-block">
                    <input type="checkbox" name="role1" value="1" title="超级管理员">
                    <input type="checkbox" name="role2" value="2" title="普通管理员">
                    <input type="checkbox" name="role3" value="3" title="编辑人员">
                </div>
            </div>
            <div class="layui-form-item">
                <label for="L_pass" class="layui-form-label">
                    <span class="x-red">*</span>密码
                </label>
                <div class="layui-input-inline">
                    <input type="password" id="L_pass" name="" value="123456" required="" lay-verify="pass"
                           autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux">
                    6到16个字符
                </div>
            </div>
            <div class="layui-form-item">
                <label for="L_repass" class="layui-form-label">
                    <span class="x-red">*</span>确认密码
                </label>
                <div class="layui-input-inline">
                    <input type="password" id="L_repass" name="password" value="123456" required="" lay-verify="repass"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label for="L_repass" class="layui-form-label">
                </label>
                <button  class="layui-btn" lay-filter="add" lay-submit="">
                    确定增加
                </button>
            </div>
        </form>
    </div>
</div>
<script>layui.use(['form', 'layer'],
    function() {
        $ = layui.jquery;
        var form = layui.form,
            layer = layui.layer;

        //自定义验证规则
        form.verify({
            nikename: function(value) {
                if (value.length < 5) {
                    return '昵称至少得5个字符啊';
                }
            },
            pass: [/(.+){6,12}$/, '密码必须6到12位'],
            repass: function(value) {
                if ($('#L_pass').val() != $('#L_repass').val()) {
                    return '两次密码不一致';
                }
            }
        });

        //监听提交
        form.on('submit(add)',
            function(data) {
                console.log(data);

                // 获取 CSRF Token
                window.csrfToken = $("meta[name='_csrf']").attr("content");
                window.csrfHeader = $("meta[name='_csrf_header']").attr("content");

                var arrays = [];

                var roleList = {
                    role1:data.field.role1,
                    role2:data.field.role2,
                    role3:data.field.role3
                };

                var adminList = {
                    name:data.field.name,
                    email:data.field.email,
                    password:data.field.password
                };

                arrays.push(roleList,adminList);

                $.ajax({
                    "url":"admin/do/admin/add.json",
                    "type":"post",
                    "beforeSend":function (request) {
                        request.setRequestHeader(csrfHeader,csrfToken);     // 添加 CSRF Token
                    },
                    "data":JSON.stringify(arrays),
                    "contentType":"application/json;charset=UTF-8",
                    "dataType":"json",
                    "success":function(response){

                        var result = response.result;

                        if(result == "SUCCESS") {
                            layer.msg('新增成功!',{icon:1,time:1000},function () {
                                // 关闭当前frame
                                xadmin.close();
                                // 设置刷新后的pageNum
                                window.sessionStorage.setItem('reloadPageNum','999999');
                                // 可以对父窗口进行刷新
                                xadmin.father_reload();
                            });
                        }

                        if(result == "FAILED") {
                            layer.alert("新增失败！"+response.message,{icon:0});
                        }
                    },
                    "error":function(response){
                        layer.alert("新增失败！信息:"+response.status+" "+response.statusText,{icon:0});
                    }
                });
                return false;
            });

    });</script>
<script>var _hmt = _hmt || []; (function() {
    var hm = document.createElement("script");
    hm.src = "https://hm.baidu.com/hm.js?b393d153aeb26b46e9431fabaf0f6190";
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(hm, s);
})();</script>
</body>

</html>

