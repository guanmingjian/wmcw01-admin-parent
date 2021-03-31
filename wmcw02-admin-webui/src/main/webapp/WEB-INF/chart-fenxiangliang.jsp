<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	Date d = new Date();
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String now = df.format(d);
%>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/main-head.jsp" %>
	<body>
		<div class="layui-fluid">
			<div class="layui-row layui-col-space15">
				<div class="layui-col-sm12 layui-col-md6">
					<div class="layui-card">
						<div class="layui-card-header">一天分享量统计</div>
						<div class="layui-card-body" style="min-height: 280px;">
							<div id="main1" class="layui-col-sm12" style="height: 300px;"></div>
						</div>
					</div>
				</div>
				<div class="layui-col-sm12 layui-col-md6">
					<div class="layui-card">
						<div class="layui-card-header">分享量</div>
						<div class="layui-card-body" style="min-height: 280px;">
							<div id="main2" class="layui-col-sm12" style="height: 300px;"></div>
						</div>
					</div>
				</div>
				<div class="layui-col-sm12 layui-col-md6">
					<div class="layui-card">
						<div class="layui-card-header">最新一周分享量/独立分享量</div>
						<div class="layui-card-body" style="min-height: 300px;">
							<div id="main3" class="layui-col-sm12" style="height: 300px;"></div>
						</div>
					</div>
				</div>
				<div class="layui-col-sm12 layui-col-md6">
					<div class="layui-card">
						<div class="layui-card-header">智慧麻涌功能分析量条形图</div>
						<div class="layui-card-body" style="min-height: 300px;">
							<div id="main4" class="layui-col-sm12" style="height: 300px;"></div>
						</div>
					</div>
				</div>
			</div>
		</div>


		<script src="js/echarts1.js"></script>
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
					trigger: 'axis',
					axisPointer: {
						type: 'cross'
					}
				},
				toolbox: {
					show: true,
					feature: {
						saveAsImage: {}
					}
				},
				xAxis: {
					type: 'category',
					boundaryGap: false,
					data: ['00:00', '01:15', '02:30', '03:45', '05:00', '06:15', '07:30', '08:45', '10:00', '11:15', '12:30', '13:45',
						'15:00', '16:15', '17:30', '18:45', '20:00', '21:15', '22:30', '23:45'
					]
				},
				yAxis: {
					type: 'value',
					axisLabel: {
						formatter: '{value}'
					},
					axisPointer: {
						snap: true
					}
				},
				visualMap: {
					show: false,
					dimension: 0,
					pieces: [{
						lte: 6,
						color: 'green'
					}, {
						gt: 6,
						lte: 12,
						color: 'green'
					}, {
						gt: 12,
						lte: 14,
						color: 'red'
					}, {
						gt: 14,
						lte: 17,
						color: 'green'
					}, {
						gt: 17,
						color: 'green'
					}]
				},
				series: [{
					name: '访问量',
					type: 'line',
					smooth: true,
					data: [0, 0, 0, 3, 7, 2, 5, 5, 4, 9, 12, 5, 12, 25, 15, 18, 8, 7, 6, 4],
					markArea: {
						data: [
							[{
								name: '高峰期',
								xAxis: '15:00'
							}, {
								xAxis: '17:30'
							}]
						]
					}
				}]
			};
			// 使用刚指定的配置项和数据显示图表。
			myChart.setOption(option);

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
					data: ['全国公共(8.05%)', '麻涌美图(13.42%)', '本地美食(23.48%)', '精选酒店(21.47%)', '麻涌公共(33.55%)']
				},
				series: [{
					name: '访问次数',
					type: 'pie',
					radius: '55%',
					center: ['50%', '60%'],
					data: [{
						value: 12,
						name: '全国公共(8.05%)'
					},
						{
							value: 20,
							name: '麻涌美图(13.42%)'
						},
						{
							value: 35,
							name: '本地美食(23.48%)'
						},
						{
							value: 32,
							name: '精选酒店(21.47%)'
						},
						{
							value: 50,
							name: '麻涌公共(33.55%)'
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
			var myChart = echarts.init(document.getElementById('main3'));

			// 指定图表的配置项和数据
			var option = {
				tooltip: {
					trigger: 'axis',
					axisPointer: {
						type: 'cross',
						label: {
							backgroundColor: '#6a7985'
						}
					}
				},
				grid: {
					top: '5%',
					right: '2%',
					left: '1%',
					bottom: '10%',
					containLabel: true
				},
				xAxis: [{
					type: 'category',
					boundaryGap: false,
					data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日']
				}],
				yAxis: [{
					type: 'value'
				}],
				series: [{
						name: '访问量',
						type: 'line',
						areaStyle: {
							normal: {}
						},
						data: [82, 93, 90, 93, 129, 133, 132],
						smooth: true
					},
					{
						name: '独立访客',
						type: 'line',
						areaStyle: {
							normal: {}
						},
						data: [52, 112, 123, 152, 175, 196, 170],
						smooth: true,

					}
				]
			};
			// 使用刚指定的配置项和数据显示图表。
			myChart.setOption(option);

			// 基于准备好的dom，初始化echarts实例
			var myChart = echarts.init(document.getElementById('main4'));

			// 指定图表的配置项和数据
			var option = {
				title: {
					subtext: '更新日期：<%=now %>',
					left: 'center'
				},
				dataset: {
					source: [
						['score', 'amount', 'product'],
						[69.3, 3121, '导航类'],
						[87.1, 4042, '公共服务类'],
						[44.4, 1120, '酒店类'],
						[70.1, 550, '出行类'],
						[49.7, 1451, '美食类'],
						[68.1, 5962, '文章类'],
						[32.7, 825, '美图类']
					]
				},
				grid: {containLabel: true},
				xAxis: {name: '%'},
				yAxis: {type: 'category'},
				visualMap: {
					orient: 'horizontal',
					left: 'center',
					min: 10,
					max: 100,
					text: ['访问量'],
					// Map the score column to color
					dimension: 0,
					inRange: {
						color: ['#D7DA8B', '#E15457']
					}
				},
				series: [
					{
						type: 'bar',
						encode: {
							// Map the "amount" column to X axis.
							x: '访问量%',
							// Map the "product" column to Y axis
							y: 'product'
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
