<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html class="x-admin-sm">
<%@include file="/WEB-INF/main-head.jsp" %>
<style type="text/css">
	.toolbar {
		border: 1px solid #ccc;
	}
	.text {
		border: 1px solid #ccc;
		height: 470px;
	}
</style>
<style type="text/css">
	#div01{
		position: relative;
		z-index: 2;
	}
	#div02{
		position: relative;
		z-index: 1;
	}
</style>

<body>
<div class="layui-row layui-col-space15" id="div01">
	<div class="layui-col-md12">
		<div class="layui-card">
			<div class="layui-card-body ">
				<form class="layui-form layui-col-space5" action="admin/do/article/add.html" method="post">
					<input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}"/>
					<div class="layui-input-inline layui-show-xs-block">
						<input type="text" name="title" placeholder="请输入标题" autocomplete="off" class="layui-input">
					</div>
					<div class="layui-input-inline layui-show-xs-block">
						<input type="text" name="authorName" placeholder="请输入作者" autocomplete="off" class="layui-input">
					</div>
					<div class="layui-input-inline layui-show-xs-block">
						<select name="clas">
							<option value="0">文章分类</option>
							<option value="1">美食文章</option>
							<option value="2">酒店文章</option>
							<option value="3">人文文章</option>
							<option value="4">新闻文章</option>
							<option value="5">娱乐文章</option>
						</select>
					</div><div class="layui-input-inline layui-show-xs-block">
					<select name="keyword">
						<option value="0">适看人群</option>
						<option value="1">少年（1-16岁）</option>
						<option value="2">青年（17-30，男）</option>
						<option value="3">邻家女孩（17-30，女）</option>
						<option value="4">中年（30-60）</option>
						<option value="5">老年（70-100）</option>
					</select>
				</div>
					<div class="layui-inline">
						<input class="layui-input" id="test1" type="text" name="timPublish" placeholder="定时发布">
					</div>
					<input id="" type="submit" class="layui-btn" value="确认发布">

					<!-- 文本编辑器 -->
					<div class=layui-card" id="div02">
						<div class="layui-fluid">
							<div id="div1" class="toolbar">
							</div>
							<div style="padding: 2px 0; color: #ccc">
							</div>
							<div id="div2" class="text"> <!--可使用 min-height 实现编辑区域自动增加高度-->
								<p></p>
							</div>
							<textarea name="textContent" id="text1" style="width:100%;height:1px;visibility:hidden;"></textarea>

							<script type="text/javascript" src="js/admin/wangEditor.js" charset="UTF-8"></script>
							<script type="text/javascript">

								var E = window.wangEditor;
								var editor1 = new E('#div1', '#div2');  // 两个参数也可以传入 elem 对象，class 选择器
								var $text1 = $('#text1');

								//开启debug模式
								editor1.customConfig.debug = true;
								//设置可粘贴图片，false是禁止忽略图片
								editor1.customConfig.pasteIgnoreImg = true;

								// 获取 CSRF Token
								var csrfToken = $("meta[name='_csrf']").attr("content");

								//配置CSRF
								editor1.customConfig.uploadImgHeaders={
									'X-CSRF-TOKEN': csrfToken
								};
								//设置文件上传的参数名称
								editor1.customConfig.uploadFileName = 'myFile';
								// 配置服务器端地址，上传图片到服务器
								editor1.customConfig.uploadImgServer = 'admin/do/article/upload.json';
								// 将图片大小限制为 3M
								editor1.customConfig.uploadImgMaxSize = 5 * 1024 * 1024;
								// 限制一次最多上传10 张图片
								editor1.customConfig.uploadImgMaxLength = 10;
								//自定义上传图片事件
								editor1.customConfig.uploadImgHooks = {
									before : function(xhr, editor, files) {
									},
									success : function(xhr, editor, result) {
										console.log("上传成功");
									},
									error : function(xhr, editor) {
										console.log("上传出错");
									},
									timeout : function(xhr, editor) {
										console.log("上传超时");
									}
								},
								// 监控变化，同步更新到 textarea
								editor1.customConfig.onchange = function (html) {
									$text1.val(html);
								},
								//生成富文本编辑器
								editor1.create();
							</script>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
</body>
<script>layui.use(['laydate', 'form'],
		function() {
			var laydate = layui.laydate;

			//常规用法
			laydate.render({
				elem: '#test1'
			});
		});
</script>
</html>