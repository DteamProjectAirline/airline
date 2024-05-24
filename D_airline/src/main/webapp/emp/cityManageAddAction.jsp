<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="kjwdao.*"%>



<%
System.out.println("---------------cityManageAddAction.jsp---------------");
System.out.println("세션 ID: " + session.getId());

//변수 생성
String msg = null;
String cityName = null;
String countryId = null;
String airport = null;

//세션 분기
if (session.getAttribute("loginAd") == null) {
	System.out.println("관리자만 접근 가능한 페이지입니다.");
	msg = URLEncoder.encode("관리자만 접근 가능한 페이지입니다.", "UTF-8");
	response.sendRedirect("/D_airline/customer/flightMain.jsp?msg=" + msg);
	return;
}


HashMap<String, Object> m = new HashMap<>();

//세션에서 받은 정보 변수할당
m = (HashMap<String, Object>) (session.getAttribute("loginAd"));

String adminId = null;

//해쉬맵 변수 스트링변수에 할당
adminId = (String) (m.get("adminId"));

//param값 디버깅
System.out.println("[param]cityName : " + request.getParameter("cityName"));
System.out.println("[param]countryId : " + request.getParameter("countryId"));
System.out.println("[param]airport : " + request.getParameter("airport"));

cityName = request.getParameter("cityName");
countryId = request.getParameter("countryId");
airport = request.getParameter("airport");

System.out.println("cityName : " + cityName);
System.out.println("countryId : " + countryId);
System.out.println("airport : " + airport);

//도시 입력 위한 쿼리(insert)
int insertCity = CityDAO.insertCity(cityName, countryId, airport);

//insertCity 정상 실행 여부에 의한 분기
if (insertCity == 1) {
	System.out.println("도시 신규등록에 성공하였습니다.");
	msg = URLEncoder.encode("도시 신규등록에 성공하였습니다.", "UTF-8");
	response.sendRedirect("/D_airline/emp/cityManage.jsp?msg=" + msg);

} else {
	System.out.println("도시 신규등록에 실패하였습니다.");
	msg = URLEncoder.encode("도시 신규 등록에 실패하였습니다.", "UTF-8");
	response.sendRedirect("/D_airline/emp/cityManage.jsp?msg=" + msg);
	return;
}
%>
