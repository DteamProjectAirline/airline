<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="kjwdao.*"%>



<%
System.out.println("---------------flightManagePlaneSearchAction.jsp---------------");
System.out.println("flightManagePlaneSearchAction.jsp페이지는 flightMange에서 항공편을 입력하기위해 항공편을 검색했을때 조건에 부합하는 항공기가 존재하는지 확인하는 페이지입니다.");
System.out.println("세션 ID: " + session.getId());

//변수 생성
String datetimeString = null;
String date = null;
String time = null;
String msg = null;
String intRouteId = null;
String planeList = null;
String flightDuration = null;

//세션 분기
if (session.getAttribute("loginAd") == null) {
	System.out.println("관리자만 접근 가능한 페이지입니다.");
	msg = URLEncoder.encode("관리자만 접근 가능한 페이지입니다.", "UTF-8");
	response.sendRedirect("/D_airline/customer/flightMain.jsp?msg=" + msg);
	return;
}


HashMap<String, Object> m = new HashMap<>();

//변수할당
m = (HashMap<String, Object>) (session.getAttribute("loginAd"));

String adminId = null;

//해쉬맵 변수 스트링변수에 할당
adminId = (String) (m.get("adminId"));

System.out.println("[param]intRouteId : " + request.getParameter("intRouteId"));
System.out.println("[param]routeId : " + request.getParameter("routeId"));
System.out.println("[param]datetimeString : " + request.getParameter("datetimeString"));

//input type datetime-local에서 받은 값이 있을때
//datetimeString값을 split으로 분해하여 date와 time으로 나눠 저장
if (request.getParameter("datetimeString") != null) {
	datetimeString = request.getParameter("datetimeString");
	System.out.println("datetimeString : " + datetimeString);

	String[] dateParts = datetimeString.split("T");
	date = dateParts[0];
	time = dateParts[1];

}

intRouteId = request.getParameter("intRouteId");

//변수 디버깅
System.out.println("intRouteId : " + intRouteId);
System.out.println("date : " + date);
System.out.println("time : " + time);

//노선id로 검색하였을때 해당하는 노선정보를 출력
ArrayList<HashMap<String, Object>> selectSearchRouteList = RouteDAO.selectSearchRouteList(intRouteId);

//selectSearchRouteList 쿼리 실행 여부에 따라 분기
if (selectSearchRouteList != null && !(selectSearchRouteList.isEmpty())) {
	System.out.println("해당 노선 조회에 성공하였습니다.");

} else {
	System.out.println("해당 노선 조회에 실패하였습니다.");
	msg = URLEncoder.encode("해당 노선 조회에 실패하였습니다.", "UTF-8");
	response.sendRedirect("/D_airline/emp/flightManage.jsp?msg=" + msg);
	return;
}

//selectSearchRouteList 쿼리가 실행된다면 노선운항시간을 추출
for (HashMap<String, Object> a : selectSearchRouteList) {
	flightDuration = (String) (a.get("flightDuration"));

	System.out.println("flightDuration : " + flightDuration);
}

//노선id를 선택했을때 해당하는 노선이 존재한다면 조건에 부합하는 항공기 리스트를 출력하는 쿼리
ArrayList<HashMap<String, Object>> selectAvailablePlaneList = FlightDAO.selectAvailablePlaneList(date, time,flightDuration);

//selectAvailablePlaneList 실행 여부에 따른 분기 실행
if (selectAvailablePlaneList != null && !(selectAvailablePlaneList.isEmpty())) {
	System.out.println("사용가능한 항공기 조회에 성공하였습니다.");
	msg = URLEncoder.encode("사용가능한 항공기조회에 성공하였습니다.", "UTF-8");
	planeList = "1";
	response.sendRedirect("/D_airline/emp/flightManage.jsp?msg=" + msg + "&planeList=" + planeList + "&intRouteId="
	+ intRouteId + "&datetimeString=" + datetimeString + "&flightDuration=" + flightDuration);

} else {
	System.out.println("사용가능한 항공기 조회에 실패하였습니다.");
	msg = URLEncoder.encode("사용가능한 항공기조회에 실패하였습니다.", "UTF-8");
	response.sendRedirect("/D_airline/emp/flightManage.jsp?msg=" + msg);
	return;
}
%>
