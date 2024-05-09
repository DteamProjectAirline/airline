<%@page import="dao.DBHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%
    Connection conn = DBHelper.getConnection() ;
	ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>> ();
	
	String sql = "SELECT city.city_name , city.airport , country.country_name FROM city LEFT OUTER JOIN country ON city.country_id = country.country_id;";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	
	while(rs.next()){
		HashMap<String,Object> a = new HashMap<String,Object>();
			a.put("cityName", rs.getString("city_name"));
			a.put("airport" , rs.getString("airport"));
			a.put("countryName" , rs.getString("country_name"));
			list.add(a);
	}
%>    
    
    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>


	<div class="container">
		<h1>코리아나 항공</h1>
		<form action="#"> <!-- 항공편리스트 조회 -->
			<!-- 출발지 , 도착지 입력   -->
			<input list="airport" name="departure" >
			<input list="airport" name="arrival">
			<datalist id="airport">
			<%for(HashMap<String,Object> b : list){ %>
				<option value="<%=(String)(b.get("cityName"))%>" >
				<%=(String) (b.get("countryName"))%>
				<%=(String) (b.get("airport"))%>
				</option>
			<%} %>	
			</datalist>
			<script>
  const arrivalInput = document.getElementById('arrivalInput');
  const airportList = document.getElementById('airport');

  // 표시되는 옵션 수 설정 (이 경우 5개)
  airportList.size = 5;
</script>
		</form>
	</div>



	

</body>
</html>