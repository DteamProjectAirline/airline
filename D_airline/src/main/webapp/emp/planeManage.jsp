<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<select id="hour">
		<% 
		for(int i=0; i <24; i++){
		%>
		<option><%=i %></option>
		<% }%>
	</select>
		<label for ="hour">시간</label>
		<label>  &nbsp;: &nbsp; </label>
		
	<select id="minute">
		
		<%
		for(int i=0; i<12; i++){
			String e = Integer.toString(i*5);
			if(e.length() !=2){
				e = "0"+e;
			}
		%>
		<option><%=e %></option>
		<%} %>

	
		
		
		
	</select>
	<label for ="minute">분</label>

</body>
</html>