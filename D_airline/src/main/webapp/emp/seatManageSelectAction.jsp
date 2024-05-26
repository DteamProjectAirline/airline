<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="kjwdao.*"%>



<%
System.out.println("---------------seatManageSelectAction.jsp---------------");
System.out.println("세션 ID: " + session.getId());

String msg = null;
String checkFlight = null;
int flightId = 0;

System.out.println("msg : " + msg);
System.out.println("checkFlight : " + checkFlight);
System.out.println("flightId : " + flightId);

if (session.getAttribute("loginAd") == null) {
	System.out.println("관리자만 접근 가능한 페이지입니다.");
	msg = URLEncoder.encode("관리자만 접근 가능한 페이지입니다.", "UTF-8");
	response.sendRedirect("/D_airline/customer/flightMain.jsp?msg=" + msg);
	return;
}
%>

<%
HashMap<String, Object> m = new HashMap<>();

//변수할당
m = (HashMap<String, Object>) (session.getAttribute("loginAd"));

String adminId = null;

//해쉬맵 변수 스트링변수에 할당
adminId = (String) (m.get("adminId"));

System.out.println("[param]planeName : " + request.getParameter("planeName"));
System.out.println("[param]airline : " + request.getParameter("airline"));
System.out.println("[param]status : " + request.getParameter("status"));

if (request.getParameter("msg") != null) {
	msg = request.getParameter("msg");

}

if (request.getParameter("checkFlight") != null) {
	checkFlight = request.getParameter("checkFlight");
	System.out.println("checkFlight : " + checkFlight);
}

if (request.getParameter("flightId") != null) {
	flightId = Integer.parseInt(request.getParameter("flightId"));
	System.out.println("flightId : " + flightId);
}

System.out.println("msg : " + msg);
System.out.println("checkFlight : " + checkFlight);
System.out.println("flightId : " + flightId);

ArrayList<HashMap<String, Object>> selectSelectedFlightInfo = null;
ArrayList<HashMap<String, Object>> selectSeatNo = null;

selectSeatNo = SeatDAO.selectSeatNo(flightId);
selectSelectedFlightInfo = SeatDAO.selectSelectedFlightInfo(flightId);

if (selectSeatNo != null && !(selectSeatNo.isEmpty()) && selectSelectedFlightInfo != null
		&& !(selectSelectedFlightInfo.isEmpty())) {
	System.out.println("항공편-좌석 조회에 성공하였습니다.");
	msg = URLEncoder.encode("항공편-좌석 조회에 성공하였습니다.", "UTF-8");
	checkFlight = "1";
	response.sendRedirect(
	"/D_airline/emp/seatManage.jsp?msg=" + msg + "&checkFlight=" + checkFlight + "&flightId=" + flightId);

} else {
	System.out.println("항공편-좌석 조회에 실패하였습니다.");
	msg = URLEncoder.encode("항공편-좌석 조회에 실패하였습니다.", "UTF-8");
	response.sendRedirect("/D_airline/emp/seatManage.jsp?msg=" + msg);
	return;
}
%>
