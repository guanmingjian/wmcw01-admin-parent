<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/main-head.jsp" %>
	<body>
		<div class="layui-fluid">
			<div class="layui-row layui-col-space15">

				
				<div class="layui-col-sm12 layui-col-md6">
					<div class="layui-card">
						<div class="layui-card-header">美食消费类型</div>
						<div class="layui-card-body" style="min-height: 280px;">
							<div id="main1" class="layui-col-sm12" style="height: 300px;"></div>

						</div>
					</div>
				</div>
				<div class="layui-col-sm12 layui-col-md6">
					<div class="layui-card">
						<div class="layui-card-header">酒店消费类型</div>
						<div class="layui-card-body" style="min-height: 280px;">
							<div id="main2" class="layui-col-sm12" style="height: 300px;"></div>

						</div>
					</div>
				</div>
				<div class="layui-col-sm12 layui-col-md6">
					<div class="layui-card">
						<div class="layui-card-header">美食消费类型</div>
						<div class="layui-card-body" style="min-height: 280px;">
							<div id="main3" class="layui-col-sm12" style="height: 300px;"></div>

						</div>
					</div>
				</div>
				<div class="layui-col-sm12 layui-col-md6">
					<div class="layui-card">
						<div class="layui-card-header">酒店消费类型</div>
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
					data: ["小吃", "火锅", "自助餐", "大排档", "快餐店"]
				},
				yAxis: {},
				series: [{
					name: '销量',
					type: 'bar',
					data: [1232, 1325, 1790, 732, 600]
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
					data: ["特惠酒店", "性价比酒店", "星级酒店", "高端酒店", "奢华酒店"]
				},
				yAxis: {},
				series: [{
					name: '销量',
					type: 'bar',
					data: [122, 3436, 6322, 246, 90]
				}]
			};

			// 使用刚指定的配置项和数据显示图表。
			myChart.setOption(option);
			
			// 基于准备好的dom，初始化echarts实例
			var myChart = echarts.init(document.getElementById('main3'));

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
					data: ["小吃", "火锅", "自助餐", "大排档", "快餐店"]
				},
				yAxis: {},
				series: [{
					name: '销量',
					type: 'bar',
					data: [1232, 1325, 1790, 732, 600]
				}]
			};

			// 使用刚指定的配置项和数据显示图表。
			myChart.setOption(option);
			
			// 基于准备好的dom，初始化echarts实例
			var myChart = echarts.init(document.getElementById('main4'));

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
					data: ["特惠酒店", "性价比酒店", "星级酒店", "高端酒店", "奢华酒店"]
				},
				yAxis: {},
				series: [{
					name: '销量',
					type: 'bar',
					data: [122, 3436, 6322, 246, 90]
				}]
			};

			// 使用刚指定的配置项和数据显示图表。
			myChart.setOption(option);
		</script>
	</body>
</html>
