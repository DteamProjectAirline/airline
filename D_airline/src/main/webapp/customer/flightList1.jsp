<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String type = request.getParameter("type"); //왕복편도
String departureLocation = request.getParameter("departureLocation"); //출발지
String arrivalLocation = request.getParameter("arrivalLocation"); // 도착지 or 복귀공항
String departDate = request.getParameter("departDate");  //출발일
String comeBackDate = request.getParameter("comeBackDate"); // 돌아오는날

System.out.println(type+"왕복,편도");
System.out.println(departureLocation+"출발지");
System.out.println(arrivalLocation+"도착지");
System.out.println(departDate+"출발일");
System.out.println(comeBackDate+"복귀일 편도면 null임.");


%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
	<div>
	</div>
	<div>
	</div>
</div>
</body>
</html>