<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.time.*" %>
<%@ page import = "dao.*" %>
<%@ page import="java.net.*" %>

<% 
	System.out.println("----------seatSelection2.jsp----------");


String msg = null;
int flightId = 0;
int seatId = 0;
String seatState = null;
String seatGrade = null;
int seatNo = 0;
double seatPrice = 0;
String type = null;
int seatIndex = 0;



System.out.println("[param]flightId : " + request.getParameter("flightId"));
System.out.println("[param]seatGrade : " + request.getParameter("seatGrade"));
System.out.println("[param]type : " + request.getParameter("type"));

if(request.getParameter("flightId")!=null){
	flightId = Integer.parseInt(request.getParameter("flightId"));
}

if(request.getParameter("seatGrade")!=null){
	seatGrade = request.getParameter("seatGrade");
}

if(request.getParameter("type")!=null){
	type = request.getParameter("type");
}

System.out.println("type : "+ type);

System.out.println("flightId : "+ flightId);
System.out.println("seatGrade : "+ seatGrade);

ArrayList<HashMap<String, Object>> selectSeatNo = SeatDAO.selectSeatNo(flightId);

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
</head>
<body>

	  <div>
   <% 
   
   
   	if(request.getParameter("flightId") != null){
   		
 
   		
				for(HashMap<String, Object> m2 : selectSeatNo){
					
					if(seatGrade == (String)(m2.get("seatGrade"))){
						
				
					
					seatId = (int)(m2.get("seatId"));
					flightId = (int)(m2.get("flightId"));
					seatState = (String)(m2.get("seatState"));
					seatNo = (int)(m2.get("seatNo"));		
					seatPrice = (double)(m2.get("seatPrice"));
					
					
					
					%>
					
					<span>좌석 정보</span>
					<div><a href="/D_airline/customer/ticketingPage.jsp?seatId=<%=seatId%>&flightId=<%=flightId%>&seatNo=<%=seatNo%>&seatGrade=<%=seatGrade%>&seatPrice=<%=seatPrice%>"><%=seatGrade %>/<%=seatNo %>/<%=seatState %></a></div>
					
			<%	}}
			}
		%>
	</div>
   
	<div>
		<form method="post" action="/D_airline/customer/ticketingPage.jsp">
			<div>
				<table>
					<thead>
						<tr>
							<td><%=(char)65 %></td>
							<td><%=(char)66 %></td>
							<td></td>
							<td><%=(char)67 %></td>
							<td><%=(char)68 %></td>
							<td></td>
							<td><%=(char)69 %></td>
							<td><%=(char)70 %></td>
						</tr>
						
				
					</thead>
						<tr>
							<td>
						<%
							for(int i = 0; i <= 24; i++){
								if((i-3) % 8 == 0){
									
									System.out.println("첫번째 공백 i : "+ i);
									
									int a = (i/8)+1; 
									System.out.println("a : "+ a);
									
								}
								if((i-6) % 8 == 0){
									
									System.out.println("두번째 공백 i : "+ i);
									int a = (i/8)+1; 
									System.out.println("a : "+ a);
									
									
								}else{
									
									HashMap<String, Object> m = selectSeatNo.get(seatIndex);
                                    seatNo = (int) m.get("seatNo");
                                    seatGrade = (String) m.get("seatGrade");
                                    seatState = (String) m.get("seatState");
                                    System.out.println("seatIndex : " + seatIndex); 
                                   	System.out.println("seatNo : " + seatNo + "//seatGrade : " + seatGrade + "//seatState : " + seatState);
                                    seatIndex++;
                                    

									
								}
								
							}
						%>
							</td>
						</tr>
					<tbody>
					
					</tbody>
				
				</table>
			
			
			
			
			</div>
		
		
		
		</form>	
	   
	</div>
	   
   
   

</body>
</html>