<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*" %>
<%@ page import="java.net.*" %>

<%
    System.out.println("----------flightManage.jsp----------");
    System.out.println("세션 ID: " + session.getId());

    String msg = null;
    String date = null;
    String flightDuration = null;
    String time = null;
    String planeList = null;
    String modifyPlaneList = null;
    int intRouteId = 0;
    String datetimeString = null;
    String checkRoute = null;
    int flightId = 0;
    String flightExists = null;
    String departureTime = null;
    String departureTimeLocal = null;
    String departureDate = null;
    String departureHourMinute = null;

    if (session.getAttribute("loginAd") == null) {
        System.out.println("관리자만 접근 가능한 페이지입니다.");
        msg = URLEncoder.encode("관리자만 접근 가능한 페이지입니다.", "UTF-8");
        response.sendRedirect("/D_airline/customer/flightMain.jsp?msg=" + msg);
        return;
    }

    System.out.println("[param]rowPerPage : " + request.getParameter("rowPerPage"));
    System.out.println("[param]currentPage : " + request.getParameter("currentPage"));
    System.out.println("[param]flightDuration : " + request.getParameter("flightDuration"));
    System.out.println("[param]intRouteid : " + request.getParameter("intRouteId"));
    System.out.println("[param]datetimeString : " + request.getParameter("datetimeString"));
    System.out.println("[param]planeList : " + request.getParameter("planeList"));
    System.out.println("[param]modifyPlaneList : " + request.getParameter("modifyPlaneList"));
    System.out.println("[param]flightExists : " + request.getParameter("flightExsits"));
    System.out.println("[param]checkRoute : " + request.getParameter("checkRoute"));
    System.out.println("[param]flightId : " + request.getParameter("flightId"));
    System.out.println("[param]departureTimeLocal : " + request.getParameter("departureTimeLocal"));

    if (request.getParameter("msg") != null) {
        msg = request.getParameter("msg");
        System.out.println("msg : " + msg);
    }

    if (request.getParameter("date") != null) {
        date = request.getParameter("date");
        System.out.println("date : " + date);
    }

    if (request.getParameter("flightDuration") != null) {
        flightDuration = request.getParameter("flightDuration");
        System.out.println("flightDuration : " + flightDuration);
    }

    if (request.getParameter("intRouteId") != null) {
        intRouteId = Integer.parseInt(request.getParameter("intRouteId"));
        System.out.println("intRouteId : " + intRouteId);
    }

    if (request.getParameter("datetimeString") != null) {
        datetimeString = request.getParameter("datetimeString");
        System.out.println("datetimeString : " + datetimeString);

     
        String[] dateSplit = datetimeString.split("T");
        date = dateSplit[0];
        time = dateSplit[1];

        System.out.println("date : " + date);
        System.out.println("time : " + time);
    }

    if (request.getParameter("planeList") != null) {
        planeList = request.getParameter("planeList");
        System.out.println("planeList : " + planeList);
    }

    if (request.getParameter("modifyPlaneList") != null) {
        modifyPlaneList = request.getParameter("modifyPlaneList");
        System.out.println("modifyPlaneList : " + modifyPlaneList);
    }

    if (request.getParameter("checkRoute") != null) {
        checkRoute = request.getParameter("checkRoute");
        System.out.println("checkRoute : " + checkRoute);
    }

    if (request.getParameter("flightId") != null) {
        flightId = Integer.parseInt(request.getParameter("flightId"));
        System.out.println("flightId : " + flightId);
    }

    if (request.getParameter("flightExists") != null) {
        flightExists = request.getParameter("flightExists");
        System.out.println("flightExists : " + flightExists);
    }

    if (request.getParameter("departureTime") != null && checkRoute.equals("1")) {
        departureTime = request.getParameter("departureTime");
        String[] departureTimeSplit = departureTime.split(" ");
        departureDate = departureTimeSplit[0];
        departureHourMinute = departureTimeSplit[1].substring(0, 5);
        departureTimeLocal = departureDate + "T" + departureHourMinute;
    }

    if (request.getParameter("departureTimeLocal") != null) {
        departureTimeLocal = request.getParameter("departureTimeLocal");
        System.out.println("departureTimeLocal : " + departureTimeLocal);
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

  
    ArrayList<HashMap<String, Object>> selectAvailablePlaneList = null;

    ArrayList<HashMap<String, Object>> selectAllFlightList = FlightDAO.selectAllFlightList();

    ArrayList<HashMap<String, Object>> selectAllRouteCityCountryList = RouteDAO.selectAllRouteCityCountryList();
    ArrayList<HashMap<String, Object>> selectOneRouteCityCountryList = null;
    ArrayList<HashMap<String, Object>> selectAllRouteCityCountryListSearchFirst = null;
    ArrayList<HashMap<String, Object>> selectRouteInfo = null;
    
    if(request.getParameter("flightId")!=null){
    	selectRouteInfo = FlightDAO.selectRouteInfo(flightId);
    }

    int updateFlightStatusBeforeTakeOff = FlightDAO.updateFlightStatusBeforeTakeOff();
    int updateFlightStatusInOperation = FlightDAO.updateFlightStatusInOperation();
    int updateFlightStatusEnded = FlightDAO.updateFlightStatusEnded();

    if (request.getParameter("planeList") != null) {
        if (planeList.equals("1")) {
            selectAvailablePlaneList = FlightDAO.selectAvailablePlaneList(date, time, flightDuration);
            selectOneRouteCityCountryList = RouteDAO.selectOneRouteCityCountryList(intRouteId);
        }
    }

    if (request.getParameter("modifyPlaneList") != null) {
        if (modifyPlaneList.equals("1")) {
            selectAvailablePlaneList = FlightDAO.selectAvailablePlaneList(date, time, flightDuration);
            selectOneRouteCityCountryList = RouteDAO.selectOneRouteCityCountryList(intRouteId);
        }
    }

    if (request.getParameter("checkRoute") != null) {
        selectAllRouteCityCountryListSearchFirst = RouteDAO.selectAllRouteCityCountryListSearchFirst(flightId);
    }
/*
    System.out.println("selectAllFlightList : " + selectAllFlightList);
    System.out.println("selectAllRouteCityCountryList : " + selectAllRouteCityCountryList);
    System.out.println("selectOneRouteCityCountryList : " + selectOneRouteCityCountryList);
    System.out.println("selectAvailablePlaneList : " + selectAvailablePlaneList);
    System.out.println("selectAllRouteCityCountryListSearchFirst : " + selectAllRouteCityCountryListSearchFirst);
*/
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
    <title>flightManage</title>
</head>
<body>
    <h1>항공편DB관리</h1>
    <div>
        <!-- /////항공편 입력///// -->
        <%
            if (request.getParameter("planeList") != null && planeList.equals("1")) {
        %>
        <form action="/D_airline/emp/flightManageAddAction.jsp" method="post">
            <select name="intRouteId">
                <%
                    for (HashMap<String, Object> m3 : selectOneRouteCityCountryList) {
                        String routeId = null;
                        String departureCity = null;
                        String arrivalCity = null;
                        String departureCountry = null;
                        String arrivalCountry = null;
                        String departureAirport = null;
                        String arrivalAirport = null;
                        intRouteId = 0;

                        intRouteId = (Integer) (m3.get("intRouteId"));
                        routeId = (String) (m3.get("routeId"));
                        departureCity = (String) (m3.get("departureCity"));
                        arrivalCity = (String) (m3.get("arrivalCity"));
                        departureCountry = (String) (m3.get("departureCountry"));
                        arrivalCountry = (String) (m3.get("arrivalCountry"));
                        departureAirport = (String) (m3.get("departureAirport"));
                        arrivalAirport = (String) (m3.get("arrivalAirport"));
                %>
                <option value="<%=intRouteId%>"><%=routeId%>///<%=departureCity%>/<%=departureCountry%>/<%=departureAirport%>---<%=arrivalCity%>/<%=arrivalCountry%>/<%=arrivalAirport%></option>
                <%
                    }
                %>
            </select>
            <input type="datetime-local" name="datetimeString" value="<%=datetimeString %>" disabled>
            <button>항공기 조회</button>
        </form>
        <%
            } else {
        %>
        <form action="/D_airline/emp/flightManagePlaneSearchAction.jsp" method="post">
            <select name="intRouteId">
                <%
                    for (HashMap<String, Object> m3 : selectAllRouteCityCountryList) {
                        String routeId = null;
                        String departureCity = null;
                        String arrivalCity = null;
                        String departureCountry = null;
                        String arrivalCountry = null;
                        String departureAirport = null;
                        String arrivalAirport = null;
                        intRouteId = 0;

                        intRouteId = (Integer) (m3.get("intRouteId"));
                        routeId = (String) (m3.get("routeId"));
                        departureCity = (String) (m3.get("departureCity"));
                        arrivalCity = (String) (m3.get("arrivalCity"));
                        departureCountry = (String) (m3.get("departureCountry"));
                        arrivalCountry = (String) (m3.get("arrivalCountry"));
                        departureAirport = (String) (m3.get("departureAirport"));
                        arrivalAirport = (String) (m3.get("arrivalAirport"));
                %>
                <option value="<%=intRouteId%>"><%=routeId%>///<%=departureCity%>/<%=departureCountry%>/<%=departureAirport%>---<%=arrivalCity%>/<%=arrivalCountry%>/<%=arrivalAirport%></option>
                <%
                    }
                %>
            </select>
            <input type="datetime-local" name="datetimeString">
            <button>항공기 조회</button>
        </form>
        <%
            }
        %>

        <form method="post" action="/D_airline/emp/flightManageAddAction.jsp">
            <select name="planeId">
                <%
                    if (selectAvailablePlaneList != null && !selectAvailablePlaneList.isEmpty() && request.getParameter("planeList") != null) {
                        for (HashMap<String, Object> m2 : selectAvailablePlaneList) {
                            int planeId = 0;
                            String planeName = null;
                            String stringPlaneId = null;

                            stringPlaneId = (String) (m2.get("stringPlaneId"));
                            planeId = (int) (m2.get("planeId"));
                            planeName = (String) (m2.get("planeName"));
                %>
                <option value="<%=planeId%>"><%=stringPlaneId%>/<%=planeName%></option>
                <%
                        }
                    }
                %>
            </select>
            <input type="hidden" name="intRouteId" value="<%=intRouteId%>">
            <input type="hidden" name="datetimeString" value="<%=datetimeString%>">
            <input type="hidden" name="flightDuration" value="<%=flightDuration%>">
            <button type="submit">항공편입력</button>
        </form>
    </div>










   <!-- /////항공편 수정///// -->
<div>
    <!-- 항공편 검색 폼 -->
    <form action="/D_airline/emp/flightManageSearchFlight.jsp" method="post">
        <% 
            // checkRoute 값이 "1"인지 확인하고 이에 따라 flightId 입력 필드를 설정
            if (request.getParameter("checkRoute") != null && checkRoute.equals("1")) { 
        %>
        <input type="number" name="flightId" placeholder="search flight ID(FL)" value="<%=flightId %>" disabled>
        <% 
            } else { 
        %>
        <input type="number" name="flightId" placeholder="search flight ID(FL)">
        <% 
            } 
        %>
        <button type="submit">항공편 검색</button>
    </form>
    
    
    
    
    
    <% 
        // 항공편 검색 후 checkRoute 값이 "1"인 경우
        if (request.getParameter("checkRoute") != null && checkRoute.equals("1") ) { 
    %>
    <!-- 항공편 수정 폼 -->
    <form action="/D_airline/emp/flightManageModifiedPlaneSearchAction.jsp" method="post">
        <select name="intRouteId">
            <% 
                // 검색된 모든 항공편 정보를 select 옵션으로 제공
                for (HashMap<String, Object> m3 : selectAllRouteCityCountryListSearchFirst) {
                    String routeId = (String) m3.get("routeId");
                    String departureCity = (String) m3.get("departureCity");
                    String arrivalCity = (String) m3.get("arrivalCity");
                    String departureCountry = (String) m3.get("departureCountry");
                    String arrivalCountry = (String) m3.get("arrivalCountry");
                    String departureAirport = (String) m3.get("departureAirport");
                    String arrivalAirport = (String) m3.get("arrivalAirport");
                    intRouteId = (Integer) m3.get("intRouteId");
            %>
            <option value="<%=intRouteId%>">
                <%=routeId%>///<%=departureCity%>/<%=departureCountry%>/<%=departureAirport%>
                ---<%=arrivalCity%>/<%=arrivalCountry%>/<%=arrivalAirport%>
            </option>
            <% 
                } 
            %>
        </select>
        <input type="hidden" name="flightId" value="<%=flightId%>">
        <input type="hidden" name="checkRoute" value="<%=checkRoute %>">
        <input type="datetime-local" name="datetimeString" value="<%=departureTimeLocal %>">
        <button>항공기 조회</button>
    
    
    
        <%
        for(HashMap<String, Object> m4 : selectRouteInfo){
        	String planeName = (String)(m4.get("planeName"));
        	%><input type="text" value="PL<%=flightId %>/<%=planeName %>" disabled>
       <% }
        %>
        
    
    
    
        
    </form>
    
    <% 	//항공기 조회 후 modifyPlaneList 값이 "1"인 경우
        }else if(request.getParameter("modifyPlaneList")!= null && modifyPlaneList.equals("1")){
        	%>
        <input type="text" value="FL<%=flightId %>" disabled>
         <select disabled>
            <% 
                // 검색된 모든 항공편 정보를 select 옵션으로 제공
                for (HashMap<String, Object> m3 : selectOneRouteCityCountryList) {
                    String routeId = (String) m3.get("routeId");
                    String departureCity = (String) m3.get("departureCity");
                    String arrivalCity = (String) m3.get("arrivalCity");
                    String departureCountry = (String) m3.get("departureCountry");
                    String arrivalCountry = (String) m3.get("arrivalCountry");
                    String departureAirport = (String) m3.get("departureAirport");
                    String arrivalAirport = (String) m3.get("arrivalAirport");
                    intRouteId = (Integer) m3.get("intRouteId");
            %>
            <option>
                <%=routeId%>///<%=departureCity%>/<%=departureCountry%>/<%=departureAirport%>
                ---<%=arrivalCity%>/<%=arrivalCountry%>/<%=arrivalAirport%>
            </option>
            <% 
                } 
            %>
        </select>
        
        <input type="datetime-local" value="<%=datetimeString%>" disabled>

  
    
    <form method="post" action="/D_airline/emp/flightManageModifyAction.jsp">
        <select name="planeId">
            <% 
                // 사용 가능한 항공기가 있는 경우 select 옵션으로 제공
                if (selectAvailablePlaneList != null && !selectAvailablePlaneList.isEmpty() && request.getParameter("modifyPlaneList") != null) {
                    for (HashMap<String, Object> m2 : selectAvailablePlaneList) {
                        int planeId = 0;
                        String planeName = null;
                        String stringPlaneId = null;

                        stringPlaneId = (String) m2.get("stringPlaneId");
                        planeId = (int) m2.get("planeId");
                        planeName = (String) m2.get("planeName");
            %>
            <option value="<%=planeId%>"><%=stringPlaneId%>/<%=planeName%></option>
            <% 
                    }
                } 
            %>
        </select>
        
        <input type="hidden" name="flightId" value="<%=flightId%>">
        <input type="hidden" name="intRouteId" value="<%=intRouteId%>">
        <input type="hidden" name="datetimeString" value="<%=datetimeString%>">
        <input type="hidden" name="flightDuration" value="<%=flightDuration%>">
        <button type="submit">항공편수정</button>
    </form>
    <% }%>
</div>



    <!-- ////항공편 삭제///// -->
    <form action="/D_airline/emp/flightManageDeleteAction.jsp" method="post">
        <div>
            <input type="number" name="flightId" placeholder="flight id(FL)" required>
            <button type="submit">항공편삭제</button>
        </div>
    </form>

    <div>
        <%=msg %>
        <table class="">
            <thead class="">
                <tr>
                    <th>항공편코드</th>
                    <th>행선지</th>
                    <th>노선코드</th>
                    <th>출발시각</th>
                    <th>도착시각</th>
                    <th>운항시간</th>
                    <th>항공기명</th>
                    <th>status</th>
                    <th>변경일자</th>
                    <th>생성일자</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (HashMap<String, Object> m3 : selectAllFlightList) {
                        String routeId = null;
                        String departureCity = null;
                        String arrivalCity = null;
                        String departureCountryName = null;
                        String arrivalCountryName = null;

                        routeId = (String) (m3.get("routeId"));
                        departureCity = (String) (m3.get("departureCity"));
                        arrivalCity = (String) (m3.get("arrivalCity"));
                        departureCountryName = (String) (m3.get("departureCountryName"));
                        arrivalCountryName = (String) (m3.get("arrivalCountryName"));
                %>
                <tr>
                    <td><%=(String)(m3.get("flightId"))%></td>
                    <td><%=departureCity%>/<%=departureCountryName%>---<%=arrivalCity%>/<%=arrivalCountryName%></td>
                    <td><%=routeId%></td>
                    <td><%=(String)(m3.get("departureTime"))%></td>
                    <td><%=(String)(m3.get("arrivalTime2"))%></td>
                    <td><%=(String)(m3.get("flightDuration"))%></td>
                    <td><%=(String)(m3.get("planeName"))%></td>
                    <td><%=(String)(m3.get("status"))%></td>
                    <td><%=(String)(m3.get("updateDate"))%></td>
                    <td><%=(String)(m3.get("createDate"))%></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
