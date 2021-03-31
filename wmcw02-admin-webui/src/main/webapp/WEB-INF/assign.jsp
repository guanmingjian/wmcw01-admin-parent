<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%@include file="/WEB-INF/main-head.jsp" %>
<link rel="stylesheet" href="css/admin/zTreeStyle.css"/>
<script type="text/javascript" src="js/admin/jquery.ztree.all-3.5.min.js"></script>
<script>
    $(function(){

        // 获取 CSRF Token
        window.csrfToken = $("meta[name='_csrf']").attr("content");
        window.csrfHeader = $("meta[name='_csrf_header']").attr("content");

        // 调用显示Auth的树形结构数据的函数
        fillAuthTree();

        //14.给分配权限模态框中的“分配”按钮绑定单击响应函数
        $("#assignBtn").click(function(){

            // ①收集树形结构的各个节点中被勾选的节点
            // [1]声明一个专门的数组存放 id
            var authIdArray=[];

            //[2]获取 zTreeObj 对象
            var zTreeObj=$.fn.zTree.getZTreeObj("authTreeDemo");

            //[3]获取全部被勾选的节点
            var checkedNodes=zTreeObj.getCheckedNodes();

            var roleId = ${roleId};

            //[4]遍历 checkedNodes
            for(var i = 0;i < checkedNodes.length;i++){

                var checkedNode=checkedNodes[i];

                var authId=checkedNode.id;

                authIdArray.push(authId);
            }

            // ②发送请求执行分配
            var requestBody={
                "authIdArray":authIdArray,
                // 为了服务器端 handler 方法能够统一使用 List<Integer>方式接收数据， roleId 也存入数组
                "roleId":[roleId]
            };

            requestBody=JSON.stringify(requestBody);

            $.ajax({
                "url":"assign/do/role/assign/auth.json",
                "type":"post",
                "beforeSend":function (request) {
                    request.setRequestHeader(csrfHeader,csrfToken);     // 添加 CSRF Token
                },
                "data":requestBody,
                "contentType":"application/json;charset=UTF-8",
                "dataType":"json",
                "success":function(response){

                    var result=response.result;

                    if(result=="SUCCESS"){
                        layer.alert("操作成功！");
                    }
                    if(result=="FAILED"){
                        layer.alert("操作失败！"+response.message);
                    }
                },
                "error":function(response){
                    layer.alert(response.status+""+response.statusText);
                }
            });
        });
    });

    // 显示Auth的树形结构数据
    function fillAuthTree()
    {
        // 1.发送Ajax请求查询 Auth 数据
        var ajaxReturn = $.ajax({
            "url": "admin/get/auth.json",
            "type": "post",
            "beforeSend":function (request) {
                request.setRequestHeader(csrfHeader,csrfToken);     // 添加 CSRF Token
            },
            "dataType": "json",
            "async": false
        });
        if (ajaxReturn.status != 200) {
            layer.msg("请求处理出错！响应状态码是:" + ajaxReturn.status + "说明是：" + ajaxReturn.statusText);
            return;
        }
        // 2.从响应结果中获取 Auth 的 JSON 数据
        // 从服务器端查询到的 list 不需要组装成树形结构，这里我们交给 zTree 去组装
        var authList = ajaxReturn.responseJSON.data;

        // 3.准备对 zTree 进行设置的 JSON 对象
        var setting = {
            "data": {
                "simpleData": {
                    // 开启简单 JSON 功能
                    "enable": true,

                    // 使用 categoryId 属性关联父节点，不用默认的 pId 了
                    "pIdKey": "categoryId"
                },
                "key": {
                    // 使用 title 属性显示节点名称，不用默认的 name 作为属性名了
                    "name": "title"
                }
            },
            "check": {
                "enable": true
            }
        };

        //4.生成树形结构
        $.fn.zTree.init($("#authTreeDemo"), setting, authList);

        // 获取 zTreeObj 对象
        var zTreeObj = $.fn.zTree.getZTreeObj("authTreeDemo");

        // 调用 zTreeObj 对象的方法，把节点展开
        zTreeObj.expandAll(true);

        //5.查询已分配的 Auth 的 id 组成的数组
        ajaxReturn = $.ajax({
            "url": "admin/get/relationship/assign.json",
            "type": "post",
            "beforeSend":function (request) {
                request.setRequestHeader(csrfHeader,csrfToken);     // 添加 CSRF Token
            },
            "data": {
                "roleId": ${roleId}
            },
            "dataType": "json",
            "async": false
        });

        if (ajaxReturn.status != 200) {

            layer.msg("请求处理出错！响应状态码是:" + ajaxReturn.status + "说明是：" + ajaxReturn.statusText);
            return;
        }

        // 从响应结果中获取 authIdArray
        var authIdArray = ajaxReturn.responseJSON.data;

        //  6.根据 authIdArray 把树形结构中对应的节点勾选上
        // ①遍历 authIdArray
        for (var i = 0; i < authIdArray.length; i++) {

            var authId = authIdArray[i];

            // ②根据 id 查询树形结构中对应的节点
            var treeNode = zTreeObj.getNodeByParam("id", authId);

            // ③将 treeNode 设置为被勾选
            // checked 设置为 true 表示节点勾选
            var checked = true;

            //checkTypeFlag 设置为 false，表示不“联动”，不联动是为了避免把不该勾选的勾选上
            var checkTypeFlag = false;

            // 执行
            zTreeObj.checkNode(treeNode, checked, checkTypeFlag);
        }
    }
</script>
<body>

    <br>

    <div align="center">
        <ul id="authTreeDemo" class="ztree"></ul>
    </div>

    <br>

    <div align="center">
        <button id="assignBtn" class="layui-btn layui-btn-radius layui-btn-sm" >确定授权</button>
    </div>

    <br>

</body>
</html>
