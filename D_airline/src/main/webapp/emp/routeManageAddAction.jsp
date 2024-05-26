<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="kjwdao.*"%>



<%
System.out.println("---------------routeManageAddAction.jsp---------------");
System.out.println("세션 ID: " + session.getId());

String msg = null;
String departureCity = null;
String arrivalCity = null;
String basefare = null;
String hour = null;
String minute = null;

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

System.out.println("[param]departureCity : " + request.getParameter("departureCity"));
System.out.println("[param]arrivalCity : " + request.getParameter("arrivalCity"));
System.out.println("[param]basefare : " + request.getParameter("basefare"));
System.out.println("[param]hour : " + request.getParameter("hour"));
System.out.println("[param]minute : " + request.getParameter("minute"));

departureCity = request.getParameter("departureCity");
arrivalCity = request.getParameter("arrivalCity");
basefare = request.getParameter("basefare");
hour = request.getParameter("hour");
minute = request.getParameter("minute");

System.out.println("departureCity : " + departureCity);
System.out.println("arrivalCity : " + arrivalCity);
System.out.println("basefare : " + basefare);
System.out.println("hour : " + hour);
System.out.println("minute : " + minute);

int insertRoute = RouteDAO.insertRoute(departureCity, arrivalCity, basefare, hour, minute);

if (insertRoute == 1) {
	System.out.println("노선 신규등록에 성공하였습니다.");
	msg = URLEncoder.encode("노선 신규등록에 성공하였습니다.", "UTF-8");
	response.sendRedirect("/D_airline/emp/routeManage.jsp?msg=" + msg);

} else {
	System.out.println("노선 신규등록에 실패하였습니다.");
	msg = URLEncoder.encode("노선 신규등록에 실패하였습니다.", "UTF-8");
	response.sendRedirect("/D_airline/emp/routeManage.jsp?msg=" + msg);
	return;
}
%>
