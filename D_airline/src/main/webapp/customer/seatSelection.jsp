<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.time.*"%>
<%@ page import="kjwdao.*"%>
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

// 파라미터 변수처리
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

//좌석 조회 쿼리
ArrayList<HashMap<String, Object>> selectSeatNo = SeatDAO.selectSeatNo(flightId1);
//항공편 정보 조회
ArrayList<HashMap<String, Object>> selectSeatPageFlightInfo = FlightDAO.selectSeatPageFlightInfo(flightId1);

if (selectSeatNo != null || !(selectSeatNo.isEmpty())) {
    System.out.println("해당 항공편 좌석조회 성공");
} else {
    System.out.println("해당 항공편 좌석조회 실패");
    msg = URLEncoder.encode("해당 항공편 좌석조회에 실패하였습니다.", "UTF-8");
    response.sendRedirect("/D_airline/customer/flightList1.jsp?msg=" + msg);
    return;
}

//세션 정보관련
String customerId = null;
String name = null;
if (session.getAttribute("loginCs") != null) {
    HashMap<String, Object> loginMember = (HashMap<String, Object>) (session.getAttribute("loginCs"));
    customerId = (String) loginMember.get("memberId");
    name = (String) loginMember.get("name");
}
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>seatSelection.jsp</title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" type="text/css" href="/D_airline/css/css_seatSelection.css">
<style>
    .containerwrap {
        margin-left: auto;
        margin-right: auto;
        width: 1000px;
    }
    .seat-container {
        text-align: left;
        margin-top: 20px;
    }
    
   
</style>
    
    
</style>
</head>
<body>
    <div class="nav">
        <div>
            코리아나 항공
        </div>
        <div style="margin-right: 20px;">
	<% 
			if(session.getAttribute("loginCs") != null){ 
	%>
            	<%=customerId%>/<%=name%>
    <% 		} 
    %>
        </div>
    </div>
    <div>
        <div class="seatbanner">좌석 선택</div>
    </div>
    <div class="mainwrap">
        <div style="width: 1000px;">
	<% 		for(HashMap<String, Object> m : selectSeatPageFlightInfo){ 
	%>
            <div class="containerwrap">
                <div class="container p-5 my-5 round border">
                    <div class="routeinfo">
                        <div><%=(String)(m.get("depCity")) %>/<%=(String)(m.get("depCountryName")) %></div>
                        <div class="planemark"></div>
                        <div><%=(String)(m.get("arrCity")) %>/<%=(String)(m.get("arrCountryName")) %></div>
                    </div>
                    <div class="time-info">
                        <%=(String)(m.get("departureTimeDate")) %> <%=(String)(m.get("departureTimeTime")) %>
                    </div>
                </div>
            </div>
	<% 
			} 
	%>
            <div class="row">
                <div class="col container border round seat-container">
                    <span>//좌석등급 표시// </span>
                </div>
                <div class="col">
	<% 
					if (request.getParameter("flightId1") != null) {
                        if (type != null && type.equals("편도")) { 
    %>
                            <form action="/D_airline/customer/ticketingPage.jsp">
    <% 
    					} else if(type != null && type.equals("왕복")) { 
    %>
                            <form action="/D_airline/customer/seatSelection2.jsp">
    <% 
    					}
  	%>

                        <div class="seattable">
                            <table>
                                <tbody>
                                    <tr>
    <%
	    								for (int i = 1; i <= 24; i++) {
	                                        if ((i - 3) % 8 == 0) {
	                                            int a = (i / 8) + 1; 
	%>
	                                            <td>
	                                                <button class="aisle" disabled><%=a %></button>
	<% 
											} else if ((i - 6) % 8 == 0) {
	                                                int a = (i / 8) + 1; 
	%>
	                                            <td>
	                                                <button class="aisle" disabled><%=a %></button>
	<% 
											} else {
	                                       		HashMap<String, Object> m = selectSeatNo.get(seatIndex);
	                                            seatId1 = (int) m.get("seatId");
	                                            seatNo1 = (int) m.get("seatNo");
	                                            seatState = (String) m.get("seatState");
	                                            seatIndex++;
	                                            if (seatState.equals("1")) {
	                                                if(selectedSeatGrade1.equals("퍼스트클래스")) { 
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
	                                                        <button class="firstActive"><%=seatNo1 %></button>
	<% 
													} else { 
	%>
	                                                    <td>
	                                                        <button class="firstUnable" disabled><%=seatNo1 %></button>
	<% 
													}
	                                       		} else { 
	%>
	                                                    <td>
	                                                        <button class="unableSeat" disabled><%=seatNo1 %></button>
	<% 
												}
	                                            
	                                            if (seatNo1 % 6 == 0) { 
	%>
	                                                    </td>
	                                    </tr>
	                                    <tr>
	<% 
												}
	                                        }
	                                    } 
	%>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div class="seattable">
                            <table>
                                <tbody>
                                    <tr>
    <% 
    									for (int i = 25; i <= 96; i++) {
	                                        if ((i - 3) % 8 == 0) {
	                                            int a = (i / 8) + 1; 
	%>
	                                            <td>
	                                                <button class="aisle" disabled><%=a %></button>
	<% 
													} else if ((i - 6) % 8 == 0) {
	                                                int a = (i / 8) + 1; %>
	                                            <td>
	                                                <button class="aisle" disabled><%=a %></button>
	<% 
													} else {
	                                                HashMap<String, Object> m = selectSeatNo.get(seatIndex);
	                                                seatNo1 = (int) m.get("seatNo");
	                                                seatGrade1 = (String) m.get("seatGrade");
	                                                seatState = (String) m.get("seatState");
	                                                seatIndex++;
		                                                if (seatState.equals("1")) {
		                                                    if(selectedSeatGrade1.equals("비지니스")) { 
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
															} else { 
	%>
		                                                        <td>
		                                                            <button class="businessUnable" disabled><%=seatNo1 %></button>
	<% 
															}
		                                                } else { 
	%>
		                                                    <td>
		                                                        <button class="unableSeat" disabled><%=seatNo1 %></button>
	<% 
														}
		                                                if (seatNo1 % 6 == 0) { 
	%>
		                                                    </td>
		                                    </tr>
		                                    <tr>
	<% 
		                                    			}
	                                           		}
                                        } 
    %>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div class="seattable">
                            <table>
                                <tbody>
                                    <tr>
  	<% 
  										for (int i = 97; i <= 200; i++) {
	                                        if ((i - 3) % 8 == 0) {
	                                            int a = (i / 8) + 1; 
	%>
	                                            <td>
	                                                <button class="aisle" disabled><%=a %></button>
	<% 
	                                            	} else if ((i - 6) % 8 == 0) {
	                                                int a = (i / 8) + 1; 
	%>
	                                            <td>
	                                                <button class="aisle" disabled><%=a %></button>
	<% 
	                                            	} else {
	                                                HashMap<String, Object> m = selectSeatNo.get(seatIndex);
	                                                seatNo1 = (int) m.get("seatNo");
	                                                seatGrade1 = (String) m.get("seatGrade");
	                                                seatState = (String) m.get("seatState");
	                                                seatIndex++;
		                                                if (seatState.equals("1")) {
		                                                    if(selectedSeatGrade1.equals("일반석")) { 
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
		                                                            <button class="economyActive"><span><%=seatNo1 %></span></button>
	<% 
		                                                  	} else { 
	%>
		                                                        <td>
		                                                            <button class="economyUnable" disabled><span class="textcenter" ><%=seatNo1 %></span></button>
	<% 
		                                                   	}
		                                                } else { 
	%>
		                                                    <td>
		                                                        <button class="unableSeat" disabled><span class="textcenter" ><%=seatNo1 %></span></button>
	<% 
		                                                }
		                                                if (seatNo1 % 6 == 0) { 
	%>
		                                                    </td>
	                                    </tr>
	                                    <tr>
	<% 
	                                    				}
		                                          	}
                                            }
                         } %>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
