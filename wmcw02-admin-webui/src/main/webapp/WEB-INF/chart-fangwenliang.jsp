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
						<div class="layui-card-body" style="min-height: 280px;">
							<div id="main1" class="layui-col-sm12" style="height: 300px;"></div>

						</div>
					</div>
				</div>
				<div class="layui-col-sm12 layui-col-md6">
					<div class="layui-card">
						<div class="layui-card-body" style="min-height: 280px;">
							<div id="main2" class="layui-col-sm12" style="height: 300px;"></div>

						</div>
					</div>
				</div>
				<div class="layui-col-sm12 layui-col-md6">
					<div class="layui-card">
						<div class="layui-card-body" style="min-height: 300px;">
							<div id="main3" class="layui-col-sm12" style="height: 300px;"></div>

						</div>
					</div>
				</div>
				<div class="layui-col-sm12 layui-col-md6">
					<div class="layui-card">
						<div class="layui-card-body" style="min-height: 300px;">
							<div id="main4" class="layui-col-sm12" style="height: 300px;"></div>
						</div>
					</div>
				</div>
			</div>
		</div>


		<script src="js/echarts1.js"></script>
		<script type="text/javascript">

			$(function () {
				// 获取 CSRF Token
				window.csrfToken = $("meta[name='_csrf']").attr("content");
				window.csrfHeader = $("meta[name='_csrf_header']").attr("content");
				// 基于准备好的dom，初始化echarts实例
				var myChart1 = echarts.init(document.getElementById('main1'));
				$.ajax({
					"url": "view/get/SevenIndex.json",
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
								text: '首页访问量'
							},
							xAxis: {
								type: 'category',
								data: response.data.name
							},
							yAxis: {
								type: 'value'
							},
							series: [{
								data: response.data.value,
								type: 'line'
							}]
						};
						// 使用刚指定的配置项和数据显示图表。
						myChart1.setOption(option);
					}
				});
				// 基于准备好的dom，初始化echarts实例
				var myChart2 = echarts.init(document.getElementById('main2'));
				$.ajax({
					"url": "view/get/SevenHotel.json",
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
								text: '酒店访问量'
							},
							xAxis: {
								type: 'category',
								data: response.data.name
							},
							yAxis: {
								type: 'value'
							},
							series: [{
								data: response.data.value,
								type: 'line'
							}]
						};
						// 使用刚指定的配置项和数据显示图表。
						myChart2.setOption(option);
					}
				});

				// 基于准备好的dom，初始化echarts实例
				var myChart3 = echarts.init(document.getElementById('main3'));
				$.ajax({
					"url": "view/get/SevenCate.json",
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
								text: '美食访问量'
							},
							xAxis: {
								type: 'category',
								data: response.data.name
							},
							yAxis: {
								type: 'value'
							},
							series: [{
								data: response.data.value,
								type: 'line'
							}]
						};
						// 使用刚指定的配置项和数据显示图表。
						myChart3.setOption(option);
					}
				});

				// 基于准备好的dom，初始化echarts实例
				var myChart4 = echarts.init(document.getElementById('main4'));
				$.ajax({
					"url": "view/get/SevenMap.json",
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
								text: '地图访问量'
							},
							xAxis: {
								type: 'category',
								data: response.data.name
							},
							yAxis: {
								type: 'value'
							},
							series: [{
								data: response.data.value,
								type: 'line'
							}]
						};
						// 使用刚指定的配置项和数据显示图表。
						myChart4.setOption(option);
					}
				});


			});

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
