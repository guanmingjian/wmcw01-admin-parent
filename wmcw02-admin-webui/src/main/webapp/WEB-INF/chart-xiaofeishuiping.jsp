<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/main-head.jsp" %>
	<body>
		<div class="layui-fluid">
			<div class="layui-row layui-col-space15">

				
				<div class="layui-col-sm12 layui-col-md6">
					<div class="layui-card">
						<div class="layui-card-header">美食消费水平</div>
						<div class="layui-card-body" style="min-height: 280px;">
							<div id="main1" class="layui-col-sm12" style="height: 300px;"></div>

						</div>
					</div>
				</div>
				<div class="layui-col-sm12 layui-col-md6">
					<div class="layui-card">
						<div class="layui-card-header">酒店消费水平</div>
						<div class="layui-card-body" style="min-height: 280px;">
							<div id="main2" class="layui-col-sm12" style="height: 300px;"></div>

						</div>
					</div>
				</div>
				<div class="layui-col-sm12 layui-col-md6">
					<div class="layui-card">
						<div class="layui-card-header">美食消费水平</div>
						<div class="layui-card-body" style="min-height: 280px;">
							<div id="main3" class="layui-col-sm12" style="height: 300px;"></div>

						</div>
					</div>
				</div>
				<div class="layui-col-sm12 layui-col-md6">
					<div class="layui-card">
						<div class="layui-card-header">酒店消费水平</div>
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
					data: ['销量']
				},
				xAxis: {
					data: ["古梅甜品店", "Cat Cafe", "正新鸡排", "Vigo维果茶", "小田豆浆店"]
				},
				yAxis: {},
				series: [{
					name: '销量',
					type: 'bar',
					data: [5, 20, 36, 10, 20]
				}]
			};

			// 使用刚指定的配置项和数据显示图表。
			myChart.setOption(option);
			
			// 基于准备好的dom，初始化echarts实例
			var myChart = echarts.init(document.getElementById('main2'));

			// 指定图表的配置项和数据
			var option = {
				title: {
					text: '排行榜'
				},
				tooltip: {},
				legend: {
					data: ['销量']
				},
				xAxis: {
					data: ["金穗湾酒店", "西园酒店", "萌爸客", "白房子民宿", "港湾酒店"]
				},
				yAxis: {},
				series: [{
					name: '销量',
					type: 'bar',
					data: [335, 1048, 110, 234, 135]
				}]
			};

			// 使用刚指定的配置项和数据显示图表。
			myChart.setOption(option);
			
			// 基于准备好的dom，初始化echarts实例
			var myChart = echarts.init(document.getElementById('main3'));

			// 指定图表的配置项和数据
			var option = {
					title: {
						text: '消费区间数量'
					},
					xAxis: {
						type: 'category',
						data: ['1~5元', '6~20元', '20~35元', '35~50元', '50~100元']
					},
					yAxis: {
						type: 'value'
					},
					series: [{
						data: [70, 40, 36, 30, 50],
						type: 'line'
					}]
				};


			// 使用刚指定的配置项和数据显示图表。
			myChart.setOption(option);
			
			// 基于准备好的dom，初始化echarts实例
			var myChart = echarts.init(document.getElementById('main4'));

			// 指定图表的配置项和数据
			var option = {
					title: {
						text: '消费区间数量'
					},
					xAxis: {
						type: 'category',
						data: ['80~100元', '100~120元', '120~150元', '150~180元', '180~220元']
					},
					yAxis: {
						type: 'value'
					},
					series: [{
						data: [75, 98, 82, 78, 65],
						type: 'line'
					}]
				};

			// 使用刚指定的配置项和数据显示图表。
			myChart.setOption(option);
		</script>
	</body>
</html>
