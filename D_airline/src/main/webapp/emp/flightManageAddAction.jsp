<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import ="dao.*" %>



<%
System.out.println("---------------flightManageAddAction.jsp---------------");
System.out.println("세션 ID: " + session.getId());

String msg = null;
int intRouteId = 0;
String datetimeString = null;
int planeId = 0;
String flightDuration = null;
String date = null;
String time = null;
int flightId = 0;

if (session.getAttribute("loginAd") == null){
	System.out.println("관리자만 접근 가능한 페이지입니다.");
	msg = URLEncoder.encode("관리자만 접근 가능한 페이지입니다.","UTF-8");
		response.sendRedirect("/D_airline/customer/flightMain.jsp?msg="+msg);
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

System.out.println("[param]intRouteId : "+request.getParameter("intRouteId"));
System.out.println("[param]datetimeString : "+request.getParameter("datetimeString"));
System.out.println("[param]planeId : "+request.getParameter("planeId"));
System.out.println("[param]flightDuration : "+request.getParameter("flightDuration"));

if(request.getParameter("datetimeString")!=null){
	datetimeString = request.getParameter("datetimeString");
	System.out.println("datetimeString : "+datetimeString);
	
}

String[] dateParts = datetimeString.split("T");
date = dateParts[0];
time = dateParts[1];




intRouteId = Integer.parseInt(request.getParameter("intRouteId"));
datetimeString = request.getParameter("datetimeString");
planeId = Integer.parseInt(request.getParameter("planeId"));
flightDuration = request.getParameter("flightDuration");
System.out.println("date : " + date);
System.out.println("time : " + time);
System.out.println("intRouteid : " + intRouteId);
System.out.println("datetimeString : " + datetimeString);
System.out.println("planeId : " + planeId);
System.out.println("flightDuration : " + flightDuration);

int insertFlight = FlightDAO.insertFlight(intRouteId, planeId, date, time, flightDuration);
ArrayList<HashMap<String, Object>> selectInsertedFlightLatest = null;


if (insertFlight == 1) {
	System.out.println("항공편 신규등록에 성공하였습니다.");
	selectInsertedFlightLatest = FlightDAO.selectInsertedFlightLatest();
	for(HashMap<String, Object> m1 : selectInsertedFlightLatest ){
		flightId = (int)(m1.get("flightId"));
	}
	
	response.sendRedirect("/D_airline/emp/seatManageAddAction.jsp?flightId="+flightId);
	

} else {
	System.out.println("항공편 신규등록에 실패하였습니다.");
	msg = URLEncoder.encode("항공편 신규등록에 실패하였습니다.", "UTF-8");
	response.sendRedirect("/D_airline/emp/flightManage.jsp?msg=" + msg);
	return;
}
%>
