<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="kjwdao.*" %>
<%@ page import="java.net.*" %>

<%
    System.out.println("----------seatManage.jsp----------");
    System.out.println("세션 ID: " + session.getId());
    
    
    System.out.println("[param]rowPerPage : " + request.getParameter("rowPerPage"));
    System.out.println("[param]currentPage : " + request.getParameter("currentPage"));
    
    System.out.println("[param]checkFlight : " + request.getParameter("checkFlight"));
    System.out.println("[param]msg : " + request.getParameter("msg"));
    System.out.println("[param]flightId : " + request.getParameter("flightId"));
    
   
    String msg = null;
 	String checkFlight = null;
    int flightId = 0;
    int totalCountAvailableSeat = 0;
    String createDate = null;
    String departureTime = null;
    String arrivalTime = null;
    String status = null;
    int planeId = 0;
    String planeName = null;
    String planeState = null;
    int basefare = 0;
    String flightDuration = null;
    String depCityName = null;
    String arrCityName = null;
    String depAirport = null;
    String arrAirport = null;
    int depCountryId = 0;
    int arrCountryId = 0;
    String depCountryName = null;
    String arrCountryName = null;
    String stringFlightid = null;
    String strngPlaneId = null;
    String stringDepCountryId = null;
    String stringArrCountryId = null;
    int seatId = 0;
    String stringSeatId = null;
    String seatGrade = null;
    int seatNo = 0;
    String seatState = null;
    String updateDate = null;
    int routeId = 0;
    String stringRouteId = null;
    double seatPrice = 0;
    String airline = null;
    String flightStatus = null;
   
    

    if (request.getParameter("msg") != null) {
        msg = request.getParameter("msg");
        
    }
    

    if (request.getParameter("checkFlight") != null) {
        checkFlight = request.getParameter("checkFlight");
        System.out.println("checkFlight : " + checkFlight);
    }
    
    
    if (request.getParameter("flightId") != null) {
        flightId = Integer.parseInt(request.getParameter("flightId"));
        System.out.println("flightId : " + flightId);
    }


    System.out.println("msg : " + msg);
    System.out.println("checkFlight : " + checkFlight);
    System.out.println("flightId : " + flightId);
    
    

    if (session.getAttribute("loginAd") == null) {
        System.out.println("관리자만 접근 가능한 페이지입니다.");
        msg = URLEncoder.encode("관리자만 접근 가능한 페이지입니다.", "UTF-8");
        response.sendRedirect("/D_airline/customer/flightMain.jsp?msg=" + msg);
        return;
    }

    




    // 전체행수 검색 변수설정 ------------------------
    int totalRow = 0; // 조회쿼리 전체행수
    int rowPerPage = 10; // 페이지당 행수
    int totalPage = 1; // 전체 페이지수

    int currentPage = 1; // 현재 페이지수
    int startPage = 0; // 시작행

    int startRow = (currentPage - 1) * rowPerPage;

    System.out.println("totalRow : " + totalRow);
    System.out.println("rowPerPage : " + rowPerPage);
    System.out.println("totalRow % rowPerPage : " + totalRow % rowPerPage);
    System.out.println("totalPage : " + totalPage);

    // 현재 페이지 값이 넘어왔을 때 커런트 페이지 값을 넘겨받는다
    if (request.getParameter("currentPage") != null) {
        currentPage = Integer.parseInt(request.getParameter("currentPage"));
        System.out.println("currentPage : " + currentPage);
    }
    // 로우퍼 페이지 값이 넘어왔을때 로우퍼 페이지 값을 넘겨받는다
    if (request.getParameter("rowPerPage") != null) {
        rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
        System.out.println("rowPerPage : " + rowPerPage);
    }

    startPage = (currentPage - 1) * rowPerPage;
    System.out.println("startPage : " + startPage);

  
    ArrayList<HashMap<String, Object>> selectSelectedFlightInfo = null;
    ArrayList<HashMap<String, Object>> selectSeatNo = null;
    
    if(request.getParameter("checkFlight")!=null && checkFlight.equals("1")){
    	selectSeatNo = SeatDAO.selectSeatNo(flightId);
    	selectSelectedFlightInfo = SeatDAO.selectSelectedFlightInfo(flightId);
    	System.out.println("좌석조회 쿼리 실행");
    }

 


   
    int updateFlightStatusBeforeTakeOff = FlightDAO.updateFlightStatusBeforeTakeOff();
    int updateFlightStatusInOperation = FlightDAO.updateFlightStatusInOperation();
    int updateFlightStatusEnded = FlightDAO.updateFlightStatusEnded();

    
    
    int totalRouteCount = 0;

    ArrayList<HashMap<String, Object>> selectTotalFlightList = FlightDAO.selectTotalFlightList();

    for (HashMap<String, Object> a : selectTotalFlightList) {
        totalRouteCount = (Integer) (a.get("cnt"));
    }

    System.out.println("totalRouteCount :" + totalRouteCount);

    totalRow = totalRouteCount;

    // 전체행수가 로우퍼페이지 수로 나눠도 나머지가 남을 때 전체페이지에 +1 해준다
    if (totalRow % rowPerPage != 0) {
        totalPage = totalRow / rowPerPage + 1;
    // 전체행수가 로우퍼페이지 수에 딱 떨어지는 수일 때 전체페이지에 +1 해준다
    } else {
        totalPage = totalRow / rowPerPage;
    }


    HashMap<String, Object> m = new HashMap<>();

   
    m = (HashMap<String, Object>) (session.getAttribute("loginAd"));

    String adminId = null;
    String hireDate = null;
    String post = null;
    String type = null;
  
    adminId = (String) (m.get("adminId"));
    hireDate = (String) (m.get("hireDate"));
    post = (String) (m.get("post"));
    type = (String) (m.get("type"));

    System.out.println(session.getAttribute("loginAd"));
    System.out.println("adminId : " + adminId);
    System.out.println("hireDate : " + hireDate);
    System.out.println("post : " + post);

    System.out.println("totalRow : " + totalRow);
    System.out.println("rowPerPage : " + rowPerPage);
    System.out.println("totalPage : " + totalPage);

    m.put("type", "admin");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <style>
    	
    </style>
    <title>SeatManage</title>
</head>
<body>
    <h1>좌석DB관리</h1>
   
   	<form action="/D_airline/emp/seatManageSelectAction.jsp">
   	<input type="number" placeholder="search flight ID(FL)" name="flightId">
   	<button type="submit">항공편 선택</button>
   </form>
   
   <div>
		<%
			if(request.getParameter("checkFlight") != null){
				for(HashMap<String, Object> m2 : selectSelectedFlightInfo){
					totalCountAvailableSeat = (int)(m2.get("totalCountAvailableSeat"));
					flightId = (int)(m2.get("flightId"));
					createDate = (String)(m2.get("createDate"));
					departureTime = (String)(m2.get("departureTime"));
					arrivalTime = (String)(m2.get("arrivalTime"));
					status = (String)(m2.get("status"));
					planeId = (int)(m2.get("planeId"));
					planeName = (String)(m2.get("planeName"));
					airline = (String)(m2.get("airline"));
					planeState = (String)(m2.get("planeState"));
					basefare = (int)(m2.get("basefare"));
					flightDuration = (String)(m2.get("flightDuration"));
					depCityName = (String)(m2.get("depCityName"));
					arrCityName = (String)(m2.get("arrCityName"));
					depAirport = (String)(m2.get("depAirport"));
					arrAirport = (String)(m2.get("arrAirport"));
					depCountryId = (int)(m2.get("depCountryId"));
					arrCountryId = (int)(m2.get("arrCountryId"));
					depCountryName = (String)(m2.get("depCountryName"));
					arrCountryName = (String)(m2.get("arrCountryName"));
				
					stringDepCountryId = (String)(m2.get("stringDepCountryId"));
					stringArrCountryId = (String)(m2.get("stringArrCountryId"));
					
					
					%>
					<span>선택된 항공편 정보</span>
					<div>항공편-'FL<%=flightId%>'-출발도시-<%=depCountryName %>/도착도시-<%=arrCountryName %></div>
					
			<%	}
			}
		%>
   </div>
   <hr>
   <div>
   <% 
   	if(request.getParameter("checkFlight") != null){
				for(HashMap<String, Object> m2 : selectSeatNo){
					seatId = (int)(m2.get("seatId"));
					stringSeatId = (String)(m2.get("stringSeatId"));
					flightId = (int)(m2.get("flightId"));
					seatState = (String)(m2.get("seatState"));
					seatGrade = (String)(m2.get("seatGrade"));
					seatNo = (int)(m2.get("seatNo"));
					seatState = (String)(m2.get("seatState"));
					updateDate = (String)(m2.get("updateDate"));
					createDate = (String)(m2.get("createDate"));
					routeId = (int)(m2.get("routeId"));
					stringRouteId = (String)(m2.get("stringRouteId"));
					flightStatus = (String)(m2.get("flightStatus"));
					seatPrice = (double)(m2.get("seatPrice"));
					
					
					
					%>
					
					<span>좌석 정보</span>
					<div><a href="/D_airline/emp/seatManageModifyAction.jsp?seatId=<%=seatId%>&flightId=<%=flightId%>&seatNo=<%=seatNo%>"><%=seatGrade %>/<%=seatNo %>/<%=seatState %></a></div>
					
			<%	}
			}
		%>
   </div>
   
   
   
</body>
</html>
