<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import ="kjwdao.*" %>



<%
System.out.println("---------------routeManageDeleteAction.jsp---------------");
System.out.println("세션 ID: " + session.getId());

String msg = null;
String routeId = null;



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
routeId = (String) (m.get("routeId"));

System.out.println("[param]routeId : "+request.getParameter("routeId"));

//


routeId = request.getParameter("routeId");

System.out.println("routeId : " + routeId);

int deleteRoute = RouteDAO.deleteRoute(routeId);

if (deleteRoute == 1) {
	System.out.println("노선 삭제에 성공하였습니다.");
	msg = URLEncoder.encode("노선 삭제에 성공하였습니다.", "UTF-8");
	response.sendRedirect("/D_airline/emp/routeManage.jsp?msg=" + msg);
	

} else {
	System.out.println("노선 삭제에 실패하였습니다.");
	msg = URLEncoder.encode("노선 삭제에 실패하였습니다.", "UTF-8");
	response.sendRedirect("/D_airline/emp/routeManage.jsp?msg=" + msg);
	return;
}
%>
