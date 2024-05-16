<%@page import="sjwdao.FlightListDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="javax.naming.spi.DirStateFactory.Result"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*" %>
<%@page import="dao.DBHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String type = request.getParameter("type"); //왕복편도
String departureLocation = request.getParameter("departureLocation"); //출발지
String arrivalLocation = request.getParameter("arrivalLocation"); // 도착지 or 복귀공항
String departDate = request.getParameter("departDate");  //출발일
String comeBackDate = request.getParameter("comeBackDate"); // 돌아오는날

/* System.out.println(type+"왕복,편도");
System.out.println(departureLocation+"출발지");
System.out.println(arrivalLocation+"도착지");
System.out.println(departDate+"출발일");
System.out.println(comeBackDate+"복귀일 편도면 null임."); */ 

// 항공편 리스트 불러오는 메소드;
//ArrayList<HashMap<String,Object>> list = FlightListDAO.flightList(departureLocation, arrivalLocation, departDate);

%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="../css/css_flightList.css">
</head> 
<body>

<div>
	가는 편 <%=departureLocation%> -> <%=arrivalLocation %> 
</div>

<%-- 		<table border=1>
		<%for(HashMap<String,Object> e : list) {
		
		%>
		<tr>		
	<td><%=(String) (e.get("routeId"       ))%> </td>
	<td><%=(String) (e.get("departureCity" ))%> </td>
	<td><%=(String) (e.get("arrivalCity"   ))%> </td>
	<td><%=(String) (e.get("baseFare"      ))%> </td>
	<td><%=(String) (e.get("flightDuration"))%> </td>
	<td><%=(String) (e.get("flight_id"     ))%> </td>
	<td><%=(String) (e.get("planeId"       ))%> </td>
	<td><%=(String) (e.get("planeName"     ))%> </td>
	<td><%=(String) (e.get("airLine"       ))%> </td>
	<td><%=(String) (e.get("departureTime" ))%> </td>
	<td><%=(String) (e.get("arrivalTime"   ))%> </td>  		
		</tr>
		<%} %>
		</table>
 --%>
 	<div style="width: 1300px; margin-left:300px; ">	
	<ul style="list-style: none; width: 100%; height: 160px;">
		<li style="display: flex ;margin: 2rem 0 4rem; border: 10px; border-radius: 2rem;height: 160px;">
			<div class="flightBorder">
				<div class="flightContent">
					<span style="font-size: 24px;line-height: 1.5;">07:55</span>
					<div class="test">흠</div>
				</div>
			</div>
			
			<div style="display:flex; border: 1px solid #d9dbe1; border-bottom-right-radius:20px;border-top-right-radius:20px; width: 100%; margin-right: 100px;">
				<div style="width: 100%; border-right: 1px solid #d9dbe1;height: 100%">
					<div class="flightTopBorder">
					
					</div>
				</div>
				
				<div class="flightTopBorder">
				
				</div>
				
				<div class="flightRightBorder">
				
				</div>
			</div>
			
			
		</li>
	</ul>
	</div>
</body>
</html>