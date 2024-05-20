<%@page import="javax.print.attribute.HashPrintRequestAttributeSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        
<%
	/* ---------------------------------------예약페이지~ */
	String seatId = request.getParameter("seatId1");
	String flightId1 = request.getParameter("flightId1");
	String seatNo1 = request.getParameter("seatNo1");
	String seatGrade1 = request.getParameter("seatGrade1");
	String seatPrice1 = request.getParameter("seatPrice1");
	String departureLocation = request.getParameter("departureLocation");
	String arrivalLocation = request.getParameter("arrivalLocation");
	System.out.println(seatId + " 좌석정보");
	System.out.println(flightId1 + "가는편정보");
	System.out.println(seatNo1);
	System.out.println(seatPrice1);
	System.out.println(departureLocation);
	System.out.println(arrivalLocation);
	
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <!-- 항공편정보 -->
	<div>
	가는편 <%=departureLocation%> ---> <%=arrivalLocation%>
	</div>
	<div>
	오는편 <%=arrivalLocation%> ---> <%=departureLocation%> 
	</div>
  <!-- 승객정보 입력창? -->
	<div style="border: solid black;">
		<div>
			<label for ="이름">이름 로그인 정보 불러와야함</label>
			<input type="text" id="이름">
			<label for ="핸드폰번호">핸드폰번호</label>
			<input type="tel" id="핸드폰번호">
		</div>
			<label for="국적">국적</label>
			<input type="text"id="국적">
			<label for="생일">생일</label>
			<input type="date">
		<div>
			<label for ="이메일">이메일</label>
			<input type="text">
			<label for ="마일리지">마일리지</label>
			<input id="마일리지" type="text" disabled="disabled">
		</div>	
	</div>
</body>
</html>