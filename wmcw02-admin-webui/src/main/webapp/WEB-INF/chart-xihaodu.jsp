<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
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

                <div class="layui-col-sm12 layui-col-md6">
                    <div class="layui-card">
                        <div class="layui-card-header">人群性别分析</div>
                        <div class="layui-card-body" style="min-height: 280px;">
                            <div id="main1" class="layui-col-sm12" style="height: 300px;"></div>
                        </div>
                    </div>
                </div>

                <div class="layui-col-sm12 layui-col-md6">
                    <div class="layui-card">
                        <div class="layui-card-header">功能使用分析</div>
                        <div class="layui-card-body" style="min-height: 280px;">
                            <div id="main2" class="layui-col-sm12" style="height: 300px;"></div>
                        </div>
                    </div>
                </div>

                <div class="layui-col-sm12 layui-col-md6">
                    <div class="layui-card">
                        <div class="layui-card-header">功能访问量分析</div>
                        <div class="layui-card-body" style="min-height: 300px;">
                            <div id="main3" class="layui-col-sm12" style="height: 300px;"></div>
                        </div>
                    </div>
                </div>

                <div class="layui-col-sm12 layui-col-md6">
                    <div class="layui-card">
                        <div class="layui-card-header">出行方式分析</div>
                        <div class="layui-card-body" style="min-height: 300px;">
                            <div id="main4" class="layui-col-sm12" style="height: 300px;"></div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        </div>
    
        <script src="https://cdn.bootcss.com/echarts/4.2.1-rc1/echarts.min.js"></script>
        <script type="text/javascript">
        $(function () {
            // 获取 CSRF Token
            window.csrfToken = $("meta[name='_csrf']").attr("content");
            window.csrfHeader = $("meta[name='_csrf_header']").attr("content");
            // 基于准备好的dom，初始化echarts实例
            var myChart1 = echarts.init(document.getElementById('main1'));
            $.ajax({
                "url": "admin/get/user_age.json",
                "type": "post",
                "beforeSend": function (request) {
                    request.setRequestHeader(csrfHeader, csrfToken);     // 添加 CSRF Token
                },
                "data": {},
                "contentType": "application/json;charset=UTF-8",
                "async": false,
                "dataType": "json",
                "success": function (response) {
                    var servicedata = [];
                    console.log(response.data);
                    for (var i = 0; i < response.data.usernum.length; i++) {
                        var obj = new Object();
                        obj.value = response.data.usernum[i];
                        obj.name = response.data.age[i];

                        servicedata[i] = obj;
                    }
                    console.log(servicedata);
                    // 使用刚指定的配置项和数据显示图表。
                    var option = {
                        title: {
                            text: '年龄比例',
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
                            data: response.data.age
                        },
                        series: [
                            {
                                name: '人数',
                                type: 'pie',
                                radius: '55%',
                                center: ['50%', '60%'],
                                data: servicedata,
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
                    myChart1.setOption(option);

                }
            });
            // 基于准备好的dom，初始化echarts实例
            var myChart3 = echarts.init(document.getElementById('main3'));
            $.ajax({
                "url": "view/get/OneVisits.json",
                "type": "post",
                "beforeSend": function (request) {
                    request.setRequestHeader(csrfHeader, csrfToken);     // 添加 CSRF Token
                },
                "data": {},
                "contentType": "application/json;charset=UTF-8",
                "async": false,
                "dataType": "json",
                "success": function (response) {
                    console.log(response.data.name);
                    console.log(response.data.value);
                    // 指定图表的配置项和数据
                    var option = {
                        title: {
                            text: '一天访问量'
                        },
                        tooltip: {},
                        legend: {
                            data: ['访问量']
                        },
                        xAxis: {
                            data: response.data.name
                        },
                        yAxis: {},
                        series: [{
                            name: '访问量',
                            type: 'bar',
                            data: response.data.value
                        }]
                    };
                    // 使用刚指定的配置项和数据显示图表。
                    myChart3.setOption(option);
                }
            });
        });


        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main2'));

        // 指定图表的配置项和数据
        var option = {
            title: {
                subtext: '更新日期：<%=now %>',
                left: 'center'
            },
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                left: 'left',
                data: ['全国公共(12.71%)', '麻涌公共(51.6%)', '麻涌美图(10.36%)', '本地美食(12.62%)', '精选酒店(12.71%)']
            },
            series: [{
                name: '访问次数',
                type: 'pie',
                radius: '55%',
                center: ['50%', '60%'],
                data: [{
                    value: 135,
                    name: '全国公共(12.71%)'
                },
                    {
                        value: 110,
                        name: '麻涌美图(10.36%)'
                    },
                    {
                        value: 134,
                        name: '本地美食(12.62%)'
                    },
                    {
                        value: 135,
                        name: '精选酒店(12.71%)'
                    },
                    {
                        value: 548,
                        name: '麻涌公共(51.6%)'
                    }
                ],
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);


        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main4'));

        // 指定图表的配置项和数据
        var option = {
            title: {
                subtext: '更新日期：<%=now %>',
                left: 'left'
            },
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b} : {c} ({d}%)'
            },
            legend: {
                // orient: 'vertical',
                // top: 'middle',
                bottom: 10,
                left: 'center',
                data: ['公交', '驾车', '步行']
            },
            series: [
                {
                    type: 'pie',
                    radius: '65%',
                    center: ['50%', '50%'],
                    selectedMode: 'single',
                    data: [
                        {value: 35, name: '公交(8.66%)'},
                        {value: 134, name: '驾车(33.17%)'},
                        {value: 235, name: '步行(58.17%)'}
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
        


    </script>
    <script>
        var _hmt = _hmt || [];
        (function() {
          var hm = document.createElement("script");
          hm.src = "https://hm.baidu.com/hm.js?b393d153aeb26b46e9431fabaf0f6190";
          var s = document.getElementsByTagName("script")[0]; 
          s.parentNode.insertBefore(hm, s);
        })();
        </script>
    </body>
</html>