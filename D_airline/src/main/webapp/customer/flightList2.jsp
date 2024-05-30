<%@page import="sjwdao.FlightListDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="javax.naming.spi.DirStateFactory.Result"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*" %>
<%@page import="kjwdao.DBHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// main 에서 검색값 받아옴.
String type = request.getParameter("type"); //왕복편도
String departureLocation = request.getParameter("departureLocation"); //출발지
String arrivalLocation = request.getParameter("arrivalLocation"); // 도착지 or 복귀공항
String departDate = request.getParameter("departDate");  //출발일
String comeBackDate = request.getParameter("comeBackDate"); // 돌아오는날
String selectedSeatGrade1 = request.getParameter("selectedSeatGrade1");
String flightId1 = request.getParameter("flightId1");
// grade 아님 grade별 가격임
String flight_grade = request.getParameter("flight_grade");
/* System.out.println(type+"왕복,편도");
System.out.println(departureLocation+"출발지");
System.out.println(arrivalLocation+"도착지");
System.out.println(departDate+"출발일");
System.out.println(comeBackDate+"복귀일 편도면 null임.");
System.out.println(arrivalLocation.equals("")); */

if(type == "" || departureLocation == "" || arrivalLocation == "" || type == null || departureLocation == null || arrivalLocation == null)
{
	response.sendRedirect("/D_airline/customer/flightMain.jsp?");
}
	
// 항공편 리스트 불러오는 메소드;
ArrayList<HashMap<String,Object>> list = FlightListDAO.flightList(arrivalLocation,departureLocation, comeBackDate);

%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="../css/css_flightList.css">
</head> 
<body>
<nav class="navbar bg-body-tertiary" style="padding-top:0px; padding-bottom: 0px; padding-left:0px; ">
	  <div class="container-fluid">
		  <div>	
		  	<a href="/D_airline/customer/flightMain.jsp">
				<img src="/D_airline/img/KOREANA (3).png" style="height:75px; width: 400px;">
			</a>		    
		  </div>
		  <div style="padding-top: 40px; padding-right: 150px;">
		  	<a href="/D_airline/customer/qnaList.jsp" style="font-size: 1.6rem; line-height: 1.5;"> q&a페이지</a>
		  </div>
		  <div style="padding-top: 40px;">
		    	<!-- 로그인 상태면 고객아이디 , 로그인상태가 아니면 로그인버튼 표시-->
		    	<%if(session.getAttribute("loginCs") != null){	    	
		    	%>
		    	  		<!-- 세션에서 사용자 name 값 꺼내옴 -->
		    	  		<div style="display: flex">
		    	  			    	  		
		    	  		 <a href="/D_airline/customer/myPage.jsp">myPage</a>
		    	  		
		    	  		</div>
		    	<% 
		    	} else{
		    	%>
				<a href="/D_airline/customer/loginForm.jsp">로그인</a>
				<a href="/D_airline/customer/addMembership.jsp">회원가입</a>   
				<%
		    		}
				%>
				
	  	  </div>	
	  </div>
	</nav>
<div>
	가는 편 <%=departureLocation%> -> <%=arrivalLocation %> 
</div>
	
 	<div style="width: 1300px; margin-left:300px; ">	
	<ul style="list-style: none; width: 100%; height: 160px;">
		<%int i = 0; %>
		<%for(HashMap<String,Object> e : list) {
			i = i + 1 ;
		String flightNameId = "flightName"+i;
		//System.out.println(i);
		
		String departureTime = (String) (e.get("departureTime"));
		String arrivalTime = (String) (e.get("arrivalTime"));
		String flightDuration = (String) (e.get("flightDuration"));
		int flightId = (int) (e.get("flight_id"))
				;
		// 항공기별 좌석잔여개수 div 가 반복돼서 for each 사용불가. 단일값을 하나씩 꺼내야함.
		//System.out.println(flightId +"<flight");
		ArrayList<HashMap<String,Object>> seatNum = FlightListDAO.asdas(flightId);
			//System.out.println(seatNum.get(0).get("cnt"));
			// 등급비율별로 root 기본요금에 등급별요금(double)을 곱해서  인트형으로 반환.
		int ecoSeatPrice = (int) ((int) (e.get("baseFare"))*(double) (seatNum.get(0).get("seatPrice")));
		int busSeatPrice = (int) ((int) (e.get("baseFare"))*(double) (seatNum.get(1).get("seatPrice")));
		int firstSeatPrice = (int) ((int) (e.get("baseFare"))*(double) (seatNum.get(2).get("seatPrice")));
		int flight1Price = 0; 
		if(selectedSeatGrade1.equals(seatNum.get(0).get("seatGrade"))){
			flight1Price = ecoSeatPrice;
		} else if (selectedSeatGrade1.equals(seatNum.get(1).get("seatGrade"))){
			flight1Price = busSeatPrice;
		} else if (selectedSeatGrade1.equals(seatNum.get(2).get("seatGrade"))){
			flight1Price = firstSeatPrice;
		}
		%>
		
		<!-- if로 분기 왕복일때와 편도일때 form action을 다르게해서 분기함. -->
		
		<form id="flightForm<%=i%>" method="POST" action="/D_airline/customer/seatSelection.jsp">
		
			<li style="display: flex ;margin: 32px 0 64px; border: 10px; border-radius: 2rem;height: 180px;">
				<div class="flightBorder">
					<div class="flightContent">
					<!--  date와 datetime 형식을 시간과분만 나오게 subString으로 처리함.-->
					<div style="text-align: center;">비행시간:<%=flightDuration.substring(0,2)%>시간<%=flightDuration.substring(3,5)%>분
					</div>
					<div style="text-align: center;">-------------></div>
						<div style="display: flex;">
							<div style="flex:1; display: flex; flex-direction: column; align-items: start;">
								<span style="font-size: 24px;line-height: 1.5;">
								<%=departureTime.substring(10,16)%><!-- 출발시간 -->
								</span>
								<div><%=(String) (e.get("departureCity" ))%></div><!-- 출발도시 -->
							
							</div>
							<div style="flex:1; display: flex; flex-direction: column; align-items: end" >
								<span style="font-size: 24px;line-height: 1.5;">
								<!-- 도착시간  -->
								<%=arrivalTime.substring(10,16)%>
								</span> 
								<div><%=(String) (e.get("arrivalCity"))%></div>  <!-- 도착도시 -->
							</div>
									
						</div>
						<div id="<%=flightNameId %>" style="margin-top: 5px;">
						<%=(String) (e.get("planeName"     ))%> <!-- 비행기명 -->
						<%=(String) (e.get("airLine"       ))%> <!-- 항공사명 -->
						</div>
					</div>
				</div>
				
				<!-- 라디오버튼 div == 노선 가격 + 좌석등급 + 선택 -->
				<div style="display:flex; border: 1px solid #d9dbe1; border-bottom-right-radius:20px;border-top-right-radius:20px; width: 100%; margin-right: 100px;">
						
						<div class="flightTopBorder">
							<label style="width: 100%" for="selectEconomy<%=i%>">
							<input type="radio" style="opacity: 0" id="selectEconomy<%=i%>" name="flight_grade" value="<%=ecoSeatPrice+flight1Price%>" data-seat-grade="<%=(String) (seatNum.get(0).get("seatGrade"))%>">
								<div class="priceBorder" style="margin-top: 20px;">
									<div>
									<%=(String) (seatNum.get(0).get("seatGrade"))%> <!-- 좌석등급 -->
									</div>
									<div style="font-size: 24px;line-height: 1.5;">
									<%=ecoSeatPrice%>원	<!-- 일반석 가격 -->
									</div>
									<div>잔여좌석:<%=(seatNum.get(0).get("cnt"))%></div>
								</div>
							</label>					
						</div>
						
					
					<div class="flightTopBorder">
						<label style="width: 100%" for="selectBusiness<%=i%>" >
							<input type="radio" style="opacity: 0;" name="flight_grade" id="selectBusiness<%=i%>" value="<%=busSeatPrice+flight1Price%>"data-seat-grade="<%=(String) (seatNum.get(1).get("seatGrade"))%>">
							<div class="priceBorder">
								<div>
								<%=(String) (seatNum.get(1).get("seatGrade"))%>
								</div>
								<div style="font-size: 24px;line-height: 1.5;">
								<%=busSeatPrice%>원	
								</div>
								<div>잔여좌석<%=(seatNum.get(1).get("cnt"))%></div>
							</div>	
						</label>	
					</div>
					
					<div class="flightRightBorder" >
						<label style="width: 100%" for="selectFirst<%=i%>">
							<input type="radio"  style="opacity: 0;" name="flight_grade" id="selectFirst<%=i%>" value="<%=firstSeatPrice+flight1Price%>"data-seat-grade="<%=(String) (seatNum.get(2).get("seatGrade"))%>">
							<div class="priceBorder">
								<div>
								<%=(String) (seatNum.get(2).get("seatGrade"))%>
								</div>
								<div style="font-size: 24px;line-height: 1.5;">
								<%=firstSeatPrice%>원
								</div>
								<div>잔여좌석:<%=(seatNum.get(2).get("cnt"))%></div>
							</div>		
						</label>
					</div>
				</div>
				<!-- 넘기고 싶은 데이터 히든으로 처리. -->
				<!-- 출발지 항공편 아이디값 depart-->
				<input type="hidden" name="flightId1" value="<%=flightId1%>">
				<!-- 도착지에서 출발하는 항공편 아이디값 arrival -->
				<input type="hidden" name="flightId2" value="<%=flightId%>">
				<!-- 출발지 항공편 좌석 등급.  -->
				<input type="hidden" name="selectedSeatGrade1" value="<%=selectedSeatGrade1%>">
				<!-- 도착지 항공편 좌석 등급.-->
				<input type="hidden" name="selectedSeatGrade2" id="selectedSeatGrade<%=i%>">
				<input type="hidden" name="type" value="<%=type%>">
				<!-- 출도착 지역 -->
				<input type="hidden" name="departureLocation" value="<%=departureLocation%>">
				<input type="hidden" name="arrivalLocation" value="<%=arrivalLocation%>">
				
				
				

				
				
			</li>
		</form>		
		<%} %>
	</ul>
	</div>

	<!-- 하단 nav바 -->
<nav class="navbar bg-body-tertiary fixed-bottom shadow-lg  bg-body-tertiary rounded" style="height: 80px;">
		  <div class="container-fluid">
		    <a class="navbar-brand">Navbar</a>
		    	
		      <div style="line-height:1.5; padding-top:12px;font-size:30px;color:#00256c;" id="selectedFlightName">항공편을 선택해주세요</div>
		      <div style="line-height:1.5; padding:12px;font-size: 30px;color:#00256c;" id="selectedSeatPrice">총액<%=flight_grade%>원</div>
		      
		      <div style="padding-top:10px;">
		      <button type="submit" id="nextPageButton" class="btn btn-primary btn-lg" style="margin-right:200px; width: 175px; height:50px;background-color:#00256c;">다음여정</button>
		      </div>	
		  </div>
		</nav>


 <script>
 let selectedForm = null;

 const radioButtons = document.querySelectorAll('input[type=radio]');
 radioButtons.forEach((radioButton) => {
     radioButton.addEventListener('change', function(event) {
         // 선택된 라디오 버튼의 값을 가져옴
         const selectedValue = radioButton.value;
      	 // 선택된 좌석 등급을 가져옴
         const selectedSeatGrade = radioButton.dataset.seatGrade;
         
         // 선택된 항공편 이름을 가져옴
         const selectedFlightName = document.getElementById('flightName' + radioButton.id.match(/\d+$/)[0]).textContent;
         // 선택된 좌석의 가격을 표시할 요소를 찾음
         const priceDisplayElement = document.getElementById('selectedSeatPrice');
         // 선택된 항공편 이름을 표시할 요소를 찾음
         const flightNameDisplayElement = document.getElementById('selectedFlightName');
         // 선택된 좌석의 가격을 업데이트
         priceDisplayElement.textContent =  "총액"+selectedValue + "원";
         // 선택된 항공편 이름을 업데이트
         flightNameDisplayElement.textContent = selectedFlightName;
      	 // 선택된 좌석 등급을 폼에 저장
         const seatGradeInput = document.getElementById('selectedSeatGrade' + radioButton.id.match(/\d+$/)[0]);
      	 console.log(seatGradeInput);
         seatGradeInput.value = selectedSeatGrade;
         // 선택된 폼을 저장
         selectedForm = document.getElementById('flightForm' + radioButton.id.match(/\d+$/)[0]);
     });
 });

 document.getElementById('nextPageButton').addEventListener('click', function() {
     // 선택된 폼이 있으면 제출
     if(selectedForm){
         selectedForm.submit();
     }
 });
</script>
	
</body>
</html>