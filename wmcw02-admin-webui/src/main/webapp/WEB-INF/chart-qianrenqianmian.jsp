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
                        <div class="layui-card-header">酒店推荐比例饼状图</div>
                        <div class="layui-card-body" style="min-height: 280px;">
                            <div id="main1" class="layui-col-sm12" style="height: 300px;"></div>
                        </div>
                    </div>
                </div>
                
                <div class="layui-col-sm12 layui-col-md6">
                    <div class="layui-card">
                        <div class="layui-card-header">文章推荐位点击量分析</div>
                        <div class="layui-card-body" style="min-height: 280px;">
                            <div id="main2" class="layui-col-sm12" style="height: 300px;"></div>
                        </div>
                    </div>
                </div>
                
                <div class="layui-col-sm12 layui-col-md6">
                    <div class="layui-card">
                        <div class="layui-card-header">推荐时段折线图</div>
                        <div class="layui-card-body" style="min-height: 300px;">
                            <div id="main3" class="layui-col-sm12" style="height: 300px;"></div>
                        </div>
                    </div>
                </div>
                
                <div class="layui-col-sm12 layui-col-md6">
                    <div class="layui-card">
                        <div class="layui-card-header">点击时段卫星图</div>
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
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main1'));

        // 指定图表的配置项和数据
        var option = {
                title: {
                    subtext: '更新日期：<%=now %>',
                    left: 'center'
                },
                tooltip: {
                    trigger: 'item',
                    formatter: '{a} <br/>{b}: {c} ({d}%)'
                },
                legend: {
                    orient: 'vertical',
                    left: 10,
                    data: ['金穗湾酒店', '萌爸客', '白房子民宿', '港湾酒店', '西园酒店']
                },
                series: [
                    {
                        name: '访问来源',
                        type: 'pie',
                        radius: ['50%', '70%'],
                        avoidLabelOverlap: false,
                        label: {
                            normal: {
                                show: false,
                                position: 'center'
                            },
                            emphasis: {
                                show: true,
                                textStyle: {
                                    fontSize: '30',
                                    fontWeight: 'bold'
                                }
                            }
                        },
                        labelLine: {
                            normal: {
                                show: false
                            }
                        },
                        data: [
                            {value: 335, name: '金穗湾酒店'},
                            {value: 310, name: '萌爸客'},
                            {value: 234, name: '白房子民宿'},
                            {value: 135, name: '港湾酒店'},
                            {value: 1548, name: '西园酒店'}
                        ]
                    }
                ]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
        
     	// 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main2'));

        // 指定图表的配置项和数据
        var option = {
            legend: {},
            tooltip: {
                trigger: 'axis',
                showContent: false
            },
            dataset: {
                source: [
                    ['product', '01-10', '01-11', '01-12', '01-13', '01-14', '01-15'],
                    ['智能导读点击量', 41, 30, 65, 53, 83, 98],
                    ['热点排行点击量', 86, 92, 85, 83, 73, 55],
                    ['作者主页访问量', 24, 67, 79, 86, 65, 82],
                    ['搜索使用次数', 55, 67, 69, 72, 53, 39]
                ]
            },
            xAxis: {type: 'category'},
            yAxis: {gridIndex: 0},
            grid: {top: '55%'},
            series: [
                {type: 'line', smooth: true, seriesLayoutBy: 'row'},
                {type: 'line', smooth: true, seriesLayoutBy: 'row'},
                {type: 'line', smooth: true, seriesLayoutBy: 'row'},
                {type: 'line', smooth: true, seriesLayoutBy: 'row'},
                {
                    type: 'pie',
                    id: 'pie',
                    radius: '30%',
                    center: ['50%', '25%'],
                    label: {
                        formatter: '{b}: {@01-10} ({d}%)'
                    },
                    encode: {
                        itemName: 'product',
                        value: '01-10',
                        tooltip: '01-15'
                    }
                }
            ]
        };

        myChart.on('updateAxisPointer', function (event) {
            var xAxisInfo = event.axesInfo[0];
            if (xAxisInfo) {
                var dimension = xAxisInfo.value + 1;
                myChart.setOption({
                    series: {
                        id: 'pie',
                        label: {
                            formatter: '{b}: {@[' + dimension + ']} ({d}%)'
                        },
                        encode: {
                            value: dimension,
                            tooltip: dimension
                        }
                    }
                });
            }
        });

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
        
     	// 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main3'));

        // 指定图表的配置项和数据
        var option = {
            title: {
                subtext: '更新日期：<%=now %>',
                left: 'center'
            },
            xAxis: {
                type: 'category',
                boundaryGap: false
            },
            yAxis: {
                type: 'value',
                boundaryGap: [0, '30%']
            },
            visualMap: {
                type: 'piecewise',
                show: false,
                dimension: 0,
                seriesIndex: 0,
                pieces: [{
                    gt: 1,
                    lt: 3,
                    color: 'rgba(0, 180, 0, 0.5)'
                }, {
                    gt: 5,
                    lt: 7,
                    color: 'rgba(0, 180, 0, 0.5)'
                }]
            },
            series: [
                {
                    type: 'line',
                    smooth: 0.6,
                    symbol: 'none',
                    lineStyle: {
                        color: 'green',
                        width: 5
                    },
                    markLine: {
                        symbol: ['none', 'none'],
                        label: {show: false},
                        data: [
                            {xAxis: 1},
                            {xAxis: 3},
                            {xAxis: 5},
                            {xAxis: 7}
                        ]
                    },
                    areaStyle: {},
                    data: [
                        ['8:00', 20],
                        ['10:00', 40],
                        ['12:00', 65],
                        ['14:00', 50],
                        ['16:00', 20],
                        ['18:00', 30],
                        ['20:00', 45],
                        ['22:00', 30],
                        ['24:00', 10]
                    ]
                }
            ]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
        
     	// 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main4'));

        var hours = ['12a', '1a', '2a', '3a', '4a', '5a', '6a',
            '7a', '8a', '9a','10a','11a',
            '12p', '1p', '2p', '3p', '4p', '5p',
            '6p', '7p', '8p', '9p', '10p', '11p'];
        var days = ['Saturday', 'Friday', 'Thursday',
            'Wednesday', 'Tuesday', 'Monday', 'Sunday'];

        var data = [[0,0,5],[0,1,1],[0,2,0],[0,3,0],[0,4,0],[0,5,0],[0,6,0],[0,7,0],[0,8,0],[0,9,0],[0,10,0],[0,11,2],[0,12,4],[0,13,1],[0,14,1],[0,15,3],[0,16,4],[0,17,6],[0,18,4],[0,19,4],[0,20,3],[0,21,3],[0,22,2],[0,23,5],[1,0,7],[1,1,0],[1,2,0],[1,3,0],[1,4,0],[1,5,0],[1,6,0],[1,7,0],[1,8,0],[1,9,0],[1,10,5],[1,11,2],[1,12,2],[1,13,6],[1,14,9],[1,15,11],[1,16,6],[1,17,7],[1,18,8],[1,19,12],[1,20,5],[1,21,5],[1,22,7],[1,23,2],[2,0,1],[2,1,1],[2,2,0],[2,3,0],[2,4,0],[2,5,0],[2,6,0],[2,7,0],[2,8,0],[2,9,0],[2,10,3],[2,11,2],[2,12,1],[2,13,9],[2,14,8],[2,15,10],[2,16,6],[2,17,5],[2,18,5],[2,19,5],[2,20,7],[2,21,4],[2,22,2],[2,23,4],[3,0,7],[3,1,3],[3,2,0],[3,3,0],[3,4,0],[3,5,0],[3,6,0],[3,7,0],[3,8,1],[3,9,0],[3,10,5],[3,11,4],[3,12,7],[3,13,14],[3,14,13],[3,15,12],[3,16,9],[3,17,5],[3,18,5],[3,19,10],[3,20,6],[3,21,4],[3,22,4],[3,23,1],[4,0,1],[4,1,3],[4,2,0],[4,3,0],[4,4,0],[4,5,1],[4,6,0],[4,7,0],[4,8,0],[4,9,2],[4,10,4],[4,11,4],[4,12,2],[4,13,4],[4,14,4],[4,15,14],[4,16,12],[4,17,1],[4,18,8],[4,19,5],[4,20,3],[4,21,7],[4,22,3],[4,23,0],[5,0,2],[5,1,1],[5,2,0],[5,3,3],[5,4,0],[5,5,0],[5,6,0],[5,7,0],[5,8,2],[5,9,0],[5,10,4],[5,11,1],[5,12,5],[5,13,10],[5,14,5],[5,15,7],[5,16,11],[5,17,6],[5,18,0],[5,19,5],[5,20,3],[5,21,4],[5,22,2],[5,23,0],[6,0,1],[6,1,0],[6,2,0],[6,3,0],[6,4,0],[6,5,0],[6,6,0],[6,7,0],[6,8,0],[6,9,0],[6,10,1],[6,11,0],[6,12,2],[6,13,1],[6,14,3],[6,15,4],[6,16,0],[6,17,0],[6,18,0],[6,19,0],[6,20,1],[6,21,2],[6,22,2],[6,23,6]];
        option = {
            title: {
                subtext: '更新日期：<%=now %>',
                left: 'left'
            },
            legend: {
                data: ['评论条数'],
                left: 'right'
            },
            polar: {},
            tooltip: {
                formatter: function (params) {
                    return params.value[2] + ' comments in ' + hours[params.value[1]] + ' of ' + days[params.value[0]];
                }
            },
            angleAxis: {
                type: 'category',
                data: hours,
                boundaryGap: false,
                splitLine: {
                    show: true,
                    lineStyle: {
                        color: '#999',
                        type: 'dashed'
                    }
                },
                axisLine: {
                    show: false
                }
            },
            radiusAxis: {
                type: 'category',
                data: days,
                axisLine: {
                    show: false
                },
                axisLabel: {
                    rotate: 45
                }
            },
            series: [{
                name: '评论条数',
                type: 'scatter',
                coordinateSystem: 'polar',
                symbolSize: function (val) {
                    return val[2] * 2;
                },
                data: data,
                animationDelay: function (idx) {
                    return idx * 5;
                }
            }]
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