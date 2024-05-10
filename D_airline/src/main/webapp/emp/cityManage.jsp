<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import = "dao.*" %>
<%@ page import="java.net.*" %>

<%
	System.out.println("----------cityManage.jsp----------");
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


ArrayList<HashMap<String, Object>> selectCityList = CityDAO.selectCityList(startPage, rowPerPage);
ArrayList<HashMap<String, Object>> selectAllCityList = CityDAO.selectAllCityList();


//디버깅 ArrayList는 문자열 디버깅 가능-주소가 아닌 값이 나오기 때문에
//System.out.println("selectGoodsList(리스트에 추가된 칼럼명 목록) : "+selectGoodsList);
System.out.println("selectCityList(cityManage.jsp페이지) : "+selectCityList);


int totalCityCount = 0;
//city테이블 전체 도시 행수 추출용 쿼리
ArrayList<HashMap<String, Object>> selectTotalCityList  = CityDAO.selectTotalCityList();

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
	<title></title>
</head>
	<body>
		<form action = "/D_airline/emp/cityManageAddAction.jsp" method="post">
			<div>
				<input type="text" name ="cityName" placeholder="city name" required>
				<input type="text" name ="countryId" placeholder="country ID code" required>
				<input type="text" name ="airport" placeholder="airport" required>
				<button type="submit">도시입력</button>
			</div>
		</form>
		
		<form action = "/D_airline/emp/cityManageModifyAction.jsp" method="post">
			<div>
				<input type="text" name ="cityName" placeholder="city name" required>
				<input type="text" name ="countryId" placeholder="country ID code" required>
				<input type="text" name ="airport" placeholder="airport" required>
				<input type="text" name ="keyCityName" placeholder="keyCityName" required>
				<button type="submit">도시정보수정</button>
			</div>
		</form>
		
		<form action = "/D_airline/emp/cityManageDeleteAction.jsp" method="post">
			<div>
				<input type="text" name ="cityName" placeholder="city name" required>
		
				<button type="submit">도시삭제</button>
			</div>
		</form>
			<div>
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
	<%					//rs.getString이 아닌 HashMap으로 값을 뿌림
						for(HashMap<String, Object> m2 : selectAllCityList) {
	%>
							<tr>
								<td><%=(String)(m2.get("cityName"))%></td>
								<td><%=(String)(m2.get("airport"))%></td>
								<td><%=(String)(m2.get("countryName"))%></td>
								<td><%=(String)(m2.get("countryId"))%></td>
					
							</tr>
					</tbody>
	<%		
						}
	%>
				</table>
			</div>
		
		
		
	</body>
</html>