<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html class="x-admin-sm">
<%@include file="/WEB-INF/main-head.jsp" %>

<script type="text/javascript">
    function logoutAnchor(){

        document.getElementById("logoutForm").submit();

    };
</script>

<body class="index">
<!-- 顶部开始 -->
<div class="container">
    <div class="logo">
        <a href="to/main.html">智联麻涌后台</a></div>
    <div class="left_open">
        <a><i title="展开左侧栏" class="iconfont">&#xe699;</i></a>
    </div>
    <ul class="layui-nav right" lay-filter="">
        <li class="layui-nav-item">
            <a href="javascript:;">
                <security:authentication property="principal.username"/>
            </a>
            <dl class="layui-nav-child">
                <!-- 二级菜单 -->
                <dd>
                    <a onclick="xadmin.open('个人信息','http://www.baidu.com')">个人信息</a>
                </dd>
                <dd>
                    <a onclick="xadmin.open('修改信息','http://www.baidu.com')">修改信息</a>
                </dd>
                <dd>
                    <a onclick="javascript:logoutAnchor()">退出</a>
                </dd>

                <form id="logoutForm" action="/security/do/logout.html" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </form>

            </dl>
        </li>
        <li class="layui-nav-item to-index">
            <a href="http://oreo5.cn/">首页</a>
        </li>
    </ul>
</div>
<!-- 顶部结束 -->
<!-- 中部开始 -->
<!-- 左侧菜单开始 -->
<div class="left-nav">
    <div id="side-nav">
        <ul id="nav">

            <li>
                <a href="javascript:;">
                    <i class="iconfont left-nav-li" lay-tips="会员管理">&#xe6b8;</i>
                    <cite>成员管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i></a>
                <ul class="sub-menu">

                    <li>
                        <a  onclick="xadmin.add_tab('成员统计','userStats.html')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>成员统计</cite></a>
                    </li>

                    <li>
                        <a  onclick="xadmin.add_tab('成员列表','userList.html')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>成员列表</cite></a>
                    </li>

                    <li>
                        <a  onclick="xadmin.add_tab('成员恢复','userRecover.html')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>成员恢复</cite></a>
                    </li>
                </ul>
            </li>

            <li>
                <a href="javascript:;">
                    <i class="iconfont left-nav-li" lay-tips="管理员管理">&#xe726;</i>
                    <cite>管理员管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i></a>
                <ul class="sub-menu">
                    <li>
                        <a onclick="xadmin.add_tab('管理员列表','adminList.html')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>管理员列表</cite></a>
                    </li>
                    <li>
                        <a onclick="xadmin.add_tab('角色管理','role.html')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>角色管理</cite></a>
                    </li>
                    <li>
                        <a onclick="xadmin.add_tab('权限管理','adminRule.html')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>权限管理</cite></a>
                    </li>
                </ul>
            </li>

            <li>
                <a href="javascript:;">
                    <i class="iconfont left-nav-li" lay-tips="文章管理">&#xe699;</i>
                    <cite>文章管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i></a>
                <ul class="sub-menu">
                    <li>
                        <a onclick="xadmin.add_tab('文章发布','articlePublish.html')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>文章发布</cite></a>
                    </li>
                    <li>
                        <a onclick="xadmin.add_tab('美食文章','article.html?type=1')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>美食文章</cite></a>
                    </li>
                    <li>
                        <a onclick="xadmin.add_tab('酒店文章','article.html?type=2')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>酒店文章</cite></a>
                    </li>
                    <li>
                        <a onclick="xadmin.add_tab('人文文章','article.html?type=3')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>人文文章</cite></a>
                    </li>
                    <li>
                        <a onclick="xadmin.add_tab('新闻文章','article.html?type=4')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>新闻文章</cite></a>
                    </li>
                    <li>
                        <a onclick="xadmin.add_tab('娱乐文章','article.html?type=5')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>娱乐文章</cite></a>
                    </li>
                </ul>
            </li>

            <li>
                <a href="javascript:;">
                    <i class="iconfont left-nav-li" lay-tips="吃喝住行">&#xe6e3;</i>
                    <cite>吃喝住行</cite>
                    <i class="iconfont nav_right">&#xe697;</i></a>
                <ul class="sub-menu">
                    <li>
                        <a onclick="xadmin.add_tab('美食管理','article.html?type=1')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>美食管理</cite></a>
                    </li>
                    <li>
                        <a onclick="xadmin.add_tab('酒店管理','hotel.html')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>酒店管理</cite></a>
                    </li>
                    <li>
                        <a onclick="xadmin.add_tab('娱乐管理','article.html?type=5')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>娱乐管理</cite></a>
                    </li>

                </ul>
            </li>

            <li>
                <a href="javascript:;">
                    <i class="iconfont left-nav-li" lay-tips="图片管理">&#xe6a8;</i>
                    <cite>图片管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i></a>
                <ul class="sub-menu">
                    <li>
                        <a onclick="xadmin.add_tab('华阳湖美图','photo.html?type=1')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>华阳湖美图</cite></a>
                    </li>
                    <li>
                        <a onclick="xadmin.add_tab('渔人码头美图','photo.html?type=2')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>创客坊美图</cite></a>
                    </li>
                    <li>
                        <a onclick="xadmin.add_tab('大学美图','photo.html?type=3')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>大学美图</cite></a>
                    </li>
                </ul>
            </li>

            <li>
                <a href="javascript:;">
                    <i class="iconfont left-nav-li" lay-tips="智能地图">&#xe828;</i>
                    <cite>智能地图</cite>
                    <i class="iconfont nav_right">&#xe697;</i></a>
                <ul class="sub-menu">
                    <li>
                        <a onclick="xadmin.add_tab('公共汽车','map.html?type=1')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>公共汽车</cite></a>
                    </li>
                    <li>
                        <a onclick="xadmin.add_tab('公共单车','map.html?type=2')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>公共单车</cite></a>
                    </li>
                    <li>
                        <a onclick="xadmin.add_tab('公共厕所','map.html?type=3')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>公共厕所</cite></a>
                    </li>
                    <li>
                        <a onclick="xadmin.add_tab('停车位','map.html?type=4')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>停车位</cite></a>
                    </li>
                </ul>
            </li>

            <li>
                <a href="javascript:;">
                    <i class="iconfont left-nav-li" lay-tips="智能导览">&#xe811;</i>
                    <cite>智能导览</cite>
                    <i class="iconfont nav_right">&#xe697;</i></a>
                <ul class="sub-menu">
                    <li>
                        <a onclick="xadmin.add_tab('全景麻涌','https://720yun.com/t/6fbj5ptmuw7?scene_id=22126438')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>全景麻涌</cite></a>
                    </li>
                    <li>
                        <a onclick="xadmin.add_tab('全景华阳湖','https://720yun.com/t/6fbj5ptmuw7?scene_id=11041604')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>全景华阳湖</cite></a>
                    </li>
                    <li>
                        <a onclick="xadmin.add_tab('全景大学','https://720yun.com/t/07f25wbfmer?scene_id=4005392')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>全景大学</cite></a>
                    </li>
                </ul>
            </li>

            <li>
                <a href="javascript:;">
                    <i class="iconfont left-nav-li" lay-tips="个人智能系统">&#xe7ce;</i>
                    <cite>智能分析系统</cite>
                    <i class="iconfont nav_right">&#xe697;</i></a>
                <ul class="sub-menu">
                    <li>
                        <a onclick="xadmin.add_tab('喜好度分析','chart-xihaodu.html')" target="">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>喜好度分析</cite></a>
                    </li>
                    <li>
                        <a onclick="xadmin.add_tab('千人千面推荐','chart-qianrenqianmian.html')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>千人千面推荐</cite></a>
                    </li>
                    <li>
                        <a onclick="xadmin.add_tab('消费水平分析','chart-xiaofeishuiping.html')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>消费水平分析</cite></a>
                    </li>
                    <li>
                        <a onclick="xadmin.add_tab('消费类型分析','chart-xiaofeileixing.html')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>消费类型分析</cite></a>
                    </li>
                    <li>
                        <a onclick="xadmin.add_tab('功能使用统计','chart-gongnengshiyong.html')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>功能使用统计</cite></a>
                    </li>
                </ul>
            </li>

            <li>
                <a href="javascript:;">
                    <i class="iconfont left-nav-li" lay-tips="智能统计系统">&#xe696;</i>
                    <cite>智能统计系统</cite>
                    <i class="iconfont nav_right">&#xe697;</i></a>
                <ul class="sub-menu">
                    <li>
                        <a onclick="xadmin.add_tab('访问量统计','chart-fangwenliang.html')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>访问量统计</cite></a>
                    </li>
                    <li>
                        <a onclick="xadmin.add_tab('分享量统计','chart-fenxiangliang.html')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>分享量统计</cite></a>
                    </li>
                    <li>
                        <a onclick="xadmin.add_tab('收藏量统计','chart-shoucangliang.html')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>收藏量统计</cite></a>
                    </li>
                </ul>
            </li>

            <li>
                <a href="javascript:;">
                    <i class="iconfont left-nav-li" lay-tips="日志管理">&#xe6ce;</i>
                    <cite>日志管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i></a>
                <ul class="sub-menu">
                    <li>
                        <a onclick="xadmin.add_tab('更新日志','logDelete.html')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>更新日志</cite></a>
                    </li>
                    <li>
                        <a onclick="xadmin.add_tab('新增日志','logAdd.html')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>新增日志</cite></a>
                    </li>
                    <li>
                        <a onclick="xadmin.add_tab('删除日志','logDelete.html')">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>删除日志</cite></a>
                    </li>
                </ul>
            </li>

        </ul>
    </div>
</div>
<!-- <div class="x-slide_left"></div> -->
<!-- 左侧菜单结束 -->
<!-- 右侧主体开始 -->
<div class="page-content">
    <div class="layui-tab tab" lay-filter="xbs_tab" lay-allowclose="false">
        <ul class="layui-tab-title">
            <li class="home">
                <i class="layui-icon">&#xe68e;</i>我的桌面</li></ul>
        <div class="layui-unselect layui-form-select layui-form-selected" id="tab_right">
            <dl>
                <dd data-type="this">关闭当前</dd>
                <dd data-type="other">关闭其它</dd>
                <dd data-type="all">关闭全部</dd></dl>
        </div>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <iframe src='userStats.html' frameborder="0" scrolling="yes" class="x-iframe"></iframe>
            </div>
        </div>
        <div id="tab_show"></div>
    </div>
</div>
<div class="page-content-bg"></div>
<style id="theme_style"></style>
<!-- 右侧主体结束 -->
<!-- 中部结束 -->
</body>
</html>