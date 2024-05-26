<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="kjwdao.*"%>



<%
System.out.println("---------------flightManageSearchFlight.jsp---------------");
System.out.println("flightMage페이지에서 항공편 수정을 위해 가장 먼저 진행하는 프로세스인 항공편을 검색했을 때에 진입하는 페이지입니다. ");
System.out.println("이 액션페이지에서 해당하는 항공편과 그 항공편으로부터 얻을수있는 조인된 테이블의 값을 가져옵니다");
System.out.println("항공편에 해당하는 노선정보-도시-국가정보 및 출발날짜와 항공편에 배정된 항공기 정보를 가져옵니다.");
System.out.println("세션 ID: " + session.getId());

//변수 생성
String msg = null;
String datetimeString = null;
int flightId = 0;
String checkRoute = null;
String flightExists = null;
String departureTime = null;

//세션 인증
if (session.getAttribute("loginAd") == null) {
	System.out.println("관리자만 접근 가능한 페이지입니다.");
	msg = URLEncoder.encode("관리자만 접근 가능한 페이지입니다.", "UTF-8");
	response.sendRedirect("/D_airline/customer/flightMain.jsp?msg=" + msg);
	return;
}
//세션에서 받은 정보 변수할당
HashMap<String, Object> m = new HashMap<>();

m = (HashMap<String, Object>) (session.getAttribute("loginAd"));

String adminId = null;

//해쉬맵 변수 스트링변수에 할당
adminId = (String) (m.get("adminId"));

//param값 디버깅
System.out.println("[param]flightId : " + request.getParameter("flightId"));

if (request.getParameter("flightId") != null) {

	flightId = Integer.parseInt(request.getParameter("flightId"));

}

System.out.println("flightId : " + flightId);
//항공편을 조회했을때 항공편에 해당하는 노선을 최상단에 위치+모든 노선조회 진행하는 쿼리
ArrayList<HashMap<String, Object>> selectAllRouteCityCountryListSearchFirst = RouteDAO
		.selectAllRouteCityCountryListSearchFirst(flightId);

for (HashMap<String, Object> m2 : selectAllRouteCityCountryListSearchFirst) {
	//해당하는 항공편이 존재하는지 유무 Y,N
	flightExists = (String) (m2.get("flightExists"));

}

//항공편에 해당하는 노선 정보를 출력하는 쿼리
ArrayList<HashMap<String, Object>> selectRouteInfo = FlightDAO.selectRouteInfo(flightId);
for (HashMap<String, Object> m3 : selectRouteInfo) {
	//해당하는 항공편의 출발날짜를 DB에서 추출하여 departureTime(DB로부터 받는정보)에 주입 
	//*주의 departureTimeLocal(캘린더에서 선택하여 보내는정보-가공전 데이터)과 구분할것
	departureTime = (String) (m3.get("departureTime"));

	System.out.println("departureTime :" + departureTime);
}

//selectAllRouteCityCountryListSearchFirst쿼리가 실행되었을때
if (selectAllRouteCityCountryListSearchFirst != null && !(selectAllRouteCityCountryListSearchFirst.isEmpty())) {
	System.out.println("노선 조회에 성공하였습니다.");
	//해당하는 항공편에 부여된 노선이 있다면
	if (flightExists.equals("Y")) {
		msg = URLEncoder.encode("노선 조회에 성공하였습니다.", "UTF-8");
		checkRoute = "1";
		//해당하는 항공편에 부여된 노선이 없다면
	} else if (flightExists.equals("N")) {
		msg = URLEncoder.encode("해당 노선은 존재하지 않습니다.", "UTF-8");
	}

	response.sendRedirect("/D_airline/emp/flightManage.jsp?msg=" + msg + "&flightId=" + flightId + "&checkRoute="
	+ checkRoute + "&departureTime=" + departureTime);
	//selectAllRouteCityCountryListSearchFirst쿼리가 실패했을때
} else {
	System.out.println("해당 노선 조회에 실패하였습니다.");
	msg = URLEncoder.encode("해당 노선 조회에 실패하였습니다.", "UTF-8");
	response.sendRedirect("/D_airline/emp/flightManage.jsp?msg=" + msg);
	return;
}
%>