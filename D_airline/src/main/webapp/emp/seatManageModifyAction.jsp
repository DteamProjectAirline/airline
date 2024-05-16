<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import ="dao.*" %>



<%
System.out.println("---------------seatManageModifyAction.jsp---------------");
System.out.println("세션 ID: " + session.getId());

String msg = null;
int seatId = 0;
int flightId = 0;
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


adminId = (String) (m.get("adminId"));

System.out.println("[param]seatId : "+request.getParameter("seatId"));
System.out.println("[param]flightId : "+request.getParameter("flightId"));
System.out.println("[param]seatNo : "+request.getParameter("seatNo"));

if(request.getParameter("seatId")!=null){
	
seatId = Integer.parseInt(request.getParameter("seatId"));
}

if(request.getParameter("flightId")!=null){
	
flightId = Integer.parseInt(request.getParameter("flightId"));
}


if(request.getParameter("seatNo")!=null){
	
seatNo = Integer.parseInt(request.getParameter("seatNo"));
}

System.out.println("seatId : " + seatId);
System.out.println("flightId : " + flightId);
System.out.println("seatNo : " + seatNo);

int updateSeatStatee = SeatDAO.updateSeatState(seatId);

if (updateSeatStatee == 1) {
	System.out.println("좌석상태 변경에 성공하였습니다.(이용가능 --> 사용불가)//FL"+flightId+" "+seatNo+"번 좌석");
	msg = URLEncoder.encode("좌석상태 변경에 성공하였습니다.", "UTF-8");
	response.sendRedirect("/D_airline/emp/seatManage.jsp?msg=" + msg);
	

} else {
	System.out.println("좌석상태 변경에 실패하였습니다.");
	msg = URLEncoder.encode("좌석상태 변경에 실패하였습니다.", "UTF-8");
	response.sendRedirect("/D_airline/emp/seatManage.jsp?msg=" + msg);
	return;
}
%>
