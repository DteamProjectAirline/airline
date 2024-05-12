<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import ="dao.*" %>



<%
System.out.println("---------------planeManageDeleteAction.jsp---------------");
System.out.println("세션 ID: " + session.getId());

String msg = null;
String planeId = null;



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

System.out.println("[param]planeId : "+request.getParameter("planeId"));

//


planeId = request.getParameter("planeId");

System.out.println("planeId : " + planeId);

int deletePlane = PlaneDAO.deletePlane(planeId);

if (deletePlane == 1) {
	System.out.println("항공기 삭제에 성공하였습니다.");
	msg = URLEncoder.encode("항공기 삭제에 성공하였습니다.", "UTF-8");
	response.sendRedirect("/D_airline/emp/planeManage.jsp?msg=" + msg);
	

} else {
	System.out.println("항공기 삭제에 실패하였습니다.");
	msg = URLEncoder.encode("항공기 삭제에 실패하였습니다.", "UTF-8");
	response.sendRedirect("/D_airline/emp/planeManage.jsp?msg=" + msg);
	return;
}
%>
