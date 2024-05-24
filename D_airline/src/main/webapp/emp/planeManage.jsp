<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import = "kjwdao.*" %>
<%@ page import="java.net.*" %>

<%
	System.out.println("----------planeManage.jsp----------");
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


ArrayList<HashMap<String, Object>> selectPlaneList = PlaneDAO.selectPlaneList(startPage, rowPerPage);
ArrayList<HashMap<String, Object>> selectAllPlaneList = PlaneDAO.selectAllPlaneList();



System.out.println("selectPlaneList : "+selectPlaneList);


int totalPlaneCount = 0;

ArrayList<HashMap<String, Object>> selectTotalPlaneList  = PlaneDAO.selectTotalPlaneList();

for(HashMap<String, Object> a : selectTotalPlaneList) {

	totalPlaneCount = (Integer)(a.get("cnt"));
	
}

System.out.println("totalPlaneCount :" +totalPlaneCount );

		totalRow = totalPlaneCount;



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
	<title>planeManage</title>
	


	
</head>
	<body>
		<h1>항공기DB관리</h1>
		<form action = "/D_airline/emp/planeManageAddAction.jsp" method="post">
			<div>
				<input type="text" name ="planeName" placeholder="plane name" required>
				<input type="text" name ="airline" placeholder="항공사" required>
				<select name="state">
					<option value="운영가능">운영가능</option>
					<option value="수리중">수리중</option>
					<option value="사용중단">사용중단</option>
				</select>
				<button type="submit">항공기입력</button>
			</div>
		</form>
		
		<form action = "/D_airline/emp/planeManageModifyAction.jsp" method="post">
			<div>
				<input type="text" name ="planeName" placeholder="plane name" required>
				<input type="text" name ="airline" placeholder="항공사" required>
				<select name="state">
					<option value="운영가능">운영가능</option>
					<option value="수리중">수리중</option>
					<option value="사용중단">사용중단</option>
				</select>
				<input type="number" name ="planeId" placeholder="항공기코드(PL)" required>
				<button type="submit">항공기 정보변경</button>
			</div>
		</form>
		
		<form action = "/D_airline/emp/planeManageDeleteAction.jsp" method="post">
			<div>
				<input type="number" name ="planeId" placeholder="항공기코드(PL)" required>
		
				<button type="submit">항공기 삭제</button>
			</div>
		</form>
			<div>
				<%=msg %>
				<table class="">
					<thead class="" >
						<tr>
							<th>항공기코드</th>
							<th>항공기명</th>
							<th>소속 항공사</th>
							<th>상태</th>
							<th>변경일자</th>
							<th>생성일자</th>
					
						</tr>
					</thead>
					<tbody>
	<%					//rs.getString이 아닌 HashMap으로 값을 뿌림
						for(HashMap<String, Object> m2 : selectAllPlaneList) {
	%>
							<tr>
								<td><%=(String)(m2.get("planeId"))%></td>
								<td><%=(String)(m2.get("planeName"))%></td>
								<td><%=(String)(m2.get("airline"))%></td>
								<td><%=(String)(m2.get("state"))%></td>
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