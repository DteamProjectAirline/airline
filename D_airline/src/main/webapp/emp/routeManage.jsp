<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import = "dao.*" %>
<%@ page import="java.net.*" %>

<%
	System.out.println("----------routeManage.jsp----------");
	System.out.println("세션 ID: " + session.getId());

String msg = null;


	if (session.getAttribute("loginAd") == null){
	System.out.println("관리자만 접근 가능한 페이지입니다.");
	msg = URLEncoder.encode("관리자만 접근 가능한 페이지입니다.","UTF-8");
		response.sendRedirect("/D_airline/customer/flightMain.jsp?msg="+msg);
	return;
}


System.out.println("[param]rowPerPage : " + request.getParameter("rowPerPage"));
System.out.println("[param]currentPage : " + request.getParameter("currentPage"));
System.out.println("[param]msg : " + request.getParameter("msg"));

if (request.getParameter("msg") != null) {
	msg = request.getParameter("msg");
	System.out.println("msg : " + msg);
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


//ArrayList<HashMap<String, Object>> selectRouteList = RouteDAO.selectRouteList(startPage, rowPerPage);
//ArrayList<HashMap<String, Object>> selectAllRouteList = RouteDAO.selectAllRouteList();
ArrayList<HashMap<String, Object>> selectAllRouteCityCountryList = RouteDAO.selectAllRouteCityCountryList();
ArrayList<HashMap<String, Object>> selectAllCityList = CityDAO.selectAllCityList();


//System.out.println("selectRouteList(routeManage.jsp페이지) : "+selectRouteList);
//System.out.println("selectRouteList(routeManage.jsp페이지) : "+selectAllRouteList);
System.out.println("selectRouteCityCountryList : "+selectAllRouteCityCountryList);

int totalRouteCount = 0;

ArrayList<HashMap<String, Object>> selectTotalRouteList  = RouteDAO.selectTotalRouteList();

for(HashMap<String, Object> a : selectTotalRouteList) {

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
	<title>routeManage</title>
</head>
	<body>
		<h1>노선DB관리</h1>
		<form action = "/D_airline/emp/routeManageAddAction.jsp" method="post">
			<div>
			
			<select name="departureCity">
			<%
			for(HashMap<String, Object> m2 : selectAllCityList) {
				
				String cityName = null;
				String countryName = null;
				String airport = null;
				
				
				cityName = (String)(m2.get("cityName"));
				countryName = (String)(m2.get("countryName"));
				airport = (String)(m2.get("airport"));
				
				
				%>
				<option value="<%= cityName%>"><%= cityName%>/<%=countryName %>/<%=airport %></option>
				
			<%	} %>
			</select>
			
				<select name="arrivalCity">
			<%
			for(HashMap<String, Object> m2 : selectAllCityList) {
				
				String cityName = null;
				String countryName = null;
				String airport = null;
				
				
				cityName = (String)(m2.get("cityName"));
				countryName = (String)(m2.get("countryName"));
				airport = (String)(m2.get("airport"));
				
				
				%>
				<option value="<%= cityName%>"><%= cityName%>/<%=countryName %>/<%=airport %></option>
				
			<%	} %>
			</select>
			
			
			
			<input type="number" name ="basefare" placeholder="항공노선 기본 책정 운임" required>
				<label>운항시간 : </label>
				
				
				<select id="hour" name = "hour">
		<% 
		for(int i=0; i <24; i++){
		%>
		<option value="<%=i%>"><%=i %></option>
		<% }%>
	</select>
		<label for ="hour">시간&nbsp;</label>
		
		
	<select id="minute" name="minute">
		
		<%
		for(int i=0; i<12; i++){
			String e = Integer.toString(i*5);
			if(e.length() !=2){
				e = "0"+e;
			}
		%>
		
		<option value="<%=e%>"><%=e %></option>
		<%} %>

	
		
		
		
	</select>
	<label for ="minute">분</label>
				<button type="submit">노선입력</button>
			</div>
		</form>
		
		<form action = "/D_airline/emp/routeManageModifyAction.jsp" method="post">
			<div>
				<input type="text" name ="countryName" placeholder="country name" required>
				<input type="number" name ="countryId" placeholder="country id(NA)" required>
				<button type="submit">노선정보수정</button>
			</div>
		</form>
		
		<form action = "/D_airline/emp/routeManageDeleteAction.jsp" method="post">
			<div>
				<input type="text" name ="routeId" placeholder="route id" required>
		
				<button type="submit">노선삭제</button>
			</div>
		</form>
		
		
		
			<div>
				<%=msg %>
				<table class="">
					<thead class="" >
						<tr>
							<th>노선코드</th>
							<th>출발도시</th>
							<th>도착도시</th>
							<th>출발국가</th>
							<th>도착국가</th>
							<th>출발공항</th>
							<th>도착공항</th>
							<th>노선기본책정운임</th>
							<th>운항시간</th>
							<th>변경일자</th>
							<th>생성일자</th>
					
						</tr>
					</thead>
					<tbody>
	<%					
						for(HashMap<String, Object> m3 : selectAllRouteCityCountryList) {
							
							String hour = null;
							String minute = null;
							
							if((String)(m3.get("hour"))==null || (String)(m3.get("minute"))==null){
								
							}else if((String)(m3.get("hour"))!=null && (String)(m3.get("minute"))!=null){
								hour = (String)(m3.get("hour"));
								minute = (String)(m3.get("minute"));
								
								
								
								if(minute.length()!=2){
									minute = "0" + minute;
								}
								
							}
							
							
	%>
							<tr>
								<td><%=(String)(m3.get("routeId"))%></td>
								<td><%=(String)(m3.get("departureCity"))%></td>
								<td><%=(String)(m3.get("arrivalCity"))%></td>
								<td><%=(String)(m3.get("departureCountry"))%></td>
								<td><%=(String)(m3.get("arrivalCountry"))%></td>
								<td><%=(String)(m3.get("departureAirport"))%></td>	
								<td><%=(String)(m3.get("arrivalAirport"))%></td>
								<td><%=(String)(m3.get("basefare"))%></td>
								<%
								
								if((String)(m3.get("hour"))==null || (String)(m3.get("minute"))==null){
									
								}else if((String)(m3.get("hour"))!=null && (String)(m3.get("minute"))!=null){
									
									if(hour.equals("0")){
									%>	<td><%=minute+"분"%></td>
								<% 	}else{
									%> <td><%=hour+"시간 "+minute+"분"%></td>
							<% 	}}
								%>
								
								<td><%=(String)(m3.get("updateDate"))%></td>
								<td><%=(String)(m3.get("createDate"))%></td>
									
								<td><%=(String)(m3.get("departureCountryId"))%></td>	
								<td><%=(String)(m3.get("arrivalCountryId"))%></td>
												
						
							</tr>
					</tbody>
	<%		
						}
	%>
				</table>
			</div>
		
		
		
	</body>
</html>