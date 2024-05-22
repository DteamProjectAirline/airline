<%@page import="sjwdao.TicketingDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

int seatId1 = Integer.parseInt(request.getParameter("seatId1"));
int seatId2 = Integer.parseInt(request.getParameter("seatId2"));
int flightId1 = Integer.parseInt(request.getParameter("flightId1"));
String flightId2 = request.getParameter("flightId2");
String seatNo1 = request.getParameter("seatNo1"); 
String seatNo2 = request.getParameter("seatNo2"); 
String seatGrade1 = request.getParameter("seatGrade1");
String seatGrade2 = request.getParameter("seatGrade2");
String seatPrice1 = request.getParameter("seatPrice1");
String seatPrice2 = request.getParameter("seatPrice2");
String customerName = request.getParameter("customerName");
String customerPhone = request.getParameter("customerPhone");
String customerNation = request.getParameter("customerNation");
String birthDate = request.getParameter("birthDate");
String customerId = request.getParameter("customerId");
String mileage = request.getParameter("mileage");
String departureTime1 = request.getParameter("departureTime1");
String departureTime2 = request.getParameter("departureTime2");
String arrivalTime1 = request.getParameter("arrivalTime1");
departureTime1 = departureTime1.substring(0,9);
String arrivalTime2 = request.getParameter("arrivalTime2");
String departPrice = request.getParameter("departPrice");
String arrivalPrice = request.getParameter("arrivalPrice");
String luggage = request.getParameter("luggage");
/*
System.out.println("seatId1: " + seatId1);
System.out.println("seatId2: " + seatId2);
System.out.println("flightId1: " + flightId1);
System.out.println("flightId2: " + flightId2);
System.out.println("seatNo1: " + seatNo1); 
System.out.println("seatNo2: " + seatNo2); 
System.out.println("seatGrade1: " + seatGrade1);
System.out.println("seatGrade2: " + seatGrade2);
System.out.println("seatPrice1: " + seatPrice1);
System.out.println("seatPrice2: " + seatPrice2);
System.out.println("customerName: " + customerName);
System.out.println("customerPhone: " + customerPhone);
System.out.println("customerNation: " + customerNation);
System.out.println("birthDate: " + birthDate);
System.out.println("customerId: " + customerId);
System.out.println("mileage: " + mileage);
*/
// 출발지 예약
int row = TicketingDAO.Ticketing(customerId, seatId1, departureTime1, departPrice, luggage);
System.out.println(row + "1이면성공!");
int row2 = TicketingDAO.seatState(seatId1);
System.out.println(seatId1);
System.out.println(row2 + "1이면성공!");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>