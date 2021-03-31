<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/main-head.jsp" %>
	<body>
		<div class="layui-fluid">
			<div class="layui-row layui-col-space15">

				<div class="layui-col-sm12 layui-col-md6">
					<div class="layui-card">
						<div class="layui-card-header">功能使用排行</div>
						<div class="layui-card-body" style="min-height: 280px;">
							<div id="main1" class="layui-col-sm12" style="height: 300px;"></div>

						</div>
					</div>
				</div>
				
				<div class="layui-col-sm12 layui-col-md6">
					<div class="layui-card">
						<div class="layui-card-header">功能使用饼状图</div>
						<div class="layui-card-body" style="min-height: 280px;">
							<div id="main2" class="layui-col-sm12" style="height: 300px;"></div>

						</div>
					</div>
				</div>
				
				<div class="layui-col-sm12 layui-col-md6">
					<div class="layui-card">
						<div class="layui-card-header">地图功能使用排行</div>
						<div class="layui-card-body" style="min-height: 280px;">
							<div id="main3" class="layui-col-sm12" style="height: 300px;"></div>

						</div>
					</div>
				</div>
				
				<div class="layui-col-sm12 layui-col-md6">
					<div class="layui-card">
						<div class="layui-card-header">地图功能使用饼状图</div>
						<div class="layui-card-body" style="min-height: 280px;">
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
					text: '排行榜'
				},
				tooltip: {},
				legend: {
					data: ['点击量']
				},
				xAxis: {
					data: ["麻涌公共", "全景华阳湖", "全景麻涌", "麻涌美图", "美食酒店"]
				},
				yAxis: {},
				series: [{
					name: '点击量',
					type: 'bar',
					data: [1250, 540, 736, 410, 820]
				}]
			};

			// 使用刚指定的配置项和数据显示图表。
			myChart.setOption(option);
			
			// 基于准备好的dom，初始化echarts实例
			var myChart = echarts.init(document.getElementById('main3'));

			// 指定图表的配置项和数据
			var option = {
					color: ['#3398DB'],
					tooltip: {
						trigger: 'axis',
						axisPointer: {            // 坐标轴指示器，坐标轴触发有效
							type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
						}
					},
					grid: {
						left: '3%',
						right: '4%',
						bottom: '3%',
						containLabel: true
					},
					xAxis: [
						{
							type: 'category',
							data: ['全景麻涌', '全景华阳湖', '全景中大新华', '麻涌公共', '全国公共'],
							axisTick: {
								alignWithLabel: true
							}
						}
					],
					yAxis: [
						{
							type: 'value'
						}
					],
					series: [
						{
							name: '使用次数',
							type: 'bar',
							barWidth: '60%',
							data: [70, 52, 45, 120, 65]
						}
					]
				};


			// 使用刚指定的配置项和数据显示图表。
			myChart.setOption(option);
		</script>

		<script type="text/javascript">
			// 基于准备好的dom，初始化echarts实例
			var myChart = echarts.init(document.getElementById('main2'));

			// 指定图表的配置项和数据
			var option = {
				backgroundColor: '#2c343c',

				title: {
					text: '点击量',
					left: 'center',
					top: 20,
					textStyle: {
						color: '#ccc'
					}
				},

				tooltip: {
					trigger: 'item',
					formatter: '{a} <br/>{b} : {c} ({d}%)'
				},

				visualMap: {
					show: false,
					min: 80,
					max: 1600,
					inRange: {
						colorLightness: [0, 1]
					}
				},
				series: [{
					name: '人客量',
					type: 'pie',
					radius: '55%',
					center: ['50%', '50%'],
					data: [{
							value: 1050,
							name: '麻涌公共'
						},
						{
							value: 540,
							name: '全景华阳湖'
						},
						{
							value: 736,
							name: '全景麻涌'
						},
						{
							value: 410,
							name: '麻涌美图'
						},
						{
							value: 820,
							name: '美食酒店'
						}
					].sort(function(a, b) {
						return a.value - b.value;
					}),
					roseType: 'radius',
					label: {
						color: 'rgba(255, 255, 255, 0.3)'
					},
					labelLine: {
						lineStyle: {
							color: 'rgba(255, 255, 255, 0.3)'
						},
						smooth: 0.2,
						length: 10,
						length2: 20
					},
					itemStyle: {
						color: '#c23531',
						shadowBlur: 200,
						shadowColor: 'rgba(0, 0, 0, 0.5)'
					},

					animationType: 'scale',
					animationEasing: 'elasticOut',
					animationDelay: function(idx) {
						return Math.random() * 200;
					}
				}]
			};
			// 使用刚指定的配置项和数据显示图表。
			myChart.setOption(option);
			
			// 基于准备好的dom，初始化echarts实例
			var myChart = echarts.init(document.getElementById('main4'));

			// 指定图表的配置项和数据
			var option = {
			backgroundColor: '#2c343c',

			title: {
				text: '使用次数',
				left: 'center',
				top: 20,
				textStyle: {
					color: '#ccc'
				}
			},

			tooltip: {
				trigger: 'item',
				formatter: '{a} <br/>{b} : {c} ({d}%)'
			},

			visualMap: {
				show: false,
				min: 20,
				max: 180,
				inRange: {
					colorLightness: [0, 1]
				}
			},
			series: [
				{
					name: '使用次数',
					type: 'pie',
					radius: '55%',
					center: ['50%', '50%'],
					data: [
						{value: 70, name: '全景麻涌'},
						{value: 52, name: '全景华阳湖'},
						{value: 45, name: '全景中大新华'},
						{value: 65, name: '全国公共'},
						{value: 120, name: '麻涌公共'}
					].sort(function (a, b) { return a.value - b.value; }),
					roseType: 'radius',
					label: {
						color: 'rgba(255, 255, 255, 0.3)'
					},
					labelLine: {
						lineStyle: {
							color: 'rgba(255, 255, 255, 0.3)'
						},
						smooth: 0.2,
						length: 10,
						length2: 20
					},
					itemStyle: {
						color: '#c23531',
						shadowBlur: 200,
						shadowColor: 'rgba(0, 0, 0, 0.5)'
					},

					animationType: 'scale',
					animationEasing: 'elasticOut',
					animationDelay: function (idx) {
						return Math.random() * 200;
					}
				}
			]
		};
			// 使用刚指定的配置项和数据显示图表。
			myChart.setOption(option);
		</script>
	</body>
</html>
