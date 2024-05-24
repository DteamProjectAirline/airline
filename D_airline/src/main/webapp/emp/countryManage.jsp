<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="kjwdao.*"%>
<%@ page import="java.net.*"%>

<%
System.out.println("----------countryManage.jsp----------");
System.out.println("세션 ID: " + session.getId());

String msg = null;

//세션 로그인 주입
if (session.getAttribute("loginAd") == null) {
	System.out.println("관리자만 접근 가능한 페이지입니다.");
	msg = URLEncoder.encode("관리자만 접근 가능한 페이지입니다.", "UTF-8");
	response.sendRedirect("/D_airline/customer/flightMain.jsp?msg=" + msg);
	return;
}

//세션 변수 loginEmp값 받을 HashMap 변수 m 생성
HashMap<String, Object> m = new HashMap<>();

//변수할당
m = (HashMap<String, Object>) (session.getAttribute("loginAd"));

String adminId = null;
String hireDate = null;
String post = null;
String type = null;
//해쉬맵 변수 스트링변수에 할당
adminId = (String) (m.get("adminId"));
hireDate = (String) (m.get("hireDate"));
post = (String) (m.get("post"));
type = (String) (m.get("type"));

m.put("type", "admin");

System.out.println(session.getAttribute("loginAd"));
System.out.println("adminId : " + adminId);
System.out.println("hireDate : " + hireDate);
System.out.println("post : " + post);


//페이지네이션 변수 파라미터값 디버깅
System.out.println("[param]rowPerPage : " + request.getParameter("rowPerPage"));
System.out.println("[param]currentPage : " + request.getParameter("currentPage"));
//변수 파라미터값 디버깅
System.out.println("[param]msg : " + request.getParameter("msg"));

if (request.getParameter("msg") != null) {
	msg = request.getParameter("msg");
	System.out.println("msg : " + msg);
}

//페이지네이션 관련 변수
int totalRow = 0; //조회쿼리 전체행수
int rowPerPage = 10; //페이지당 행수
int totalPage = 1; //전체 페이지수

int currentPage = 1; //현재 페이지수
int startPage = 0; //시작행

int startRow = (currentPage - 1) * rowPerPage; //시작행 row변수

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

System.out.println("totalRow : " + totalRow);
System.out.println("rowPerPage : " + rowPerPage);
System.out.println("totalPage : " + totalPage);

//limit쿼리 시작행수는 현재 페이지에 1을 뺀 수에서 로우퍼페이지를 곱을 한 값이다
startPage = (currentPage - 1) * rowPerPage;
System.out.println("startPage : " + startPage);

//국가 리스트 쿼리 - limit행수 제한
ArrayList<HashMap<String, Object>> selectCountryList = CountryDAO.selectCountryList(startPage, rowPerPage);
//모든 국가 리스트 출력 쿼리
ArrayList<HashMap<String, Object>> selectAllCountryList = CountryDAO.selectAllCountryList();

//전체 국가 행수 담을 변수
int totalCountryCount = 0;

////전체 국가 행수 추출 쿼리
ArrayList<HashMap<String, Object>> selectTotalCountryList = CountryDAO.selectTotalCountryList();

for (HashMap<String, Object> a : selectTotalCountryList) {

	totalCountryCount = (Integer) (a.get("cnt"));

}

//쿼리 ArrayList 디버깅
System.out.println("selectCountryList : " + selectCountryList);
System.out.println("totalCountryCount :" + totalCountryCount);

totalRow = totalCountryCount;

//전체행수가 로우퍼페이지 수로 나눠도 나머지가 남을 때 전체페이지에 +1 해준다
if (totalRow % rowPerPage != 0) {
	totalPage = totalRow / rowPerPage + 1;
	//전체행수가 로우퍼페이지 수에 딱 떨어지는 수일 때 전체페이지에 +1 해준다
} else {
	totalPage = totalRow / rowPerPage;
}


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>countryManage</title>

</head>
		<body>
			<h1>국가DB관리</h1>
			<!-- 국가 입력 INSERT -->
			<form action="/D_airline/emp/countryManageAddAction.jsp" method="post">
				<div>
		
					<input type="text" name="countryName" placeholder="country name"
						required>
					<button type="submit">국가입력</button>
				</div>
			</form>
				<!-- 국가 정보변경 UPDATE -->
			<form action="/D_airline/emp/countryManageModifyAction.jsp"
				method="post">
				<div>
					<input type="text" name="countryName" placeholder="country name"
						required> <input type="number" name="countryId"
						placeholder="country id(NA)" required>
					<button type="submit">국가정보수정</button>
				</div>
			</form>
				<!-- 국가 삭제 DELETE -->
			<form action="/D_airline/emp/countryManageDeleteAction.jsp"
				method="post">
				<div>
					<input type="number" name="countryId" placeholder="country id(NA)"
						required>
		
					<button type="submit">국가삭제</button>
				</div>
			</form>
			<div>
				<!-- 쿼리 실행 여부 확인 메세지값 -->
				<%=msg%>
				<table class="">
					<thead class="">
						<tr>
							<th>국가코드</th>
							<th>국가명</th>
							<th>변경일자</th>
							<th>생성일자</th>
		
						</tr>
					</thead>
					<tbody>
						<%
						//모든 국가 리스트 추출
						for (HashMap<String, Object> m2 : selectAllCountryList) {
						%>
						<tr>
							<td><%=(String) (m2.get("countryId"))%></td>
							<td><%=(String) (m2.get("countryName"))%></td>
							<td><%=(String) (m2.get("updateDate"))%></td>
							<td><%=(String) (m2.get("createDate"))%></td>
		
						</tr>
					</tbody>
					<%
					}
					%>
				</table>
			</div>
		
		
		
		</body>
</html>