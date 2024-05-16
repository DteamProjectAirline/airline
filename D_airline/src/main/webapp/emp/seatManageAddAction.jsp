<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import ="dao.*" %>



<%
System.out.println("---------------seatManageAddAction.jsp---------------");
System.out.println("세션 ID: " + session.getId());

String msg = null;
int flightId = 0;
String seatGrade = null;
int seatNo = 0;


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
System.out.println("[param]msg : "+request.getParameter("msg"));


if(request.getParameter("flightId")!=null){
	flightId = Integer.parseInt(request.getParameter("flightId"));
}


System.out.println("flightId : "+ flightId);


int insertSeat = 0;

for(int i = 1; i <=20; i++){
	seatGrade = "퍼스트클래스";
	seatNo = i;
	insertSeat = SeatDAO.insertSeat(flightId, seatGrade, seatNo);
}

for(int i = 21; i <=50; i++){
	seatGrade = "비지니스";
	seatNo = i;
	insertSeat = SeatDAO.insertSeat(flightId, seatGrade, seatNo);
}

for(int i = 51; i <=150; i++){
	seatGrade = "일반석";
	seatNo = i;
	insertSeat = SeatDAO.insertSeat(flightId, seatGrade, seatNo);
}



if (insertSeat == 1) {
	System.out.println("좌석 일괄 신규등록에 성공하였습니다.");
	msg = URLEncoder.encode("항공편 및 좌석 일괄 신규등록에 성공하였습니다.", "UTF-8");
	response.sendRedirect("/D_airline/emp/flightManage.jsp?msg=" + msg);
	
	

} else {
	System.out.println("좌석 일괄 신규등록에 실패하였습니다.");
	msg = URLEncoder.encode("항공편 및 좌석 일괄 신규등록에 실패하였습니다.", "UTF-8");
	response.sendRedirect("/D_airline/emp/flightManage.jsp?msg=" + msg);
	return;
}
%>
