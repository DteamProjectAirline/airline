package kjwdao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import kjwdao.DBHelper;

public class CityDAO {
	
	//SELECT문----------
	
	//도시 정보 출력(국가와 도시 inner조인) - limit함수로 행수 제한  [param]- 시작페이지, 페이지당행수 변수값 받음
	public static ArrayList<HashMap<String, Object>> selectCityList(int startPage, int rowPerPage)
			throws Exception {

		ArrayList<HashMap<String, Object>> selectCityList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		

		String sql1 = "SELECT ct.city_name cityName, ct.country_id countryId, ct.airport airport,  ct.update_date updateDate,  "
				+ "ct.create_date createDate, na.country_name countryName "
				+ "from city ct INNER JOIN country na ON ct.country_id = na.country_id "
				+ "limit ?,? ";

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
			m.put("updateDate", rs.getString("updateDate"));
			m.put("createDate", rs.getString("createDate"));

			selectCityList.add(m);

		}
		System.out.println("selectCityList(국가와 도시 inner조인 쿼림) : " + selectCityList);
		conn.close();

		return selectCityList;
	}
	
	
	//모든 도시 정보 출력(국가와 도시 inner조인) - 서울을 도시목록 맨 상단으로 배치
	public static ArrayList<HashMap<String, Object>> selectAllCityList()
			throws Exception {

		ArrayList<HashMap<String, Object>> selectAllCityList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT ct.city_name cityName, ct.country_id countryId, ct.airport airport, na.country_name countryName, ct.update_date updateDate, ct.create_date createDate "
				+ "from city ct INNER JOIN country na ON ct.country_id = na.country_id "
				+ "ORDER BY (ct.city_name = '서울') desc, ct.country_id ";

		PreparedStatement stmt = conn.prepareStatement(sql);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("cityName", rs.getString("cityName"));
			m.put("countryId", rs.getString("countryId"));
			m.put("airport", rs.getString("airport"));
			m.put("countryName", rs.getString("countryName"));
			m.put("updateDate", rs.getString("updateDate"));
			m.put("createDate", rs.getString("createDate"));

			selectAllCityList.add(m);

		}
		System.out.println("selectAllCityList(모든 도시 정보 출력-국가와 도시 inner조인) : " + selectAllCityList);
		conn.close();

		return selectAllCityList;
	}
	
	
	//전체 도시 행수(count함수) 출력위한 쿼리  - 페이지네이션에 사용
	public static ArrayList<HashMap<String, Object>> selectTotalCityList()
			throws Exception {

		ArrayList<HashMap<String, Object>> selectTotalCityList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		

		String sql1 = "select count(*) cnt from city order by city_name";

		PreparedStatement stmt = conn.prepareStatement(sql1);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("cnt", rs.getInt("cnt"));
		
			selectTotalCityList.add(m);

		}
		System.out.println("selectTotalCityList(전체 도시 행수(count함수) 출력위한 쿼리) : " + selectTotalCityList);
		conn.close();

		return selectTotalCityList;
	}
	
	
	//INSERT문----------
	
	//도시 DB에 입력(insert)실행 쿼리 - [param]- 도시명, 국가ID, 공항명 변수값 받음
	public static int insertCity(String cityName, String countryId, String airport)
			throws Exception {

		int insertCity = 0;

		Connection conn = DBHelper.getConnection();
		
		String sql = "INSERT INTO city(city_name, country_id, airport, update_date, create_date) VALUES(?, ?, ?, now(), now())";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, cityName);
		stmt.setString(2, countryId);
		stmt.setString(3, airport);
		
		insertCity = stmt.executeUpdate();
		
		if (insertCity == 1) {

			System.out.println("도시 신규 등록에 성공하였습니다.");

		} else {
			System.out.println("도시 신규등록에 실패하였습니다");
		}

		return insertCity;
	}
	
	//UPDATE문----------
	
	
	//도시 정보 변경(update) 쿼리  [param]- 도시명, 국가ID, 공항명, keyCityName(변경하려는 기존 도시명) 변수값 받음
	public static int updateCity(String cityName, String countryId, String airport, String keyCityName)
			throws Exception {

		int updateCity = 0;

		Connection conn = DBHelper.getConnection();
	
		String sql = "update city set city_name = ? ,  country_id =  ? ,  airport= ? , update_date = now()  WHERE city_name = ? "; 

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, cityName);
		stmt.setString(2, countryId);
		stmt.setString(3, airport);
		stmt.setString(4, keyCityName);
		
		updateCity = stmt.executeUpdate();
		
		if (updateCity == 1) {

			System.out.println("도시 정보변경에 성공하였습니다.");

		} else {
			System.out.println("도시 정보변경에 실패하였습니다");
		}

		return updateCity;
	}
	
	
	//DELETE문----------
	
	
	//도시 삭제(delete) 쿼리  [param]- 도시명 변수값 받음
	
	public static int deleteCity(String cityName)
			throws Exception {

		int deleteCity = 0;

		Connection conn = DBHelper.getConnection();
	
		String sql = "DELETE FROM city WHERE city_name = ? ";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, cityName);
	
		deleteCity = stmt.executeUpdate();
		
		if (deleteCity == 1) {

			System.out.println("도시 삭제에 성공하였습니다.");

		} else {
			System.out.println("도시 삭제에 실패하였습니다");
		}

		return deleteCity;
	}

}
