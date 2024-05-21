<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%
	HashMap<String,Object> loginMember = (HashMap<String,Object>)(session.getAttribute("loginCustomer"));
	if(session.getAttribute("loginCustomer") != null) {
		loginMember = (HashMap<String, Object>)(session.getAttribute("loginCustomer"));	
	}
%>

