<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import ="kjwdao.*" %>


<!-- Controller Layer -->
<%
System.out.println("---------------cityManageModifyAction.jsp---------------");
System.out.println("세션 ID: " + session.getId());

String msg = null;
String cityName = null;
String countryId = null;
String airport = null;
String keyCityName = null;

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

System.out.println("[param]cityName : "+request.getParameter("cityName"));
System.out.println("[param]countryId : "+request.getParameter("countryId"));
System.out.println("[param]airport : "+request.getParameter("airport"));
//


cityName = request.getParameter("cityName");
countryId = request.getParameter("countryId");
airport = request.getParameter("airport");
keyCityName = request.getParameter("keyCityName");

System.out.println("cityName : " + cityName);
System.out.println("countryId : " + countryId);
System.out.println("airport : " + airport);
System.out.println("keyCityName : " + keyCityName);

int updateCity = CityDAO.updateCity(cityName, countryId, airport, keyCityName);

if (updateCity == 1) {
	System.out.println("도시 정보변경에 성공하였습니다.");
	msg = URLEncoder.encode("도시 정보변경에 성공하였습니다.", "UTF-8");
	response.sendRedirect("/D_airline/emp/cityManage.jsp?msg=" + msg);
	

} else {
	System.out.println("도시 정보변경에 실패하였습니다.");
	msg = URLEncoder.encode("도시 정보변경에 실패하였습니다.", "UTF-8");
	response.sendRedirect("/D_airline/emp/cityManage.jsp?msg=" + msg);
	return;
}
%>
