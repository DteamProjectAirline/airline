<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import ="dao.*" %>



<%
System.out.println("---------------flightManageSearchFlight.jsp---------------");
System.out.println("세션 ID: " + session.getId());

String msg = null;
String datetimeString = null;
int flightId = 0;
String checkRoute = null;
String flightExists = null;
String departureTime = null;

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

System.out.println("[param]flightId : "+request.getParameter("flightId"));


if(request.getParameter("flightId")!= null){
	
flightId = Integer.parseInt(request.getParameter("flightId"));

}

System.out.println("flightId : "+flightId);

ArrayList<HashMap<String, Object>> selectAllRouteCityCountryListSearchFirst = RouteDAO.selectAllRouteCityCountryListSearchFirst(flightId);

for(HashMap<String, Object> m2 : selectAllRouteCityCountryListSearchFirst){
	flightExists = (String)(m2.get("flightExists"));
	

}

ArrayList<HashMap<String, Object>> selectRouteInfo = FlightDAO.selectRouteInfo(flightId);
for(HashMap<String, Object> m3 :  selectRouteInfo){
	departureTime = (String)(m3.get("departureTime"));
	
	
	System.out.println("departureTime :" + departureTime);
}









if ( selectAllRouteCityCountryListSearchFirst != null && !( selectAllRouteCityCountryListSearchFirst.isEmpty()) ) {
	System.out.println("노선 조회에 성공하였습니다.");
	if(flightExists.equals("Y")){
		msg = URLEncoder.encode("노선 조회에 성공하였습니다.", "UTF-8");
		checkRoute = "1";
	}else if(flightExists.equals("N")){
		msg = URLEncoder.encode("해당 노선은 존재하지 않습니다.", "UTF-8");
	}
	
	
	response.sendRedirect("/D_airline/emp/flightManage.jsp?msg=" + msg+"&flightId="+flightId+"&checkRoute="+checkRoute+"&departureTime="+departureTime);
	
} else {
	System.out.println("해당 노선 조회에 실패하였습니다.");
	msg = URLEncoder.encode("해당 노선 조회에 실패하였습니다.", "UTF-8");
	response.sendRedirect("/D_airline/emp/flightManage.jsp?msg=" + msg);
	return;
}
%>