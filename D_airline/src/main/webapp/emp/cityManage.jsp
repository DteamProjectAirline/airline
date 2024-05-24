<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import = "kjwdao.*" %>
<%@ page import="java.net.*" %>

<%
	System.out.println("----------cityManage.jsp----------");

	System.out.println("세션 ID: " + session.getId());

	String msg = null;
	

	//세션 로그인 주입
	if (session.getAttribute("loginAd") == null){
		System.out.println("관리자만 접근 가능한 페이지입니다.");
		msg = URLEncoder.encode("관리자만 접근 가능한 페이지입니다.","UTF-8");
		response.sendRedirect("/D_airline/customer/flightMain.jsp?msg="+msg);
	return;
	}

	HashMap<String,Object> m = new HashMap<>();

	//변수할당
	m = (HashMap<String,Object>)(session.getAttribute("loginAd"));

	String adminId = null;
	String hireDate = null;
	String post = null;
	String type = null;

	m.put("type","admin");

	//해쉬맵 변수 스트링변수에 할당
	adminId = (String)(m.get("adminId"));
	hireDate = (String)(m.get("hireDate"));
	post = (String)(m.get("post"));
	type = (String)(m.get("type"));

	//세션 변수 디버깅
	System.out.println(session.getAttribute("loginAd"));
	System.out.println("adminId : "+adminId);
	System.out.println("hireDate : "+hireDate);
	System.out.println("post : "+post);


	//페이징 매개변수 디버깅
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
	

	
	int totalCityCount = 0;
	
	//city테이블 전체 도시 행수 추출용 쿼리
	ArrayList<HashMap<String, Object>> selectTotalCityList  = CityDAO.selectTotalCityList();
	//모든 국가 리스트 출력
	ArrayList<HashMap<String, Object>> selectAllCountryList = CountryDAO.selectAllCountryList();
	//모든 도시 리스트 행수 제한
	ArrayList<HashMap<String, Object>> selectCityList = CityDAO.selectCityList(startPage, rowPerPage);
	//모든 도시 리스트
	ArrayList<HashMap<String, Object>> selectAllCityList = CityDAO.selectAllCityList();
	
	
	System.out.println("selectTotalCityList : "+selectTotalCityList);
	System.out.println("selectAllCountryList : "+selectAllCountryList);
	System.out.println("selectCityList  :" +selectCityList);
	System.out.println("selectAllCityList : "+selectAllCityList);
	
	//city테이블 전체 도시 행수 추출 변수 주입
	for(HashMap<String, Object> a : selectTotalCityList) {
	
		totalCityCount = (Integer)(a.get("cnt"));
		
	}
	
	System.out.println("totalCityCount :" +totalCityCount );
	
			totalRow = totalCityCount;
	
	
	
	//전체행수가 로우퍼페이지 수로 나눠도 나머지가 남을 때 전체페이지에 +1 해준다
	if (totalRow % rowPerPage != 0) {
		totalPage = totalRow / rowPerPage + 1;
	//전체행수가 로우퍼페이지 수에 딱 떨어지는 수일 때 전체페이지에 +1 해준다
	} else {
		totalPage = totalRow / rowPerPage;
	}
	

	
	//페이징 변수 디버깅
	System.out.println("totalRow : " + totalRow);
	System.out.println("rowPerPage : " + rowPerPage);
	System.out.println("totalPage : " + totalPage);


%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>cityManage</title>
</head>
	<body>
		<h1>도시DB관리</h1>
		
		<!-- 도시입력 insert 기능-->
		<form action = "/D_airline/emp/cityManageAddAction.jsp" method="post">
			<div>
				<input type="text" name ="cityName" placeholder="city name" required>
					<label for="nation">국가</label>
					<select name ="countryId" id="nation">
	<% 				//목록에 뿌려줄 모든 국가리시트 출력	
						for(HashMap<String, Object> a : selectAllCountryList) {
		
							String countryName = null;
							String countryId = null;
							String countryIdNo = null;
							
							countryName = (String)(a.get("countryName"));
							countryIdNo = (String)(a.get("countryIdNo"));
							countryId = (String)(a.get("countryId"));
							
	%>
							<option value="<%=countryIdNo%>"><%=countryName %>/<%=countryId %></option>
					
					
	<%				}
	%>
				</select>
				
				<input type="text" name ="airport" placeholder="airport" required>
				<button type="submit">도시입력</button>
			</div>
		</form>
		
		<!-- 도시 정보 수정 update 기능 -->
		<form action = "/D_airline/emp/cityManageModifyAction.jsp" method="post">
			<div>
				<input type="text" name ="cityName" placeholder="city name" required>
				<label for="nation">국가</label>
				<select name ="countryId" id="nation">
	<% 			//목록에 뿌려줄 모든 국가리시트 출력	
					for(HashMap<String, Object> a : selectAllCountryList) {
	
						String countryName = null;
						String countryId = null;
						String countryIdNo = null;
						
						countryName = (String)(a.get("countryName"));
						countryIdNo = (String)(a.get("countryIdNo"));
						countryId = (String)(a.get("countryId"));
						
	%>
						<option value="<%=countryIdNo%>"><%=countryName %>/<%=countryId %></option>
						
						
	<%			}
	%>
				</select>
				<input type="text" name ="airport" placeholder="airport" required>
					<label for="city">변경도시이름</label>
   				<input type="text" id="city" name="keyCityName" list="keyCityName" required>
				<datalist id="keyCityName" >
	<%					
						for(HashMap<String, Object> m2 : selectAllCityList) {
						
	%>					<option value="<%=(String)(m2.get("cityName"))%>"><%=(String)(m2.get("cityName"))%></option>
	<%				}
	%>
				</datalist>
				
				<button type="submit">도시정보수정</button>
			</div>
		</form>
		
		<!-- 도시 삭제 delete 기능 -->
		<form action = "/D_airline/emp/cityManageDeleteAction.jsp" method="post">
			<div>
				<input type="text" name ="cityName" placeholder="city name" required>
		
				<button type="submit">도시삭제</button>
			</div>
		</form>
			<div>
				
				<!-- 기능 수행 결과에 대한 메세지값 -->
				<%=msg %>
				
				<table class="">
					<thead class="" >
						<tr>
							<th>도시명</th>
							<th>공항명</th>
							<th>국가명</th>
							<th>국가코드</th>
							<th>변경일자</th>
							<th>생성일자</th>
					
						</tr>
					</thead>
					<tbody>
	<%					
						for(HashMap<String, Object> m2 : selectAllCityList) {
	%>
							<tr>
								<td><%=(String)(m2.get("cityName"))%></td>
								<td><%=(String)(m2.get("airport"))%></td>
								<td><%=(String)(m2.get("countryName"))%></td>
								<td><%=(String)(m2.get("countryId"))%></td>
								<td><%=(String)(m2.get("updateDate"))%></td>
								<td><%=(String)(m2.get("createDate"))%></td>
					
							</tr>
					</tbody>
	<%		
						}
	%>
				</table>
			</div>

	</body>
</html>