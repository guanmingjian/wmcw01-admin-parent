<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html class="x-admin-sm">
<%@include file="/WEB-INF/main-head.jsp" %>
<link rel="stylesheet"href="css/admin/pagination.css">
<script type="text/javascript" src="js/admin/jquery.pagination.js"></script>
<script type="text/javascript" charset=UTF-8">
    $(function(){

        // 获取 CSRF Token
        window.csrfToken = $("meta[name='_csrf']").attr("content");
        window.csrfHeader = $("meta[name='_csrf_header']").attr("content");

        // 获取类型
        window.type = ${requestScope.type}

        // 获取需要跳转的页数
        var reloadPageNum =window.sessionStorage.getItem('reloadPageNum');

        // 设置新的跳转页数
        if(reloadPageNum!=null){
            // 设置新的pageNum
            window.pageNum=reloadPageNum;
            // 清除reloadPageNum
            window.sessionStorage.removeItem('reloadPageNum');
        }else{
            window.pageNum=1;
            // 把pageNum放到session种
            window.sessionStorage.setItem('pageNum',window.pageNum);
        }

        window.pageSize = 10;
        window.keyword = "";

        // 2.给查询按钮绑定单击响应函数
        $("#searchBtn").click(function(){

            // ①获取关键词数据赋值给对应的全局变量
            window.keyword = $("#keywordInput").val();
            // ②调用分页函数刷新页面
            generatePage();

            return false;
        });

        // 3.调用执行分页的函数，显示分页效果
        generatePage();
    });

    // 执行分页，生成页面效果，任何时候调用这个函数都会重新加载页面
    function generatePage() {

        // 1.获取分页数据
        var pageInfo = getPageInfoRemote();

        // 2.填充表格
        fillTableBody(pageInfo);

    }

    // 远程访问服务器端程序获取pageInfo数据
    function getPageInfoRemote() {

        // 调用$.ajax()函数发送请求并接受$.ajax()函数的返回值
        var ajaxResult = $.ajax({
            "url": "admin/get/admin-map.json",
            "type":"post",
            "beforeSend":function (request) {
                request.setRequestHeader(csrfHeader,csrfToken);     // 添加 CSRF Token
            },
            "data": {
                "pageNum": window.pageNum,
                "pageSize": window.pageSize,
                "keyword": window.keyword,
                "type": window.type
            },
            "async":false,
            "dataType":"json"
        });

        console.log(ajaxResult);

        // 判断当前响应状态码是否为200
        var statusCode = ajaxResult.status;

        // 如果当前响应状态码不是200，说明发生了错误或其他意外情况，显示提示消息，让当前函数停止执行
        if(statusCode != 200) {
            layer.msg("失败！响应状态码="+statusCode+" 说明信息="+ajaxResult.statusText);
            return null;
        }

        // 如果响应状态码是200，说明请求处理成功，获取pageInfo
        var resultEntity = ajaxResult.responseJSON;

        // 从resultEntity中获取result属性
        var result = resultEntity.result;

        // 判断result是否成功
        if(result == "FAILED") {
            layer.msg(resultEntity.message);
            return null;
        }

        // 确认result为成功后获取pageInfo
        var pageInfo = resultEntity.data;

        // 返回pageInfo
        return pageInfo;
    }

    // 填充表格
    function fillTableBody(pageInfo) {

        // 清除tbody中的旧的内容
        $("#PageBody").empty();

        // 这里清空是为了让没有搜索结果时不显示页码导航条
        $("#Pagination").empty();

        // 判断pageInfo对象是否有效
        if(pageInfo == null || pageInfo == undefined || pageInfo.list == null || pageInfo.list.length == 0) {

            $("#PageBody").append("<tr><td colspan='4' align='center'>抱歉！没有查询到您搜索的数据！</td></tr>");

            return ;
        }

        // 使用pageInfo的list属性填充tbody
        for(var i = 0; i < pageInfo.list.length; i++) {

            var object = pageInfo.list[i];

            var id = object.id;
            var longitude = object.longitude;
            var latitude = object.latitude;
            var location = object.location;

            var checkboxTd = "<td><input type=\"checkbox\" name=\"name\" value='"+id+"' lay-skin=\"primary\"></td>";
            var numberTd = "<td>"+id+"</td>";
            var longitudeTd = "<td>"+longitude+"</td>";
            var latitudeTd = "<td>"+latitude+"</td>";
            var locationTd = "<td>"+location+"</td>";

            var showBtn = "<a title=\"查看\" onclick=\"xadmin.open('查看','admin/seekMap/"+id+".html')\" href=\"javascript:;\"><i class=\"layui-icon\">&#xe63c;</i></a>";

            var removeBtn = "<a title=\"删除\" onclick=\"member_del(this,'"+id+"')\" href=\"javascript:;\"><i class=\"layui-icon\">&#xe640;</i></a>";

            var buttonTd = "<td class=\"td-manage\">"+showBtn+" "+removeBtn+"</td>";

            var tr = "<tr>"+checkboxTd+numberTd+longitudeTd+latitudeTd+locationTd+buttonTd+"</tr>";

            $("#PageBody").append(tr);
        }

        // 生成分页导航条
        generateNavigator(pageInfo);
        //重新渲染勾选框
        layui.form.render("checkbox");
    }

    // 生成分页页码导航条
    function generateNavigator(pageInfo) {

        // 获取总记录数
        var totalRecord = pageInfo.total;

        // 声明相关属性
        var properties = {
            "num_edge_entries": 2,
            "num_display_entries": 3,
            "callback": paginationCallBack,
            "items_per_page": pageInfo.pageSize,
            "current_page": pageInfo.pageNum - 1,
            "prev_text": "上一页",
            "next_text": "下一页"
        }

        // 调用pagination()函数
        $("#Pagination").pagination(totalRecord, properties);
    }

    // 翻页时的回调函数
    function paginationCallBack(pageIndex, jQuery) {

        // 修改window对象的pageNum属性
        window.pageNum = pageIndex + 1;

        //记录当前的的pageNum
        window.sessionStorage.setItem('pageNum',window.pageNum);

        // 调用分页函数
        generatePage();

        // 取消页码超链接的默认行为
        return false;
    }

</script>

<body>
<div class="x-nav">
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新">
        <i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-body ">
                    <form class="layui-form layui-col-space5">
                        <div class="layui-inline layui-show-xs-block">
                            <input id="keywordInput" type="text" placeholder="请输入..." class="layui-input">
                        </div>
                        <div class="layui-inline layui-show-xs-block">
                            <button id="searchBtn" class="layui-btn" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
                        </div>
                    </form>
                </div>
                <div class="layui-card-header">
                    <button class="layui-btn layui-btn-danger" onclick="delAll()"><i class="layui-icon"> </i>批量删除</button>
                    <button class="layui-btn" onclick="xadmin.open('新增坐标','admin/get/map/${requestScope.type}/add.html')"><i class="layui-icon"> </i>新增坐标</button>
                </div>
                <div class="layui-card-body layui-table-body layui-table-main">
                    <table class="layui-table layui-form">
                        <!-- 表头模块 -->
                        <thead>
                        <tr>
                            <th>
                                <input type="checkbox" lay-filter="checkall" name=""  lay-skin="primary">
                            </th>
                            <th>编号</th>
                            <th>经度</th>
                            <th>纬度</th>
                            <th>位置</th>
                            <th>操作</th>
                        <tr>
                        </thead>
                        <!-- 列表模块 -->
                        <tbody id="PageBody"></tbody>
                    </table>
                </div>
                <!-- 分页模块 -->
                <div class="layui-card-body ">
                    <div class="page">
                        <div id="Pagination" class="pagination">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    layui.use(['laydate','form'], function(){
        var form = layui.form;

        // 监听全选
        form.on('checkbox(checkall)', function(data){

            if(data.elem.checked){
                $('tbody input').prop('checked',true);
            }else{
                $('tbody input').prop('checked',false);
            }
            form.render('checkbox');
        });

    });

    /*停用功能*/
    function member_stop(obj,id){

        if($(obj).attr('title')=='停用'){

            layer.confirm('确认要停用吗？',function(index) {

                $.ajax({
                    "url":"admin/do/role/" + id + "/0/status.json",
                    "type":"post",
                    "beforeSend":function (request) {
                        request.setRequestHeader(csrfHeader,csrfToken);     // 添加 CSRF Token
                    },
                    "success":function(response){
                        var result = response.result;

                        if (result == "SUCCESS") {

                            //修改前端效果
                            $(obj).attr('title', '启用')
                            $(obj).find('i').html('&#x1005;');
                            $("#statusSpan" + id).addClass('layui-btn-disabled').html('已停用')

                            layer.msg('已停用!', {icon: 0, time: 1000});
                        }
                        if (result == "FAILED") {
                            layer.alert("操作失败！" + response.message, {icon: 0});
                        }
                    },
                    "error":function(response){
                        layer.alert("操作失败！信息:" + response.status + " " + response.statusText, {icon: 0});
                    }
                });
            });
        }

        if($(obj).attr('title')=='启用'){

            layer.confirm('确认要启用吗？',function(index) {

                $.ajax({
                    "url":"admin/do/role/"+id+"/1/status.json",
                    "type":"post",
                    "beforeSend":function (request) {
                        request.setRequestHeader(csrfHeader,csrfToken);     // 添加 CSRF Token
                    },
                    "success":function(response){
                        var result = response.result;

                        if (result == "SUCCESS") {

                            //修改前端效果
                            $(obj).attr('title','停用')
                            $(obj).find('i').html('&#x1007;');
                            $("#statusSpan"+id).removeClass('layui-btn-disabled').html('已启用');

                            layer.msg('已启用!',{icon: 1,time:1000});
                        }
                        if (result == "FAILED") {
                            layer.alert("操作失败！" + response.message, {icon: 0});
                        }
                    },
                    "error":function(response){
                        layer.alert("操作失败！信息:" + response.status + " " + response.statusText, {icon: 0});
                    }
                });
            });
        }
    }


    /*删除功能*/
    function member_del(obj,id){
        layer.confirm('确认要删除吗？'+'<br>'+'ID：'+id,function(index){
            var idArray = [];
            idArray.push(id);

            var requestBody = JSON.stringify(idArray);

            $.ajax({
                "url":"admin/map/delete.json",
                "type":"post",
                "beforeSend":function (request) {
                    request.setRequestHeader(csrfHeader,csrfToken);     // 添加 CSRF Token
                },
                "data":requestBody,
                "contentType":"application/json;charset=UTF-8",
                "dataType":"json",
                "success":function(response){

                    var result = response.result;

                    if(result == "SUCCESS") {
                        layer.msg("删除成功！");
                        $(obj).parents("tr").remove();
                    }

                    if(result == "FAILED") {
                        layer.alert('删除失败!'+response.message,{icon:0},function () {
                            //获取当前的页数
                            var pageNum =window.sessionStorage.getItem('pageNum');
                            //设置刷新后的pageNum
                            window.sessionStorage.setItem('reloadPageNum',pageNum);
                            //关闭当前frame
                            xadmin.close();
                            // 可以对父窗口进行刷新
                            xadmin.father_reload();
                        });
                    }
                },
                "error":function(response){
                    layer.alert("删除失败！信息:"+response.status+" "+response.statusText,{icon:0},function () {
                        //获取当前的页数
                        var pageNum =window.sessionStorage.getItem('pageNum');
                        //设置刷新后的pageNum
                        window.sessionStorage.setItem('reloadPageNum',pageNum);
                        //关闭当前frame
                        xadmin.close();
                        // 可以对父窗口进行刷新
                        xadmin.father_reload();
                    });
                }
            });
            return false;
        });
    }

    /*多项删除功能*/
    function delAll (argument) {
        var idArray = [];

        // 获取选中的id
        $('tbody input').each(function(index, el) {
            if($(this).prop('checked')){
                idArray.push($(this).val());
            }
        });

        layer.confirm('确认要删除吗？'+'<br>'+'ID：'+idArray.toString(),function(index){

            //转换为JSON字符串
            var requestBody = JSON.stringify(idArray);

            $.ajax({
                "url":"admin/map/delete.json",
                "type":"post",
                "beforeSend":function (request) {
                    request.setRequestHeader(csrfHeader,csrfToken);     // 添加 CSRF Token
                },
                "data":requestBody,
                "contentType":"application/json;charset=UTF-8",
                "dataType":"json",
                "success":function(response){

                    var result = response.result;

                    if(result == "SUCCESS") {
                        layer.msg("删除成功！");
                        $(".layui-form-checked").not('.header').parents('tr').remove();
                    }

                    if(result == "FAILED") {
                        layer.alert('删除失败!'+response.message,{icon:0},function () {
                            //获取当前的页数
                            var pageNum =window.sessionStorage.getItem('pageNum');
                            //设置刷新后的pageNum
                            window.sessionStorage.setItem('reloadPageNum',pageNum);
                            //关闭当前frame
                            xadmin.close();
                            // 可以对父窗口进行刷新
                            xadmin.father_reload();
                        });
                    }

                },
                "error":function(response){
                    layer.alert("删除失败！信息:"+response.status+" "+response.statusText,{icon:0},function () {
                        //获取当前的页数
                        var pageNum =window.sessionStorage.getItem('pageNum');
                        //设置刷新后的pageNum
                        window.sessionStorage.setItem('reloadPageNum',pageNum);
                        //关闭当前frame
                        xadmin.close();
                        // 可以对父窗口进行刷新
                        xadmin.father_reload();
                    });
                }
            });
            return false;
        });
    }
</script>
<script>
    var _hmt = _hmt || []; (function() {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?b393d153aeb26b46e9431fabaf0f6190";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>
</html>
