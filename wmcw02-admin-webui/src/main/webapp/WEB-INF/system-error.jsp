<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<meta charset="UTF-8">
	<base href="http://${pageContext.request.serverName }:${pageContext.request.serverPort }${pageContext.request.contextPath }/" />
</head>
	<body>
			<h2 style="text-align: center;">
				智慧麻涌系统消息
			</h2>
			<br>
			<h3 style="text-align: center;">
				${requestScope.exception.message }
			</h3>
	</body>
</html>