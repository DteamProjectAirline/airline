<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="kjwdao.*"%>
<%@ page import="java.net.*"%>

<%
System.out.println("----------flightManage.jsp----------");
System.out.println("세션 ID: " + session.getId());

//변수 생성
String msg = null;
String date = null;
String flightDuration = null;
String time = null;
String planeList = null;
String modifyPlaneList = null;
int intRouteId = 0;
String datetimeString = null;
String checkRoute = null; //노선이 특정됐는지 여부를 묻는 변수
int flightId = 0;
String flightExists = null; //항공편 존재유무 담는 변수
String departureTime = null;//출발시간(DB에서 받은 가공전 원데이터)
String departureTimeLocal = null;//인풋태그 datetime-local(일자와 시간을 함께 선택하는 달력input)에 들어갈 변수(departureDate와 departureHourMinute사이 T를 가공하여 만들어짐)
String departureDate = null;//departureTime을 split으로 가공하여 '년-월-일' 만 추출
String departureHourMinute = null;//departureTime을 split으로 가공하여 '시-분' 만 추출

//세션 분기
if (session.getAttribute("loginAd") == null) {
	System.out.println("관리자만 접근 가능한 페이지입니다.");
	msg = URLEncoder.encode("관리자만 접근 가능한 페이지입니다.", "UTF-8");
	response.sendRedirect("/D_airline/customer/flightMain.jsp?msg=" + msg);
	return;
}

HashMap<String, Object> m = new HashMap<>();

m = (HashMap<String, Object>) (session.getAttribute("loginAd"));

//세션의 값을 받은 변수생성
String adminId = null;
String hireDate = null;
String post = null;
String type = null;

//세션 변수 주입
adminId = (String) (m.get("adminId"));
hireDate = (String) (m.get("hireDate"));
post = (String) (m.get("post"));
type = (String) (m.get("type"));

m.put("type", "admin");

//세션 변수 디버깅
System.out.println(session.getAttribute("loginAd"));
System.out.println("adminId : " + adminId);
System.out.println("hireDate : " + hireDate);
System.out.println("post : " + post);

//페이지네이션 param값 디버깅
System.out.println("[param]rowPerPage : " + request.getParameter("rowPerPage"));
System.out.println("[param]currentPage : " + request.getParameter("currentPage"));
//param값 디버깅
System.out.println("[param]flightDuration : " + request.getParameter("flightDuration"));
System.out.println("[param]intRouteid : " + request.getParameter("intRouteId"));
System.out.println("[param]datetimeString : " + request.getParameter("datetimeString"));//인풋 날짜 태그 datetime-local에 의해 입력받은 param값
System.out.println("[param]planeList : " + request.getParameter("planeList"));
System.out.println("[param]modifyPlaneList : " + request.getParameter("modifyPlaneList"));
System.out.println("[param]flightExists : " + request.getParameter("flightExsits"));
System.out.println("[param]checkRoute : " + request.getParameter("checkRoute")); //검색했을 때 노선이 존재하면 checkRoute 1을 반환
System.out.println("[param]flightId : " + request.getParameter("flightId"));
System.out.println("[param]departureTimeLocal : " + request.getParameter("departureTimeLocal"));

//param값 확인후 변수주입
if (request.getParameter("msg") != null) {
	msg = request.getParameter("msg");
	System.out.println("msg : " + msg);
}

if (request.getParameter("date") != null) {
	date = request.getParameter("date");
	System.out.println("date : " + date);
}

if (request.getParameter("flightDuration") != null) {
	flightDuration = request.getParameter("flightDuration");
	System.out.println("flightDuration : " + flightDuration);
}

if (request.getParameter("intRouteId") != null) {
	intRouteId = Integer.parseInt(request.getParameter("intRouteId"));
	System.out.println("intRouteId : " + intRouteId);
}

//datetime-local param값이 존재하면 변수주입
if (request.getParameter("datetimeString") != null) {
	datetimeString = request.getParameter("datetimeString");
	System.out.println("datetimeString : " + datetimeString);

	//datetime-local param값을 split 하여 date와 time으로 분해
	String[] dateSplit = datetimeString.split("T");
	date = dateSplit[0];
	time = dateSplit[1];

	System.out.println("date : " + date);
	System.out.println("time : " + time);
}

//새로 추가할 항공편에 노선과 출발시간을 입력했을 때 입력가능한 항공기 리스트 출력 쿼리가 정상적으로 실행되었을 때.
//flightManagePlaneSearchAction.jsp로부터 받은 param값
if (request.getParameter("planeList") != null) {
	planeList = request.getParameter("planeList");
	System.out.println("planeList : " + planeList);
}

//정보수정할 항공편에 노선과 출발시간을 입력했을 때 입력가능한 항공기 리스트 출력 쿼리가 정상적으로 실행되었을 때.
//flightManageModifyAction.jsp로부터 받은 param값
if (request.getParameter("modifyPlaneList") != null) {
	modifyPlaneList = request.getParameter("modifyPlaneList");
	System.out.println("modifyPlaneList : " + modifyPlaneList);
}
//노선이 특정됐는지 여부를 묻는 변수
if (request.getParameter("checkRoute") != null) {
	checkRoute = request.getParameter("checkRoute");
	System.out.println("checkRoute : " + checkRoute);
}

if (request.getParameter("flightId") != null) {
	flightId = Integer.parseInt(request.getParameter("flightId"));
	System.out.println("flightId : " + flightId);
}

if (request.getParameter("flightExists") != null) {
	flightExists = request.getParameter("flightExists");
	System.out.println("flightExists : " + flightExists);
}

//db로부터 꺼내온 출발시간을 input type datetime-local 에서 인식할수 있는 형태로 가공하여 departureTimeLocal에 저장 
if (request.getParameter("departureTime") != null && checkRoute.equals("1")) {
	departureTime = request.getParameter("departureTime");
	String[] departureTimeSplit = departureTime.split(" ");
	departureDate = departureTimeSplit[0];
	departureHourMinute = departureTimeSplit[1].substring(0, 5);
	departureTimeLocal = departureDate + "T" + departureHourMinute;
}

//input type datetime-local 에서 받은 변수값
if (request.getParameter("departureTimeLocal") != null) {
	departureTimeLocal = request.getParameter("departureTimeLocal");
	System.out.println("departureTimeLocal : " + departureTimeLocal);
}

// 전체행수 검색 변수설정 ------------------------
int totalRow = 0; // 조회쿼리 전체행수
int rowPerPage = 10; // 페이지당 행수
int totalPage = 1; // 전체 페이지수

int currentPage = 1; // 현재 페이지수
int startPage = 0; // 시작행

int startRow = (currentPage - 1) * rowPerPage;

System.out.println("totalRow : " + totalRow);
System.out.println("rowPerPage : " + rowPerPage);
System.out.println("totalRow % rowPerPage : " + totalRow % rowPerPage);
System.out.println("totalPage : " + totalPage);

// 현재 페이지 값이 넘어왔을 때 커런트 페이지 값을 넘겨받는다
if (request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
	System.out.println("currentPage : " + currentPage);
}
// 로우퍼 페이지 값이 넘어왔을때 로우퍼 페이지 값을 넘겨받는다
if (request.getParameter("rowPerPage") != null) {
	rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	System.out.println("rowPerPage : " + rowPerPage);
}

startPage = (currentPage - 1) * rowPerPage;
System.out.println("startPage : " + startPage);

//ArrayList로 뿌려줄 쿼리
ArrayList<HashMap<String, Object>> selectAvailablePlaneList = null; //조건에 부합하는 항공기 리스트
ArrayList<HashMap<String, Object>> selectAllFlightList = FlightDAO.selectAllFlightList(); //모든 항공편 정보 출력
ArrayList<HashMap<String, Object>> selectAllRouteCityCountryList = RouteDAO.selectAllRouteCityCountryList(); //모든 노선 정보 출력 - 해당 노선과 조인된 테이블의 관련정보까지 추출
ArrayList<HashMap<String, Object>> selectOneRouteCityCountryList = null; //특정 하나의 노선 정보 출력
ArrayList<HashMap<String, Object>> selectAllRouteCityCountryListSearchFirst = null; //모든 노선 정보 출력-항공편에 해당하는 노선을 최상단에 위치
ArrayList<HashMap<String, Object>> selectRouteInfo = null; //항공편에 해당하는 노선정보 출력

//항공편 운항상태를 시스템적으로 변경해주는 쿼리 - 현재 시각을 기준으로 '이륙전,운항중,운항종료'로 상태변경
int updateFlightStatusBeforeTakeOff = FlightDAO.updateFlightStatusBeforeTakeOff();
int updateFlightStatusInOperation = FlightDAO.updateFlightStatusInOperation();
int updateFlightStatusEnded = FlightDAO.updateFlightStatusEnded();

//항공편이 존재한다면 항공편에 해당하는 노선정보 출력
if (request.getParameter("flightId") != null) {
	selectRouteInfo = FlightDAO.selectRouteInfo(flightId);
}

//항공편 생성 위해 항공기 조회에 성공했을 시 (flightManagePlaneSearchAction.jsp 페이지에서) selectAvailablePlaneList 를  ArrayList에 담는다
if (request.getParameter("planeList") != null) {
	if (planeList.equals("1")) {
		selectAvailablePlaneList = FlightDAO.selectAvailablePlaneList(date, time, flightDuration);
		selectOneRouteCityCountryList = RouteDAO.selectOneRouteCityCountryList(intRouteId); //특정 하나의 노선 정보 출력
	}
}

//항공편 수정 위해 항공기 조회에 성공했을 시 (flightManagePlaneSearchAction.jsp 페이지에서) selectAvailablePlaneList 를  ArrayList에 담는다
if (request.getParameter("modifyPlaneList") != null) {
	if (modifyPlaneList.equals("1")) {
		selectAvailablePlaneList = FlightDAO.selectAvailablePlaneList(date, time, flightDuration);
		selectOneRouteCityCountryList = RouteDAO.selectOneRouteCityCountryList(intRouteId); //특정 하나의 노선 정보 출력
	}
}

//항공편을 검색했을때 노선특정에 성공한 경우 해당하는 전체노선을 출력하되 해당하는 항공편의 노선을 최상단에 위치하는 쿼리 실행
if (request.getParameter("checkRoute") != null) {
	selectAllRouteCityCountryListSearchFirst = RouteDAO.selectAllRouteCityCountryListSearchFirst(flightId);
}

//노선 전체행수 담을 변수
int totalRouteCount = 0;

//전체 항공편 행수(count함수) 출력위한 쿼리 
ArrayList<HashMap<String, Object>> selectTotalFlightList = FlightDAO.selectTotalFlightList();

for (HashMap<String, Object> a : selectTotalFlightList) {
	totalRouteCount = (Integer) (a.get("cnt"));
}

System.out.println("totalRouteCount :" + totalRouteCount);

totalRow = totalRouteCount;

//페이지네이션
// 전체행수가 로우퍼페이지 수로 나눠도 나머지가 남을 때 전체페이지에 +1 해준다
if (totalRow % rowPerPage != 0) {
	totalPage = totalRow / rowPerPage + 1;
	// 전체행수가 로우퍼페이지 수에 딱 떨어지는 수일 때 전체페이지에 +1 해준다
} else {
	totalPage = totalRow / rowPerPage;
}

//페이지네이션 디버깅
System.out.println("totalRow : " + totalRow);
System.out.println("rowPerPage : " + rowPerPage);
System.out.println("totalPage : " + totalPage);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>flightManage</title>
</head>
		<body>
			<h1>항공편DB관리</h1>
			<div>
				<!-- ////////////////////////항공편 입력(INSERT)//////////////////////// -->
	<%		//조건에 부합하는 항공기가 조회되었을 경우 노선목록과 캘린더에 기입력된 데이터(노선, 날짜) 출력
				if (request.getParameter("planeList") != null && planeList.equals("1")) {
	%>
				
					<select name="intRouteId">
	<%				//목록에 뿌려질 선택된 노선-도시-국가 리스트
						for (HashMap<String, Object> m3 : selectOneRouteCityCountryList) {
							String routeId = null;
							String departureCity = null;
							String arrivalCity = null;
							String departureCountry = null;
							String arrivalCountry = null;
							String departureAirport = null;
							String arrivalAirport = null;
							intRouteId = 0;
		
							intRouteId = (Integer) (m3.get("intRouteId"));
							routeId = (String) (m3.get("routeId"));
							departureCity = (String) (m3.get("departureCity"));
							arrivalCity = (String) (m3.get("arrivalCity"));
							departureCountry = (String) (m3.get("departureCountry"));
							arrivalCountry = (String) (m3.get("arrivalCountry"));
							departureAirport = (String) (m3.get("departureAirport"));
							arrivalAirport = (String) (m3.get("arrivalAirport"));
	%>
						<option value="<%=intRouteId%>"><%=routeId%>///<%=departureCity%>/<%=departureCountry%>/<%=departureAirport%>---<%=arrivalCity%>/<%=arrivalCountry%>/<%=arrivalAirport%></option>
	<%
						}
	%>			<!-- 출발날짜 설정 datetime-local타입 -->
					</select> <input type="datetime-local" name="datetimeString"
						value="<%=datetimeString%>" disabled>
					<button>항공기 조회</button>
				
	<%
				} else {
	%>		<!-- 항공기 조회 버튼 누르기 이전 조건에 부합하기 위한 항공기 선택페이지로 이동하기 위해 노선과 출발날짜 선택하는 폼 -->
				<form action="/D_airline/emp/flightManagePlaneSearchAction.jsp"
					method="post">
					<select name="intRouteId">
	<%				//목록에 뿌려질 모든 노선-도시-국가 리스트 출력
						for (HashMap<String, Object> m3 : selectAllRouteCityCountryList) {
							String routeId = null;
							String departureCity = null;
							String arrivalCity = null;
							String departureCountry = null;
							String arrivalCountry = null;
							String departureAirport = null;
							String arrivalAirport = null;
							intRouteId = 0;
		
							intRouteId = (Integer) (m3.get("intRouteId"));
							routeId = (String) (m3.get("routeId"));
							departureCity = (String) (m3.get("departureCity"));
							arrivalCity = (String) (m3.get("arrivalCity"));
							departureCountry = (String) (m3.get("departureCountry"));
							arrivalCountry = (String) (m3.get("arrivalCountry"));
							departureAirport = (String) (m3.get("departureAirport"));
							arrivalAirport = (String) (m3.get("arrivalAirport"));
	%>
						<option value="<%=intRouteId%>"><%=routeId%>///<%=departureCity%>/<%=departureCountry%>/<%=departureAirport%>---<%=arrivalCity%>/<%=arrivalCountry%>/<%=arrivalAirport%></option>
	<%
						}
	%>			<!-- 출발날짜 설정 datetime-local 타입-->
					</select> <input type="datetime-local" name="datetimeString">
					<button>항공기 조회</button>
				</form>
	<%
				}
	%>
				<!-- 노선과 출발날짜 , 항공기과 완전히 세팅이 되면 항공편 입력(insert)위한 액션페이지로 이동 -->
				<form method="post" action="/D_airline/emp/flightManageAddAction.jsp">
					<select name="planeId">
	<%				//selectAvailablePlaneList 조건에 부합하는 항공기가 있는지 조회하는 쿼리가 실행되었을 경우.
						//사용가능한 항공기 리스트를 목록에 뿌려준다.
						if (selectAvailablePlaneList != null && !selectAvailablePlaneList.isEmpty()
								&& request.getParameter("planeList") != null) {
							for (HashMap<String, Object> m2 : selectAvailablePlaneList) {
								int planeId = 0;
								String planeName = null;
								String stringPlaneId = null;
		
								stringPlaneId = (String) (m2.get("stringPlaneId"));
								planeId = (int) (m2.get("planeId"));
								planeName = (String) (m2.get("planeName"));
	%>
						<option value="<%=planeId%>"><%=stringPlaneId%>/<%=planeName%></option>
	<%
							}
						}
	%>
					</select>
					<!--  hidden값으로 routeId와 datetimeString(시간값 db에 넣기전 가공이 필요한 날짜데이터) --> 
					<input type="hidden" name="intRouteId" value="<%=intRouteId%>">
					<input type="hidden" name="datetimeString" value="<%=datetimeString%>"> 
					<input type="hidden" name="flightDuration" value="<%=flightDuration%>">
					<button type="submit">항공편입력</button>
				</form>
			</div>

			<!-- ////////////////////////////////항공편 수정(UPDATE)/////////////////////////////// -->
			<div>
				<!-- 항공편 검색 폼 -->
				<!-- 항공편 수정위해 제일 처음 진행하는 프로세스 -->
				<!--  일단 먼저 항공편을 입력하여 해당하는 항공편 정보가 있는지 확인하는 작업 -->
				<!--  해당하는 항공편이 있다면 해당된 노선,도시,국가,항공기 정보를 가져와서 뿌려줌 disabled -->
				<form action="/D_airline/emp/flightManageSearchFlight.jsp" method="post">
	<%
					// checkRoute 값이 "1"인지 확인하고 이에 따라 flightId 입력 필드를 설정
					//--이미 항공편을 검색했다면 비활성화, 검색하기 전이라면 항공편 입력창 활성화 분기
					//이미 항공편을 검색했다면 비활성화
					if (request.getParameter("checkRoute") != null && checkRoute.equals("1")) {
	%>
					<input type="number" name="flightId"
						placeholder="search flight ID(FL)" value="<%=flightId%>" disabled>
	<%
					//항공편을 수정하기 위해 항공편을 검색하기 전이라면 항공편 입력창 활성화
					} else {
	%>
					<input type="number" name="flightId" placeholder="search flight ID(FL)">
	<%
					}
	%>
					<button type="submit">항공편 검색</button>
				</form>

	<%
				// 항공편 검색 후 checkRoute 값이 "1"인 경우 -- 이미 항공편 검색을 마친 상태이며
				// 노선과 출발날짜를 변경한 상태에서 변경된 조건에 부합하는 항공기를 조회하기 위한 폼
				if (request.getParameter("checkRoute") != null && checkRoute.equals("1")) {
	%>
				<!-- 항공편 수정 페이지에서 항공기 조회를 위한 액션 페이지로 이동 -->
				<form	action="/D_airline/emp/flightManageModifiedPlaneSearchAction.jsp" 	method="post">
					<select name="intRouteId">
	<%
						// 검색된 모든 항공편 정보를 select 옵션으로 제공
						for (HashMap<String, Object> m3 : selectAllRouteCityCountryListSearchFirst) {
							String routeId = (String) m3.get("routeId");
							String departureCity = (String) m3.get("departureCity");
							String arrivalCity = (String) m3.get("arrivalCity");
							String departureCountry = (String) m3.get("departureCountry");
							String arrivalCountry = (String) m3.get("arrivalCountry");
							String departureAirport = (String) m3.get("departureAirport");
							String arrivalAirport = (String) m3.get("arrivalAirport");
							intRouteId = (Integer) m3.get("intRouteId");
	%>
						<option value="<%=intRouteId%>">
							<%=routeId%>///<%=departureCity%>/<%=departureCountry%>/<%=departureAirport%>
							---<%=arrivalCity%>/<%=arrivalCountry%>/<%=arrivalAirport%>
						</option>
	<%
						}
	%>
					</select> <input type="hidden" name="flightId" value="<%=flightId%>">
					<input type="hidden" name="checkRoute" value="<%=checkRoute%>">
					<input type="datetime-local" name="datetimeString"
						value="<%=departureTimeLocal%>">
					<button>항공기 조회</button>
		
	<%
					for (HashMap<String, Object> m4 : selectRouteInfo) {
						String planeName = (String) (m4.get("planeName"));
	%>				<input type="text" value="PL<%=flightId%>/<%=planeName%>" disabled>
	<%
					}
	%>
		

				</form>
		
	<%
				//항공기 조회 후 modifyPlaneList 값이 "1"인 경우
				} else if (request.getParameter("modifyPlaneList") != null && modifyPlaneList.equals("1")) {
				%>
				<input type="text" value="FL<%=flightId%>" disabled> <select
					disabled>
	<%
					// 검색된 모든 항공편 정보를 select 옵션으로 제공
					for (HashMap<String, Object> m3 : selectOneRouteCityCountryList) {
						String routeId = (String) m3.get("routeId");
						String departureCity = (String) m3.get("departureCity");
						String arrivalCity = (String) m3.get("arrivalCity");
						String departureCountry = (String) m3.get("departureCountry");
						String arrivalCountry = (String) m3.get("arrivalCountry");
						String departureAirport = (String) m3.get("departureAirport");
						String arrivalAirport = (String) m3.get("arrivalAirport");
						intRouteId = (Integer) m3.get("intRouteId");
	%>
					<option>
						<%=routeId%>///<%=departureCity%>/<%=departureCountry%>/<%=departureAirport%>
						---<%=arrivalCity%>/<%=arrivalCountry%>/<%=arrivalAirport%>
					</option>
	<%
					}
	%>
				</select> <input type="datetime-local" value="<%=datetimeString%>" disabled>
		
				<form method="post"
					action="/D_airline/emp/flightManageModifyAction.jsp">
					<select name="planeId">
	<%
						// 사용 가능한 항공기가 있는 경우 select 옵션으로 제공
						if (selectAvailablePlaneList != null && !selectAvailablePlaneList.isEmpty()
								&& request.getParameter("modifyPlaneList") != null) {
							for (HashMap<String, Object> m2 : selectAvailablePlaneList) {
								int planeId = 0;
								String planeName = null;
								String stringPlaneId = null;
		
								stringPlaneId = (String) m2.get("stringPlaneId");
								planeId = (int) m2.get("planeId");
								planeName = (String) m2.get("planeName");
	%>
						<option value="<%=planeId%>"><%=stringPlaneId%>/<%=planeName%></option>
	<%
							}
						}
	%>
					</select> <input type="hidden" name="flightId" value="<%=flightId%>">
					<input type="hidden" name="intRouteId" value="<%=intRouteId%>">
					<input type="hidden" name="datetimeString"
						value="<%=datetimeString%>"> <input type="hidden"
						name="flightDuration" value="<%=flightDuration%>">
					<button type="submit">항공편수정</button>
				</form>
	<%
				}
	%>
			</div>
		
		
			<!-- ////항공편 삭제///// -->
			<form action="/D_airline/emp/flightManageDeleteAction.jsp"
				method="post">
				<div>
					<input type="number" name="flightId" placeholder="flight id(FL)"
						required>
					<button type="submit">항공편삭제</button>
				</div>
			</form>
		
			<div>
				<%=msg%>
				<table class="">
					<thead class="">
						<tr>
							<th>항공편코드</th>
							<th>행선지</th>
							<th>노선코드</th>
							<th>출발시각</th>
							<th>도착시각</th>
							<th>운항시간</th>
							<th>항공기명</th>
							<th>status</th>
							<th>변경일자</th>
							<th>생성일자</th>
						</tr>
					</thead>
					<tbody>
	<%
						for (HashMap<String, Object> m3 : selectAllFlightList) {
							String routeId = null;
							String departureCity = null;
							String arrivalCity = null;
							String departureCountryName = null;
							String arrivalCountryName = null;
		
							routeId = (String) (m3.get("routeId"));
							departureCity = (String) (m3.get("departureCity"));
							arrivalCity = (String) (m3.get("arrivalCity"));
							departureCountryName = (String) (m3.get("departureCountryName"));
							arrivalCountryName = (String) (m3.get("arrivalCountryName"));
	%>
						<tr>
							<td><%=(String) (m3.get("flightId"))%></td>
							<td><%=departureCity%>/<%=departureCountryName%>---<%=arrivalCity%>/<%=arrivalCountryName%></td>
							<td><%=routeId%></td>
							<td><%=(String) (m3.get("departureTime"))%></td>
							<td><%=(String) (m3.get("arrivalTime2"))%></td>
							<td><%=(String) (m3.get("flightDuration"))%></td>
							<td><%=(String) (m3.get("planeName"))%></td>
							<td><%=(String) (m3.get("status"))%></td>
							<td><%=(String) (m3.get("updateDate"))%></td>
							<td><%=(String) (m3.get("createDate"))%></td>
						</tr>
	<%
						}
	%>
					</tbody>
				</table>
			</div>
		</body>
</html>
