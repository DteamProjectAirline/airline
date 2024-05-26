<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="kjwdao.*"%>

<%
System.out.println("---------------flightManageModifiedPlaneSearchAction.jsp---------------");
System.out.println("flightMage페이지에서 수정하려는 항공편을 검색하여 노선과 출발날짜를 재지정한 후 조건에 부합하는 항공기를 검색하기 위한 액션페이지입니다. ");
System.out.println("세션 ID: " + session.getId());

//변수 생성
String departureTimeLocal = null;
String date = null;
String time = null;
String msg = null;
String intRouteId = null;
String planeList = null;
String checkRoute = null;
String modifyPlaneList = null;
String flightDuration = null;
String datetimeString = null;
String flightId = null;

// 세션 확인 및 관리자 체크
if (session.getAttribute("loginAd") == null) {
	System.out.println("관리자만 접근 가능한 페이지입니다.");
	msg = URLEncoder.encode("관리자만 접근 가능한 페이지입니다.", "UTF-8");
	response.sendRedirect("/D_airline/customer/flightMain.jsp?msg=" + msg);
	return;
}

// 세션 정보 가져오기
HashMap<String, Object> m = (HashMap<String, Object>) session.getAttribute("loginAd");
String adminId = (String) m.get("adminId");

System.out.println("[param]intRouteId : " + request.getParameter("intRouteId"));
System.out.println("[param]routeId : " + request.getParameter("routeId"));
//System.out.println("[param]departureTimeLocal : " + request.getParameter("departureTimeLocal"));
System.out.println("[param]datetimeString : " + request.getParameter("datetimeString"));
System.out.println("[param]checkRoute : " + request.getParameter("checkRoute"));

// 파라미터 가져오기
if (request.getParameter("datetimeString") != null) {
	datetimeString = request.getParameter("datetimeString");
	String[] dateParts = datetimeString.split("T");
	date = dateParts[0];
	time = dateParts[1];

}

if (request.getParameter("flightId") != null) {
	flightId = request.getParameter("flightId");

}

intRouteId = request.getParameter("intRouteId");
System.out.println("flightId : " + flightId);
System.out.println("datetimeString : " + datetimeString);
System.out.println("departureTimeLocal : " + departureTimeLocal);
System.out.println("intRouteId : " + intRouteId);
System.out.println("date : " + date);
System.out.println("time : " + time);

// 노선 정보 조회
ArrayList<HashMap<String, Object>> selectSearchRouteList = RouteDAO.selectSearchRouteList(intRouteId);

if (selectSearchRouteList != null && !selectSearchRouteList.isEmpty()) {
	System.out.println("해당 노선 조회에 성공하였습니다.");
} else {
	System.out.println("해당 노선 조회에 실패하였습니다.");
	msg = URLEncoder.encode("해당 노선 조회에 실패하였습니다.", "UTF-8");
	response.sendRedirect("/D_airline/emp/flightManage.jsp?msg=" + msg);
	return;
}

// 노선 정보에서 운항시간 가져오기
for (HashMap<String, Object> a : selectSearchRouteList) {
	flightDuration = (String) a.get("flightDuration");
	System.out.println("flightDuration : " + flightDuration);
}

// 사용 가능한 항공기 조회
ArrayList<HashMap<String, Object>> selectAvailablePlaneList = FlightDAO.selectAvailablePlaneList(date, time,
		flightDuration);

if (selectAvailablePlaneList != null && !selectAvailablePlaneList.isEmpty()) {
	System.out.println("사용가능한 항공기 조회에 성공하였습니다.");
	msg = URLEncoder.encode("사용가능한 항공기조회에 성공하였습니다.", "UTF-8");
	modifyPlaneList = "1";
	response.sendRedirect("/D_airline/emp/flightManage.jsp?msg=" + msg + "&modifyPlaneList=" + modifyPlaneList
	+ "&intRouteId=" + intRouteId + "&datetimeString=" + datetimeString + "&flightDuration=" + flightDuration
	+ "&checkRoute=" + checkRoute + "&flightId=" + flightId);
} else {
	System.out.println("사용가능한 항공기 조회에 실패하였습니다.");
	msg = URLEncoder.encode("사용가능한 항공기조회에 실패하였습니다.", "UTF-8");
	response.sendRedirect("/D_airline/emp/flightManage.jsp?msg=" + msg);
	return;
}
%>
