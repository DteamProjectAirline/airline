package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import dao.DBHelper;

public class CountryDAO {
	
	
	
	public static ArrayList<HashMap<String, Object>> selectCountryList (int startPage, int rowPerPage)
			throws Exception {

		ArrayList<HashMap<String, Object>> selectCountryList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		// 긴 문자열 자동 줄바꿈 ctrl + enter

		//
		String sql1 = "SELECT country_id countryId, country_name countryName, update_date updateDate, create_date createDate from country limit ?,?";

		PreparedStatement stmt = conn.prepareStatement(sql1);
		stmt.setInt(1, startPage);
		stmt.setInt(2, rowPerPage);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("CountryId", rs.getString("CountryId"));
			m.put("countryName", rs.getString("countryName"));
			m.put("updateDate", rs.getString("updateDate"));
			m.put("createDate", rs.getString("createDate"));

			selectCountryList.add(m);

		}
		System.out.println("selectCountryList(country테이블 리스트) : " + selectCountryList);
		conn.close();

		return selectCountryList;
	}
	
	
	public static ArrayList<HashMap<String, Object>> selectAllCountryList ()
			throws Exception {

		ArrayList<HashMap<String, Object>> selectAllCountryList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		// 긴 문자열 자동 줄바꿈 ctrl + enter

		//
		String sql = "SELECT concat('NA' ,country_id) as countryId, country_name countryName, update_date updateDate, create_date createDate from country";

		PreparedStatement stmt = conn.prepareStatement(sql);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("countryId", rs.getString("countryId"));
			m.put("countryName", rs.getString("countryName"));
			m.put("updateDate", rs.getString("updateDate"));
			m.put("createDate", rs.getString("createDate"));

			selectAllCountryList.add(m);

		}
		System.out.println("selectAllCountryList(Country테이블 전체도시 리스트) : " + selectAllCountryList);
		conn.close();

		return selectAllCountryList;
	}
	
	
	
	public static ArrayList<HashMap<String, Object>> selectTotalCountryList ()
			throws Exception {

		ArrayList<HashMap<String, Object>> selectTotalCountryList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		// 긴 문자열 자동 줄바꿈 ctrl + enter

		//
		String sql1 = "select count(*) cnt from country order by country_id";

		PreparedStatement stmt = conn.prepareStatement(sql1);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("cnt", rs.getInt("cnt"));
		
			selectTotalCountryList.add(m);

		}
		System.out.println("selectTotalCountryList(Country테이블 전체 리스트) : " + selectTotalCountryList);
		conn.close();

		return selectTotalCountryList;
	}
	
	
	public static int insertCountry (String countryName)
			throws Exception {

		int insertCountry = 0;

		Connection conn = DBHelper.getConnection();
		// 긴 문자열 자동 줄바꿈 ctrl + enter

		//
		String sql = "INSERT INTO country(country_name) VALUES(?)";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, countryName);
		
		
		insertCountry = stmt.executeUpdate();
		
		if (insertCountry == 1) {

			System.out.println("국가 신규 등록에 성공하였습니다.");

		} else {
			System.out.println("국가 신규등록에 실패하였습니다");
		}

		return insertCountry;
	}
	
	

	public static int updateCountry (String countryName, String countryId)
			throws Exception {

		int updateCountry = 0;

		Connection conn = DBHelper.getConnection();
	
		String sql = "update country set country_name = ? WHERE country_id = ? "; 

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, countryName);
		stmt.setString(2, countryId);
	
		
		updateCountry = stmt.executeUpdate();
		
		if (updateCountry == 1) {

			System.out.println("국가 정보변경에 성공하였습니다.");

		} else {
			System.out.println("국가 정보변경에 실패하였습니다");
		}

		return updateCountry;
	}
	
	

	public static int deleteCountry (String countryId)
			throws Exception {

		int deleteCountry = 0;

		Connection conn = DBHelper.getConnection();
	
		String sql = "DELETE FROM country WHERE country_id = ? ";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, countryId);
	
		deleteCountry = stmt.executeUpdate();
		
		if (deleteCountry == 1) {

			System.out.println("국가 삭제에 성공하였습니다.");

		} else {
			System.out.println("국가 삭제에 실패하였습니다");
		}

		return deleteCountry;
	}

}
