<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import ="kjwdao.*" %>



<%
System.out.println("---------------flightManageModifyAction.jsp---------------");
System.out.println("세션 ID: " + session.getId());

String msg = null;

int intRouteId = 0;
int planeId = 0;
int flightId = 0;
String flightDuration = null;
String datetimeString = null;
String date = null;
String time = null;

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
System.out.println("[param]planeId : "+request.getParameter("planeId"));
System.out.println("[param]flightId : "+request.getParameter("flightId"));
System.out.println("[param]datetimeString : "+request.getParameter("datetimeString"));
System.out.println("[param]flightDuration : "+request.getParameter("flightDuration"));


if(request.getParameter("intRouteId")!= null){
	intRouteId = Integer.parseInt(request.getParameter("intRouteId"));
}

if(request.getParameter("planeId")!= null){
	planeId = Integer.parseInt(request.getParameter("planeId"));
}

if(request.getParameter("flightId")!= null){
	flightId = Integer.parseInt(request.getParameter("flightId"));
}

if(request.getParameter("flightDuration")!= null){
	flightDuration = request.getParameter("flightDuration");
}

if(request.getParameter("datetimeString")!=null){
	datetimeString = request.getParameter("datetimeString");
	System.out.println("datetimeString : "+datetimeString);
	
	String[] dateParts = datetimeString.split("T");
	date = dateParts[0];
	time = dateParts[1];
	
}


System.out.println("intRouteId : "+intRouteId);
System.out.println("planeId : "+planeId);
System.out.println("flightId : "+flightId);


System.out.println("planeId : " + planeId);

int updateFlight = FlightDAO.updateFlight(intRouteId, planeId, date, time, flightDuration, flightId);

if (updateFlight == 1) {
	System.out.println("항공편 정보변경에 성공하였습니다.");
	msg = URLEncoder.encode("항공편 정보변경에 성공하였습니다.", "UTF-8");
	response.sendRedirect("/D_airline/emp/flightManage.jsp?msg=" + msg);
	

} else {
	System.out.println("항공편 정보변경에 실패하였습니다.");
	msg = URLEncoder.encode("항공편 정보변경에 실패하였습니다.", "UTF-8");
	response.sendRedirect("/D_airline/emp/flightManage.jsp?msg=" + msg);
	return;
}
%>
