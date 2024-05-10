package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import dao.DBHelper;

public class CityDAO {
	
	
	
	public static ArrayList<HashMap<String, Object>> selectCityList (int startPage, int rowPerPage)
			throws Exception {

		ArrayList<HashMap<String, Object>> selectCityList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		// 긴 문자열 자동 줄바꿈 ctrl + enter

		//
		String sql1 = "SELECT ct.city_name cityName, ct.country_id countryId, ct.airport airport, na.country_name countryName from city ct INNER JOIN country na limit ?,?";

		PreparedStatement stmt = conn.prepareStatement(sql1);
		stmt.setInt(1, startPage);
		stmt.setInt(2, rowPerPage);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("cityName", rs.getString("cityName"));
			m.put("countryId", rs.getString("countryId"));
			m.put("airport", rs.getString("airport"));
			m.put("countryName", rs.getString("countryName"));

			selectCityList.add(m);

		}
		System.out.println("selectCityList(city테이블 리스트) : " + selectCityList);
		conn.close();

		return selectCityList;
	}
	
	
	
	public static ArrayList<HashMap<String, Object>> selectTotalCityList ()
			throws Exception {

		ArrayList<HashMap<String, Object>> selectTotalCityList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		// 긴 문자열 자동 줄바꿈 ctrl + enter

		//
		String sql1 = "select count(*) cnt from city order by city_name";

		PreparedStatement stmt = conn.prepareStatement(sql1);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("cnt", rs.getInt("cnt"));
		
			selectTotalCityList.add(m);

		}
		System.out.println("selectTotalCityList(city테이블 전체 리스트) : " + selectTotalCityList);
		conn.close();

		return selectTotalCityList;
	}

}
