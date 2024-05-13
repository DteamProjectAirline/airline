<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import ="dao.*" %>



<%
System.out.println("---------------flightManagePlaneSearchAction.jsp---------------");
System.out.println("세션 ID: " + session.getId());

String msg = null;
String routeId = null;
String departureTime = null;
String flightDuration = null;



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

System.out.println("[param]routeId : "+request.getParameter("routeId"));
System.out.println("[param]departureTime : "+request.getParameter("departureTime"));



routeId = request.getParameter("routeId");
departureTime = request.getParameter("departureTime");


System.out.println("routeId : " + routeId);
System.out.println("departureTime : " + departureTime);


ArrayList<HashMap<String, Object>> selectAllRouteList = RouteDAO.selectSearchRouteList(routeId);


if (selectAllRouteList != null && !(selectAllRouteList.isEmpty()) ) {
	System.out.println("해당 노선 조회에 성공하였습니다.");
	

} else {
	System.out.println("해당 노선 조회에 실패하였습니다.");
	msg = URLEncoder.encode("해당 노선 조회에 실패하였습니다.", "UTF-8");
	response.sendRedirect("/D_airline/emp/flightManage.jsp?msg=" + msg);
	return;
}

for(HashMap<String, Object> a : selectAllRouteList) {
	flightDuration = (String)(a.get("flightDuration"));
}








%>
