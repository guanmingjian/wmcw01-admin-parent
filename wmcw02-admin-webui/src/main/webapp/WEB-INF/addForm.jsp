<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html class="x-admin-sm">
<%@include file="/WEB-INF/main-head.jsp" %>
<body>
<div class="layui-fluid">
    <div class="layui-row">
        <form class="layui-form">

            <!-- 迭代出表单标题 -->
            <c:forEach items="${Form.data}" var="map">
                <div class="layui-form-item">
                    <label class="layui-form-label">
                            ${map.key}
                    </label>
                    <div class="layui-input-inline">
                        <input type="text" name="${map.value}" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </c:forEach>

            <div class="layui-form-item">
                <label class="layui-form-label"></label>
                <button class="layui-btn" lay-filter="add" lay-submit="">确认新增</button>
            </div>

        </form>
    </div>
</div>

<script>
    layui.use(['form', 'layer','jquery'],
        function() {
            $ = layui.jquery;
            var form = layui.form,
                layer = layui.layer;

            //监听提交
            form.on('submit(add)',
                function(data) {
                    console.log(data);

                    // 获取 CSRF Token
                    window.csrfToken = $("meta[name='_csrf']").attr("content");
                    window.csrfHeader = $("meta[name='_csrf_header']").attr("content");

                    $.ajax({
                        "url":"${Form.url}",
                        "type":"post",
                        "beforeSend":function (request) {
                            request.setRequestHeader(csrfHeader,csrfToken);     // 添加 CSRF Token
                        },
                        "data":JSON.stringify(data.field),
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
                                layer.alert("新增失败！" + response.message, {icon: 0});
                            }

                        },
                        "error":function(response){
                            layer.alert("新增失败！信息:"+response.status+" "+response.statusText,{icon:0});
                        }
                    });

                    return false;
                });

        });
</script>

<script>
    var _hmt = _hmt || []; (function() {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?b393d153aeb26b46e9431fabaf0f6190";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>

</body>
</html>
