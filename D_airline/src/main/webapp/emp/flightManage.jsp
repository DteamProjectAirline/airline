<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import = "dao.*" %>
<%@ page import="java.net.*" %>

<%
	System.out.println("----------flightManage.jsp----------");
	System.out.println("세션 ID: " + session.getId());

String msg = null;
String date = null;
String hour = null;
String minute = null;
String flightDuration = null;
String time = null;
String planeList = null;
int intRouteId = 0;
String datetimeString = null;



	if (session.getAttribute("loginAd") == null){
	System.out.println("관리자만 접근 가능한 페이지입니다.");
	msg = URLEncoder.encode("관리자만 접근 가능한 페이지입니다.","UTF-8");
		response.sendRedirect("/D_airline/customer/flightMain.jsp?msg="+msg);
	return;
}


System.out.println("[param]rowPerPage : " + request.getParameter("rowPerPage"));
System.out.println("[param]currentPage : " + request.getParameter("currentPage"));
System.out.println("[param]date : " + request.getParameter("date"));
System.out.println("[param]hour : " + request.getParameter("hour"));
System.out.println("[param]minute : " + request.getParameter("minute"));
System.out.println("[param]flightDuration : " + request.getParameter("flightDuration"));
System.out.println("[param]intRouteid : " + request.getParameter("intRouteId"));
System.out.println("[param]datetimeString : " + request.getParameter("datetimeString"));
System.out.println("[param]planeList : " + request.getParameter("planeList"));


if (request.getParameter("msg") != null) {
	msg = request.getParameter("msg");
	System.out.println("msg : " + msg);
}

if (request.getParameter("date") != null) {
	date = request.getParameter("date");
	System.out.println("date : " + date);
}

if (request.getParameter("hour") != null) {
	hour = request.getParameter("hour");
	System.out.println("hour : " + hour);
}

if (request.getParameter("minute") != null) {
	minute = request.getParameter("minute");
	System.out.println("minute : " + minute);
}

if (request.getParameter("flightDuration") != null) {
	flightDuration = request.getParameter("flightDuration");
	System.out.println("flightDuration : " + flightDuration);
}

if (request.getParameter("intRouteId") != null) {
	intRouteId = Integer.parseInt(request.getParameter("intRouteId"));
	System.out.println("intRouteId : " + intRouteId);
}

if (request.getParameter("datetimeString") != null) {
	datetimeString = request.getParameter("datetimeString");
	System.out.println("datetimeString : " + datetimeString);
}

if (request.getParameter("planeList") != null) {
	planeList = request.getParameter("planeList");
	System.out.println("planeList : " + planeList);
}






//전체행수 검색 변수설정 ------------------------
int totalRow = 0;			//조회쿼리 전체행수
int rowPerPage = 10; 		//페이지당 행수
int totalPage = 1;			//전체 페이지수

int currentPage = 1;		//현재 페이지수
int startPage = 0;		//시작행

int startRow = (currentPage-1)*rowPerPage;


System.out.println("totalRow : " + totalRow);
System.out.println("rowPerPage : " + rowPerPage);
System.out.println("totalRow % rowPerPage : " + totalRow % rowPerPage);
System.out.println("totalPage : " + totalPage);
//현재 페이지 값이 넘어왔을 때 커런트 페이지 값을 넘겨받는다
if (request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
	System.out.println("currentPage : " + currentPage);
}
//로우퍼 페이지 값이 넘어왔을때 로우퍼 페이지 값을 넘겨받는다
if (request.getParameter("rowPerPage") != null) {
	rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	System.out.println("rowPerPage : " + rowPerPage);
}
//limit쿼리 시작행수는 현재 페이지에 1을 뺀 수에서 로우퍼페이지를 곱을 한 값이다
startPage = (currentPage - 1) * rowPerPage;
System.out.println("startPage : " + startPage);


//ArrayList<HashMap<String, Object>> selectAllCityList = CityDAO.selectAllCityList();
ArrayList<HashMap<String, Object>> selectAvailablePlaneList = null;

ArrayList<HashMap<String, Object>> selectAllFlightList = FlightDAO.selectAllFlightList();

ArrayList<HashMap<String, Object>> selectAllRouteCityCountryList = RouteDAO.selectAllRouteCityCountryList();
ArrayList<HashMap<String, Object>> selectOneRouteCityCountryList = null;

if(request.getParameter("planeList")!=null){
	

if(planeList.equals("1")){
	
selectOneRouteCityCountryList = RouteDAO.selectOneRouteCityCountryList(intRouteId);
}
}
if(request.getParameter("planeList") != null){
	selectAvailablePlaneList =  FlightDAO.selectAvailablePlaneList(date, time, flightDuration);
}



System.out.println("selectAllFlightList : "+selectAllFlightList);
System.out.println(" selectAllRouteCityCountryList : "+ selectAllRouteCityCountryList);
System.out.println(" selectOneRouteCityCountryList : "+ selectOneRouteCityCountryList);

int totalRouteCount = 0;

ArrayList<HashMap<String, Object>>  selectTotalFlightList  = FlightDAO. selectTotalFlightList();

for(HashMap<String, Object> a : selectTotalFlightList) {

	totalRouteCount = (Integer)(a.get("cnt"));
	
}

System.out.println("totalRouteCount :" +totalRouteCount );

		totalRow = totalRouteCount;



//전체행수가 로우퍼페이지 수로 나눠도 나머지가 남을 때 전체페이지에 +1 해준다
if (totalRow % rowPerPage != 0) {
	totalPage = totalRow / rowPerPage + 1;
//전체행수가 로우퍼페이지 수에 딱 떨어지는 수일 때 전체페이지에 +1 해준다
} else {
	totalPage = totalRow / rowPerPage;
}

//세션 변수 loginEmp값 받을 HashMap 변수 m 생성
HashMap<String,Object> m = new HashMap<>();

//변수할당
m = (HashMap<String,Object>)(session.getAttribute("loginAd"));

String adminId = null;
String hireDate = null;
String post = null;
String type = null;
//해쉬맵 변수 스트링변수에 할당
adminId = (String)(m.get("adminId"));
hireDate = (String)(m.get("hireDate"));
post = (String)(m.get("post"));
type = (String)(m.get("type"));


System.out.println(session.getAttribute("loginAd"));
System.out.println("adminId : "+adminId);
System.out.println("hireDate : "+hireDate);
System.out.println("post : "+post);

System.out.println("totalRow : " + totalRow);
System.out.println("rowPerPage : " + rowPerPage);
System.out.println("totalPage : " + totalPage);

m.put("type","admin");




%>





<% 






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
		
		<%
			
			if(request.getParameter("planeList")!=null && planeList.equals("1") ){
				
				%>
				
				<form action = "/D_airline/emp/flightManageAddAction.jsp" method="post">
			
			
			<select name="intRouteId">
			<%
			
			
			
			for(HashMap<String, Object> m3 : selectOneRouteCityCountryList) {
				
				String routeId = null;
				String departureCity = null;
				String arrivalCity = null;
				String departureCountry = null;
				String arrivalCountry = null;
				String departureAirport = null;
				String arrivalAirport = null;
				intRouteId = 0;
				
				intRouteId = (Integer)(m3.get("intRouteId"));
				routeId = (String)(m3.get("routeId"));
				departureCity = (String)(m3.get("departureCity"));
				arrivalCity = (String)(m3.get("arrivalCity"));
				departureCountry = (String)(m3.get("departureCountry"));
				arrivalCountry = (String)(m3.get("arrivalCountry"));
				departureAirport = (String)(m3.get("departureAirport"));
				arrivalAirport = (String)(m3.get("arrivalAirport"));
					
					
%>
					
						
						<option value="<%=intRouteId%>"><%=routeId%>///<%=departureCity%>/<%=departureCountry%>/<%=departureAirport%>---<%=arrivalCity%>/<%=arrivalCountry%>/<%=arrivalAirport%></option>
			
			
			
			
			
				
			<%	} %>
			</select>
				<input type="datetime-local" name ="datetimeString" value=<%=datetimeString %> disabled>
					<button>항공기 조회</button>
				</form>
				
				
				
		<%	}else{
			%>
			<form action = "/D_airline/emp/flightManagePlaneSearchAction.jsp" method="post">
			
			
			<select name="intRouteId">
			<%
			
			
			
			for(HashMap<String, Object> m3 : selectAllRouteCityCountryList) {
				
				String routeId = null;
				String departureCity = null;
				String arrivalCity = null;
				String departureCountry = null;
				String arrivalCountry = null;
				String departureAirport = null;
				String arrivalAirport = null;
				intRouteId = 0;
				
				intRouteId = (Integer)(m3.get("intRouteId"));
				routeId = (String)(m3.get("routeId"));
				departureCity = (String)(m3.get("departureCity"));
				arrivalCity = (String)(m3.get("arrivalCity"));
				departureCountry = (String)(m3.get("departureCountry"));
				arrivalCountry = (String)(m3.get("arrivalCountry"));
				departureAirport = (String)(m3.get("departureAirport"));
				arrivalAirport = (String)(m3.get("arrivalAirport"));
					
					
%>
					
						
						<option value="<%=intRouteId%>"><%=routeId%>///<%=departureCity%>/<%=departureCountry%>/<%=departureAirport%>---<%=arrivalCity%>/<%=arrivalCountry%>/<%=arrivalAirport%></option>
			
			
			
			
			
				
			<%	} %>
			</select>
				<input type="datetime-local" name ="datetimeString">
					<button>항공기 조회</button>
				</form>
	<%	}
		%>
		
				
				<form method="post" action="/D_airline/emp/flightManageAddAction.jsp">
				
	

	
	
	
		<select name="planeId">
	<%
	if (selectAvailablePlaneList != null && !(selectAvailablePlaneList.isEmpty()) ) {
			
		
	
		for(HashMap<String, Object> m2 : selectAvailablePlaneList) {
			
			int planeId = 0;
			String planeName = null;
			String stringPlaneId = null;
			
			stringPlaneId = (String)(m2.get("stringPlaneId"));
			planeId = (int)(m2.get("planeId"));
			planeName = (String)(m2.get("planeName"));
	
			
			%>
			<option value="<%=planeId%>"><%=stringPlaneId%>/<%=planeName%></option>
			
		<%	}} %>
		
		
		
		
	
	</select>
				<input type="hidden" name="intRouteId" value="<%=intRouteId%>">
				<input type="hidden" name="datetimeString" value="<%=datetimeString%>">
				<input type="hidden" name="flightDuration" value="<%=flightDuration%>">
				<button type="submit">항공편입력</button>
			
		</form>
		
		</div>
		<form action = "/D_airline/emp/flightManageModifyAction.jsp" method="post">
			<div>
				<input type="text" name ="countryName" placeholder="country name" required>
				<input type="number" name ="countryId" placeholder="country id(NA)" required>
				<button type="submit">항공편수정</button>
			</div>
		</form>
		
		<form action = "/D_airline/emp/flightManageDeleteAction.jsp" method="post">
			<div>
				<input type="number" name ="countryId" placeholder="country id(NA)" required>
		
				<button type="submit">항공편삭제</button>
			</div>
		</form>
		
		
			<div>
				<%=msg %>
				<table class="">
					<thead class="" >
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
						for(HashMap<String, Object> m3 : selectAllFlightList) {
							
						String routeId = null;
						String departureCity = null;
						String arrivalCity = null;
						String departureCountryName = null;
						String arrivalCountryName = null;
						
						routeId = (String)(m3.get("routeId"));
						departureCity = (String)(m3.get("departureCity"));
						arrivalCity = (String)(m3.get("arrivalCity"));
						departureCountryName = (String)(m3.get("departureCountryName"));
						arrivalCountryName = (String)(m3.get("arrivalCountryName"));
						
							
							
	%>
							<tr>
								<td><%=(String)(m3.get("flightId"))%></td>
								<td><%=departureCity%>/<%=departureCountryName%>---<%=arrivalCity%>/<%=arrivalCountryName%></td>
								<td><%=routeId%></td>
								<td><%=(String)(m3.get("departureTime"))%></td>
								<td><%=(String)(m3.get("arrivalTime2"))%></td>
								<td><%=(String)(m3.get("flightDuration"))%></td>
								<td><%=(String)(m3.get("planeName"))%></td>
								<td><%=(String)(m3.get("status"))%></td>	
								<td><%=(String)(m3.get("updateDate"))%></td>
								<td><%=(String)(m3.get("createDate"))%></td>
							
								
												
						
							</tr>
					</tbody>
	<%		
						}
	%>
				</table>
			</div>
		
		
		
	</body>
</html>