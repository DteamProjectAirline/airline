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
	/* System.out.println(seatId1 + " 좌석정보");
	System.out.println(flightId1 + "가는편정보");
	System.out.println(seatNo1);
	System.out.println(seatPrice1);
	System.out.println(departureLocation);
	System.out.println(arrivalLocation); */
	String customerId = null;
	if(session.getAttribute("loginCs") != null){
	HashMap<String,Object> loginMember = (HashMap<String,Object>) (session.getAttribute("loginCs"));
	customerId = (String) loginMember.get("memberId"); 
	}
	
	// flightId값으로 플라이트 출,도착,비행기정보 검색.
	ArrayList<HashMap<String,Object>> flightId1Inf = TicketingDAO.selectFlighInf(flightId1);
	ArrayList<HashMap<String,Object>> flightId2Inf = TicketingDAO.selectFlighInf(flightId2);
	
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <!-- 항공편정보 -->
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
  <!-- 승객정보 입력창? -->
    <form action="ticketingPageAction.jsp">
		<div style="border: solid black;">
			<div>
				<label for ="이름">이름 로그인 정보 불러와야함</label>
				<input type="text" id="이름" value="">
				<label for ="핸드폰번호">핸드폰번호</label>
				<input type="tel" id="핸드폰번호">
			</div>
				<label for="국적">국적</label>
				<input type="text"id="국적" value="">
				<label for="생일">생일</label>
				<input type="date">
			<div>
				<label for ="이메일">이메일</label>
				<input type="text" value="">
				<label for ="마일리지">마일리지</label>
				<input id="마일리지" type="text" value="" disabled="disabled">
			</div>	
		</div>
	</form>
</body>
</html>