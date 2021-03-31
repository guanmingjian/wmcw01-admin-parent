<%@ page language="java" import="java.util.*,java.text.SimpleDateFormat" pageEncoding="utf-8"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%
	Date d = new Date();
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String now = df.format(d);
%>
<!DOCTYPE html>
<html class="x-admin-sm">
    <%@include file="/WEB-INF/main-head.jsp" %>
    <body>
        <div class="layui-fluid">
            <div class="layui-row layui-col-space15">
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-card-body ">
                            <blockquote class="layui-elem-quote">欢迎管理员：
                                <span class="x-red"><security:authentication property="principal.username"/></span>！当前时间:<%=now %>
                            </blockquote>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-card-header">成员数据统计</div>
                        <div class="layui-card-body ">
                            <ul class="layui-row layui-col-space10 layui-this x-admin-carousel x-admin-backlog">
                                <li class="layui-col-md2 layui-col-xs6">
                                    <a href="javascript:;" class="x-admin-backlog-body">
                                        <h3>成员总数</h3>
                                        <p>
                                            <cite>82</cite></p>
                                    </a>
                                </li>
                                <li class="layui-col-md2 layui-col-xs6">
                                    <a href="javascript:;" class="x-admin-backlog-body">
                                        <h3>今月新增成员人数</h3>
                                        <p>
                                            <cite>20</cite></p>
                                    </a>
                                </li>
                                <li class="layui-col-md2 layui-col-xs6">
                                    <a href="javascript:;" class="x-admin-backlog-body">
                                        <h3>今日新增成员人数</h3>
                                        <p>
                                            <cite>8</cite></p>
                                    </a>
                                </li>
                                <li class="layui-col-md2 layui-col-xs6">
                                    <a href="javascript:;" class="x-admin-backlog-body">
                                        <h3>比上月新增人数</h3>
                                        <p>
                                            <cite>10</cite></p>
                                    </a>
                                </li>
                                <li class="layui-col-md2 layui-col-xs6">
                                    <a href="javascript:;" class="x-admin-backlog-body">
                                        <h3>比昨日新增人数</h3>
                                        <p>
                                            <cite>5</cite></p>
                                    </a>
                                </li>
                                <li class="layui-col-md2 layui-col-xs6">
                                    <a href="javascript:;" class="x-admin-backlog-body">
                                        <h3>进入增长比</h3>
                                        <p>
                                            <cite>15%</cite></p>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="layui-col-sm12 layui-col-md6">
					<div class="layui-card">
						<div class="layui-card-header">最新一周新增用户</div>
						<div class="layui-card-body" style="min-height: 280px;">
							<div id="main1" class="layui-col-sm12" style="height: 300px;"></div>

						</div>
					</div>
				</div>
                <div class="layui-col-sm12 layui-col-md6">
                    <div class="layui-card">
                        <div class="layui-card-header">用户性别分析</div>
                        <div class="layui-card-body" style="min-height: 280px;">
                            <div id="main2" class="layui-col-sm12" style="height: 300px;"></div>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md12">
                    <blockquote class="layui-elem-quote layui-quote-nm">奥利奥队 仅供学习使用</blockquote>
                </div>
            </div>
        </div>
    </body>

    <script src="js/echarts1.js"></script>
    <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main1'));

        // 指定图表的配置项和数据
        var option = {
            grid: {
                top: '5%',
                right: '1%',
                left: '1%',
                bottom: '10%',
                containLabel: true
            },
            tooltip: {
                trigger: 'axis'
            },
            xAxis: {
                type: 'category',
                data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日']
            },
            yAxis: {
                type: 'value'
            },
            series: [{
                name: '用户量',
                data: [7, 3, 11, 15, 8, 18, 20],
                type: 'line',
                smooth: true
            }]
        };


        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);

        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main2'));

        // 指定图表的配置项和数据
        var option = {
            title: {
                text: '性别分布',
                subtext: '更新日期：<%=now %>',
                left: 'center'
            },
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b} : {c} ({d}%)'
            },
            legend: {
                orient: 'vertical',
                left: 'left',
                data: ['男', '女']
            },
            series: [
                {
                    name: '性别分布',
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '60%'],
                    data: [
                        {value: 135, name: '男'},
                        {value: 80, name: '女'}
                    ],
                    emphasis: {
                        itemStyle: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);


        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    </script>

</html>