<%@page import="java.util.*"%>
<%@page import="sjwdao.*"%>
<%@page import="javax.print.attribute.HashPrintRequestAttributeSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        
<%
	/* ---------------------------------------예약페이지~ */
	// 받아온값 : 좌석 id1 , id2 <-- 편도면 널값이라 널값처리.
	// 좌석번호1 , 좌석번호 2 , 좌석등급1 , 좌석등급 2 , 좌석가격1 , 좌석가격 2 , 출,도착지
	String seatId1 = request.getParameter("seatId1");
	String seatId2 = null;
	if(request.getParameter("seatId2") != null && request.getParameter("seatId2") != ""){
	seatId2 = request.getParameter("seatId2");
	}
	// 항고기편 번호	
	String flightId1 = request.getParameter("flightId1");
	String flightId2 = null;
	if(request.getParameter("flightId2") != null && request.getParameter("flightId2") != ""){
	flightId2 = request.getParameter("flightId2");
	}
	// 좌석번호
	String seatNo1 = request.getParameter("seatNo1");
	String seatNo2 = null;
	if(request.getParameter("seatNo2") != null && request.getParameter("seatNo2") != ""){
		 seatNo2 = request.getParameter("seatNo1");
	}
	// 좌석등급
	String seatGrade1 = request.getParameter("seatGrade1");
	String seatGrade2 = null;
	if(request.getParameter("seatGrade2") != null && request.getParameter("seatGrade2") != ""){
		 seatGrade2 = request.getParameter("seatGrade2");
	}
	// 좌석등급 * 가격
	String seatPrice1 = request.getParameter("seatPrice1");
	String seatPrice2 = request.getParameter("seatPrice2");
	if(request.getParameter("seatPrice2") != null && request.getParameter("seatPrice2") != ""){
		seatPrice2 = request.getParameter("seatPrice2");
	}
	//출도착지
	String departureLocation = request.getParameter("departureLocation");
	String arrivalLocation = request.getParameter("arrivalLocation");
	// 금액
	String flightPrice = request.getParameter("flight_grade");
	System.out.println(seatId1 + " 좌석정보");
	System.out.println(flightId1 + "가는편정보");
	System.out.println(seatNo1 + "시트번호");
	System.out.println(seatPrice1 + "시트가격");
	System.out.println(departureLocation);
	System.out.println(arrivalLocation); 
	System.out.println(seatGrade1);
	
	// 세션에서 값 꺼내옴
	String customerId = null;
	String customerName = null;
	String customerPhone = null;
	String customerNation = null;
	String birthDate = null;
	Integer mileage = null;
	
	if(session.getAttribute("loginCs") != null){
	HashMap<String,Object> loginMember = (HashMap<String,Object>) (session.getAttribute("loginCs"));
	customerId = (String) loginMember.get("memberId");
	customerName = (String) loginMember.get("name");
	customerPhone = (String) loginMember.get("phone");
	customerNation = (String) loginMember.get("nation");
	birthDate = (String) loginMember.get("birthDate");
	mileage = (Integer) loginMember.get("mileage");
	}
	
	// flightId값으로 플라이트 출,도착,비행기정보 검색.
	ArrayList<HashMap<String,Object>> flightId1Inf = TicketingDAO.selectFlighInf(flightId1);
	ArrayList<HashMap<String,Object>> flightId2Inf = TicketingDAO.selectFlighInf(flightId2);
	// 항공편별 가격 : 출발
	
	// 
	int departPrice  = (int) (TicketingDAO.baseFare(flightId1) * TicketingDAO.grade(seatGrade1)) ;
	System.out.println(TicketingDAO.baseFare(flightId1));
	System.out.println(TicketingDAO.grade(seatGrade1));
	int arrivalPrice = (int) (TicketingDAO.baseFare(flightId2) * TicketingDAO.grade(seatGrade2)) ;
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <!-- 항공편정보 -->
 <div style="border: solid black;">
 <h1>예약한 항공편 정보</h1>
 <%for(HashMap<String,Object> Id1 : flightId1Inf){ %>
	<div>
	가는편 <%=departureLocation%> ---> <%=arrivalLocation%> 
		<div>
		<%=flightId1%><%=seatGrade1%>
		</div>
		<div>
		<%=(String) (Id1.get("departureTime"))%>
		<%=(String) (Id1.get("arrivalTime")) %>
		<%=(String) (Id1.get("planeName")) %>
		<%=(String) (Id1.get("airline")) %>
		</div>
	</div>
	<%
	}
 	%>
 	<%if(flightId2 != null){ %>
 		<%for(HashMap<String,Object> Id2 : flightId2Inf){ %>
	<div>
	오는편 <%=arrivalLocation%> ---> <%=departureLocation%> 
	<div>
		<%=flightId1%><%=seatGrade1%>
		</div>
		<div>
		<%=(String) (Id2.get("departureTime"))%>
		<%=(String) (Id2.get("arrivalTime")) %>
		<%=(String) (Id2.get("planeName")) %>
		<%=(String) (Id2.get("airline")) %>
		</div>
	</div>
	<%
	} }
 	%>
 </div>
  <!-- 승객정보 입력창? -->
    <form action="ticketingPageAction.jsp">
		<div style="border: solid black;">
		<h1>회원정보</h1>
			<div>
				<label for ="이름">이름</label>
				<input type="text" id="이름" name="customerName" value="<%=customerName%>" readonly="readonly">
				<label for ="핸드폰번호">핸드폰번호</label>
				<input type="tel" id="핸드폰번호" name="customerPhone" value="<%=customerPhone%>" readonly="readonly">
			</div>
				<label for="국적">국적</label>
				<input type="text"id="국적" name="customerNation" value="<%=customerNation%>" readonly="readonly">
				<label for="생일">생일</label>
				<input type="date" name="birthDate" value="<%=birthDate%>" readonly="readonly">
			<div>
				<label for ="이메일">이메일</label>
				<input type="text" name="customerId" value="<%=customerId%>" readonly="readonly">
				<label for ="마일리지">마일리지</label>
				<input id="마일리지" name="mileage" type="text" value="<%=mileage%>" readonly="readonly">
			</div>	
		</div>
		<div style="border: solid black;">
		 <h1>총결제금액</h1>
		 
		 가는편:<%=departPrice%><br>
		 <%if(flightId2 != null) {%>
		 오는편:<%=arrivalPrice%>
		 <%} %>
		</div>
		<input type="hidden" name="seatId1" value="<%=seatId1%>">
		<input type="hidden" name="seatId2" value="<%=seatId2%>">
		<input type="hidden" name="flightId1" value="<%=flightId1%>">
		<input type="hidden" name="flightId2" value="<%=flightId2%>">
		<input type="hidden" name="seatNo1" value="<%=seatNo1%>">
		<input type="hidden" name="seatNo2" value="<%=seatNo2%>">
		<input type="hidden" name="seatGrade1" value="<%=seatGrade1%>">
		<input type="hidden" name="seatGrade2" value="<%=seatGrade2%>">
		<input type="hidden" name="seatPrice1" value="<%=seatPrice1%>">
		<input type="hidden" name="seatPrice2" value="<%=seatPrice2%>">
		<button type="submit">예매하기</button>
	</form>
</body>
</html>