<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.time.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.*"%>

<%
System.out.println("----------seatSelection.jsp----------");


int seatIndex = 0;
String msg = null;

int flightId1 = 0;
int flightId2 = 0;

String selectedSeatGrade1 = null;
String selectedSeatGrade2 = null;

String type = null;
String departureLocation = null;
String arrivalLocation = null;

String seatState = null;
int seatId1 = 0;
int seatNo1 = 0;
double seatPrice1 = 0;
String seatGrade1 = null;

System.out.println("[param] selectedSeatGrade1 : " + request.getParameter("selectedSeatGrade1"));
System.out.println("[param] selectedSeatGrade2 : " + request.getParameter("selectedSeatGrade2"));
System.out.println("[param] flightId1 : " + request.getParameter("flightId1"));
System.out.println("[param] flightId2 : " + request.getParameter("flightId2"));
System.out.println("[param] departureLocation : " + request.getParameter("departureLocation"));
System.out.println("[param] arrivalLocation : " + request.getParameter("arrivalLocation"));
System.out.println("[param] type : " + request.getParameter("type"));


if (request.getParameter("flightId1") != null) {
	flightId1 = Integer.parseInt(request.getParameter("flightId1"));
}

if (request.getParameter("flightId2") != null) {
	flightId2 = Integer.parseInt(request.getParameter("flightId2"));
}

if (request.getParameter("selectedSeatGrade1") != null) {
	selectedSeatGrade1 = request.getParameter("selectedSeatGrade1");
}

if (request.getParameter("selectedSeatGrade2") != null) {
	selectedSeatGrade2 = request.getParameter("selectedSeatGrade2");
}

if (request.getParameter("type") != null) {
	type = request.getParameter("type");
}

if (request.getParameter("departureLocation") != null) {
	departureLocation = request.getParameter("departureLocation");
}

if (request.getParameter("arrivalLocation") != null) {
	arrivalLocation = request.getParameter("arrivalLocation");
}

System.out.println("type : " + type);
System.out.println("flightId1 : " + flightId1);
System.out.println("flightId2 : " + flightId2);
System.out.println("selectedSeatGrade1 : " + selectedSeatGrade1);
System.out.println("selectedSeatGrade2 : " + selectedSeatGrade2);
System.out.println("departureLocation : " + departureLocation);
System.out.println("arrivalLocation : " + arrivalLocation);

ArrayList<HashMap<String, Object>> selectSeatNo = SeatDAO.selectSeatNo(flightId1);

if (selectSeatNo != null || !(selectSeatNo.isEmpty())) {
	System.out.println("해당 항공편 좌석조회 성공");

} else {
	System.out.println("해당 항공편 좌석조회 실패");
	msg = URLEncoder.encode("해당 항공편 좌석조회에 실패하였습니다.", "UTF-8");
	response.sendRedirect("/D_airline/customer/flightList1.jsp?msg=" + msg);
	return;
}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>seatSelection.jsp</title>

<link rel="stylesheet" type="text/css" href="/D_airline/css/css_seatSelection.css">
</head>
		<body>
			<div>
				
	<%
				if (request.getParameter("flightId1") != null) {
	
			
					 
					if (type != null && type.equals("편도")) {
	%>
						<form action="/D_airline/customer/ticketingPage.jsp">
	<%
					}else if(type != null && type.equals("왕복")){
	%>
			
						<form action="/D_airline/customer/seatSelection2.jsp">
						
	<%
					}
	%>
			
			
				
					<div>
						<table>
							<thead>
								<tr>
									<td class="row"><%=(char) 65%></td>
									<td class="row"><%=(char) 66%></td>
									<td></td>
									<td class="row"><%=(char) 67%></td>
									<td class="row"><%=(char) 68%></td>
									<td class="row"></td>
									<td class="row"><%=(char) 69%></td>
									<td class="row"><%=(char) 70%></td>
		
								</tr>
							</thead>
							<tbody>
								<tr>
									
	<%
									for (int i = 1; i <= 24; i++) {
										if ((i - 3) % 8 == 0) {
	
											System.out.println("첫번째 공백 i : " + i);
			
											int a = (i / 8) + 1;
											System.out.println("행(a) : " + a);
	%>
											<td>
												<button class="aisle" disabled><%=a %></button> <%
										} else if ((i - 6) % 8 == 0) {
											
											System.out.println("두번째 공백 i : " + i);
											int a = (i / 8) + 1;
											System.out.println("행(a) : " + a);
	%>
											<td>
												<button class="aisle" disabled><%=a %></button> <%
										} else {
											
											HashMap<String, Object> m = selectSeatNo.get(seatIndex);
											
											
											
											seatId1 = (int) m.get("seatId");
											seatNo1 = (int) m.get("seatNo");
										
											seatState = (String) m.get("seatState");
											System.out.println("i : " + i);
											seatIndex++;
											//System.out.println("seatNo : " + seatNo + "//seatGrade : " + seatGrade + "//seatState : " + seatState);
											
											if (seatState.equals("1")) {
												if(selectedSeatGrade1 .equals("퍼스트클래스")){
													
													%>
													<td>
														<input type="hidden" name ="flightId1" value="<%=flightId1 %>">
														<input type="hidden" name ="flightId2" value="<%=flightId2 %>">
														<input type="hidden" name ="seatId1" value="<%=seatId1 %>">
														<input type="hidden" name ="seatNo1" value="<%=seatNo1%>">
														<input type="hidden" name ="type" value="<%=type %>">
														<input type="hidden" name ="selectedSeatGrade1" value="<%=selectedSeatGrade1 %>">
														<input type="hidden" name ="selectedSeatGrade2" value="<%=selectedSeatGrade2 %>">
														<input type="hidden" name ="departureLocation" value="<%=departureLocation %>">
														<input type="hidden" name ="arrivalLocation" value="<%=arrivalLocation %>">
														<button class="firstActive"><%=seatNo1 %></button> <%
													
												}else{
													
													%>
													<td>
														<button class="firstUnable" disabled><%=seatNo1 %></button> <%
												}

											} else {
	%>
												<td>
													<button class="unableSeat" disabled><%=seatNo1 %></button> <%
											}
	%> 
			
	<%
											if (seatNo1 % 6 == 0) {
	%>
												</td>
								</tr>
								<tr>
									
	<%
											}
	%> 
	<%
										}
			
									}
	%>
						
								</tr>
							</tbody>
		
						</table>
	
		
					</div>
					
					<div>
						<table>
							<thead>
								<tr>
									<td><%=(char) 65%></td>
									<td><%=(char) 66%></td>
									<td></td>
									<td><%=(char) 67%></td>
									<td><%=(char) 68%></td>
									<td></td>
									<td><%=(char) 69%></td>
									<td><%=(char) 70%></td>
		
								</tr>
							</thead>
							<tbody>
								<tr>
									
	<%
									for (int i = 25; i <= 96; i++) {
										if ((i - 3) % 8 == 0) {
	
											System.out.println("첫번째 공백 i : " + i);
			
											int a = (i / 8) + 1;
											System.out.println("행(a) : " + a);
	%>
											<td>
												<button class="aisle" disabled><%=a %></button> <%
										} else if ((i - 6) % 8 == 0) {
											
											System.out.println("두번째 공백 i : " + i);
											int a = (i / 8) + 1;
											System.out.println("행(a) : " + a);
	%>
											<td>
												<button class="aisle" disabled><%=a %></button> <%
										} else {
											
											HashMap<String, Object> m = selectSeatNo.get(seatIndex);
											seatNo1 = (int) m.get("seatNo");
											seatGrade1 = (String) m.get("seatGrade");
											seatState = (String) m.get("seatState");
											System.out.println("i : " + i);
											seatIndex++;
											//System.out.println("seatNo : " + seatNo + "//seatGrade : " + seatGrade + "//seatState : " + seatState);
											
											if (seatState.equals("1")) {
												if(selectedSeatGrade1 .equals("비지니스")){
													
	%>
													<td>
														<input type="hidden" name ="flightId1" value="<%=flightId1 %>">
														<input type="hidden" name ="flightId2" value="<%=flightId2 %>">
														<input type="hidden" name ="seatId1" value="<%=seatId1 %>">
														<input type="hidden" name ="seatNo1" value="<%=seatNo1%>">
														<input type="hidden" name ="type" value="<%=type %>">
													<input type="hidden" name ="selectedSeatGrade1" value="<%=selectedSeatGrade1 %>">
													<input type="hidden" name ="selectedSeatGrade2" value="<%=selectedSeatGrade2 %>">
														<input type="hidden" name ="departureLocation" value="<%=departureLocation %>">
														<input type="hidden" name ="arrivalLocation" value="<%=arrivalLocation %>">
														<button class="businessActive"><%=seatNo1 %></button> 
	<%
													
												}else{
													
	%>
													<td>
														<button class="businessUnable" disabled><%=seatNo1 %></button>
	<%
												}

											} else {
	%>
												<td>
													<button class="unableSeat" disabled><%=seatNo1 %></button> <%
											}
	%> 
			
	<%
											if (seatNo1 % 6 == 0) {
	%>
												</td>
								</tr>
								<tr>
									
	<%
											}
	%> 
	<%
										}
			
									}
	%>
						
								</tr>
							</tbody>
		
						</table>
	
		
					</div>
					
										<div>
						<table>
							<thead>
								<tr>
									<td><%=(char) 65%></td>
									<td><%=(char) 66%></td>
									<td></td>
									<td><%=(char) 67%></td>
									<td><%=(char) 68%></td>
									<td></td>
									<td><%=(char) 69%></td>
									<td><%=(char) 70%></td>
		
								</tr>
							</thead>
							<tbody>
								<tr>
									
	<%
									for (int i = 97; i <= 200; i++) {
										if ((i - 3) % 8 == 0) {
	
											System.out.println("첫번째 공백 i : " + i);
			
											int a = (i / 8) + 1;
											System.out.println("행(a) : " + a);
	%>
											<td>
												<button class="aisle" disabled><%=a %></button><%
										} else if ((i - 6) % 8 == 0) {
											
											System.out.println("두번째 공백 i : " + i);
											int a = (i / 8) + 1;
											System.out.println("행(a) : " + a);
	%>
											<td>
												<button class="aisle" disabled><%=a %></button> <%
										} else {
											
											HashMap<String, Object> m = selectSeatNo.get(seatIndex);
											seatNo1 = (int) m.get("seatNo");
											seatGrade1 = (String) m.get("seatGrade");
											seatState = (String) m.get("seatState");
											System.out.println("i : " + i);
											seatIndex++;
											
										
											//System.out.println("seatNo : " + seatNo + "//seatGrade : " + seatGrade + "//seatState : " + seatState);
											
											if (seatState.equals("1")) {
											
												if(selectedSeatGrade1 .equals("일반석")){
													
	%>
													<td>
															 
															<input type="hidden" name ="flightId1" value="<%=flightId1 %>">
															<input type="hidden" name ="flightId2" value="<%=flightId2 %>">
														<input type="hidden" name ="seatId1" value="<%=seatId1 %>">
														<input type="hidden" name ="seatNo1" value="<%=seatNo1%>">
														<input type="hidden" name ="type" value="<%=type %>">
														<input type="hidden" name ="selectedSeatGrade1" value="<%=selectedSeatGrade1 %>"> 
														<input type="hidden" name ="selectedSeatGrade2" value="<%=selectedSeatGrade2 %>"> 
														<input type="hidden" name ="departureLocation" value="<%=departureLocation %>">
														<input type="hidden" name ="arrivalLocation" value="<%=arrivalLocation %>">
												 
														 
														
														<button class="economyActive"><%=seatNo1 %></button> 
	<%
													
												}else{
													
	%>
													<td>
														<button class="economyUnable" disabled><%=seatNo1 %></button> 
	<%
												}

											
											} else {
	%>
												<td>
													<button class="unableSeat" disabled><%=seatNo1 %></button> <%
											}
	%> 
			
	<%
											if (seatNo1 % 6 == 0) {
	%>
												</td>
								</tr>
								<tr>
									
	<%
											}
	%> 
	<%
										}
			
									}
						}
	%>
						
								</tr>
							</tbody>
		
						</table>
	
		
					</div>
				
					
				</form>
		
			</div>
		</body>
</html>