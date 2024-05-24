<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.time.*"%>
<%@ page import="kjwdao.*"%>
<%@ page import="java.net.*"%>

<%
System.out.println("----------seatSelection.jsp----------");

String msg = null;

int flightId1 = 0;
int flightId2 = 0;
String selectedSeatGrade1 = null;
String selectedSeatGrade2 = null;


String type = null;
String departureLocation = null;
String arrivalLocation = null;

int seatId1 = 0;
String seatState = null;
int seatNo1 = 0;
double seatPrice1 = 0;

System.out.println("[param] selectedSeatGrade1 : " + request.getParameter("selectedSeatGrade1"));
System.out.println("[param] selectedSeatGrade2 : " + request.getParameter("selectedSeatGrade2"));
System.out.println("[param] flightId1 : " + request.getParameter("flightId1"));
System.out.println("[param] flightId2 : " + request.getParameter("flightId2"));

if (request.getParameter("flightId1") != null) {
	flightId1 = Integer.parseInt(request.getParameter("flightId1"));
}

if (request.getParameter("flightId2") != null) {
	flightId2 = Integer.parseInt(request.getParameter("flightId2"));
}

if (request.getParameter("selectedSeatGrade1") != null) {
	selectedSeatGrade1 = request.getParameter("selectedSeatGrade1");
}

if (request.getParameter("selectedSeatGrade2") != null) {
	selectedSeatGrade2 = request.getParameter("selectedSeatGrade2");
}

if (request.getParameter("type") != null) {
	type = request.getParameter("type");
}

if (request.getParameter("departureLocation") != null) {
	departureLocation = request.getParameter("departureLocation");
}

if (request.getParameter("arrivalLocation") != null) {
	arrivalLocation = request.getParameter("arrivalLocation");
}

System.out.println("type : " + type);
System.out.println("flightId1 : " + flightId1);
System.out.println("flightId2 : " + flightId2);
System.out.println("selectedSeatGrade1 : " + selectedSeatGrade1);
System.out.println("selectedSeatGrade2 : " + selectedSeatGrade2);
System.out.println("departureLocation : " + departureLocation);
System.out.println("arrivalLocation : " + arrivalLocation);

ArrayList<HashMap<String, Object>> selectSeatNo = SeatDAO.selectSeatNo(flightId1);

if (selectSeatNo != null || !(selectSeatNo.isEmpty())) {
	System.out.println("해당 항공편 좌석조회 성공");

} else {
	System.out.println("해당 항공편 좌석조회 실패");
	msg = URLEncoder.encode("해당 항공편 좌석조회에 실패하였습니다.", "UTF-8");
	response.sendRedirect("/D_airline/customer/flightList1.jsp?msg=" + msg);
	return;
}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>seatSelection.jsp</title>
</head>
<body>

	<div>
		<%
		if (request.getParameter("flightId1") != null) {

			if (type != null || type.equals("편도")) {

				for (HashMap<String, Object> m2 : selectSeatNo) {

					if (selectedSeatGrade1.equals((String) (m2.get("seatGrade")))) {
		
						seatId1 = (int) (m2.get("seatId"));
						flightId1 = (int) (m2.get("flightId"));
						seatState = (String) (m2.get("seatState"));
						seatNo1 = (int) (m2.get("seatNo"));
						seatPrice1 = (double) (m2.get("seatPrice"));
				%>
		
				<span>좌석 정보</span>
				<div>
					<a
						href="/D_airline/customer/ticketingPage.jsp?seatId1=<%=seatId1%>&flightId1=<%=flightId1%>&seatNo1=<%=seatNo1%>&seatGrade1=<%=selectedSeatGrade1%>&seatPrice1=<%=seatPrice1%>&departureLocation=<%=departureLocation%>&arrivalLocation=<%=arrivalLocation%>"><%=selectedSeatGrade1%>/<%=seatNo1%>/<%=seatState%></a>
				</div>
		
				<%
					}

				}

			}else if(type != null || type.equals("왕복")){
				
				
				for (HashMap<String, Object> m2 : selectSeatNo) {

					if (selectedSeatGrade1.equals((String) (m2.get("seatGrade")))) {
		
						seatId1 = (int) (m2.get("seatId"));
						flightId1 = (int) (m2.get("flightId"));
						seatState = (String) (m2.get("seatState"));
						seatNo1 = (int) (m2.get("seatNo"));
						seatPrice1 = (double) (m2.get("seatPrice"));
				%>
		
				<span>좌석 정보</span>
				<div>
					<a
						href="/D_airline/customer/seatSelection2.jsp?seatId1=<%=seatId1%>&flightId1=<%=flightId1%>&flightId2=<%=flightId2%>&seatNo1=<%=seatNo1%>&selectedSeatGrade1=<%=selectedSeatGrade1%>&selectedSeatGrade2=<%=selectedSeatGrade2%>&seatPrice1=<%=seatPrice1%>
						&departureLocation=<%=departureLocation%>&arrivalLocation=<%=arrivalLocation%>&
						"><%=selectedSeatGrade1%>/<%=seatNo1%>/<%=seatState%></a>
				</div>
		
				<%
					}

				}
				
				
				
				
			}

		}
		%>
	</div>


</body>
</html>