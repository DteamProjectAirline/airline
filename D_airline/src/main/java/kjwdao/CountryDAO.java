package kjwdao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import kjwdao.DBHelper;

public class CountryDAO {
	
	
	//SELECT문----------
	
	//모든 국가 정보 출력 - limit함수로 행수 제한  [param]- 시작페이지, 페이지당행수 변수값 받음
	public static ArrayList<HashMap<String, Object>> selectCountryList(int startPage, int rowPerPage)
			throws Exception {

		ArrayList<HashMap<String, Object>> selectCountryList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		
		String sql1 = "SELECT country_id countryId, country_name countryName, update_date updateDate, create_date createDate "
				+ "from country "
				+ "limit ?,?";

		PreparedStatement stmt = conn.prepareStatement(sql1);
		stmt.setInt(1, startPage);
		stmt.setInt(2, rowPerPage);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("countryId", rs.getString("countryId"));
			m.put("countryName", rs.getString("countryName"));
			m.put("updateDate", rs.getString("updateDate"));
			m.put("createDate", rs.getString("createDate"));

			selectCountryList.add(m);

		}
		System.out.println("selectCountryList(모든 국가 정보 출력 ) : " + selectCountryList);
		conn.close();

		return selectCountryList;
	}
	
	
	//모든 국가 정보 출력
	public static ArrayList<HashMap<String, Object>> selectAllCountryList()
			throws Exception {

		ArrayList<HashMap<String, Object>> selectAllCountryList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
	
		
		String sql = "SELECT concat('NA' ,country_id) as countryId, country_id countryIdNo, country_name countryName, "
				+ "update_date updateDate, create_date createDate "
				+ "from country";

		PreparedStatement stmt = conn.prepareStatement(sql);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("countryId", rs.getString("countryId"));
			m.put("countryName", rs.getString("countryName"));
			m.put("updateDate", rs.getString("updateDate"));
			m.put("createDate", rs.getString("createDate"));
			m.put("countryIdNo", rs.getString("countryIdNo"));

			selectAllCountryList.add(m);

		}
		System.out.println("selectAllCountryList(모든 국가 정보 출력) : " + selectAllCountryList);
		conn.close();

		return selectAllCountryList;
	}
	
	
	//전체 국가 행수(count함수) 출력위한 쿼리  - 페이지네이션에 사용
	public static ArrayList<HashMap<String, Object>> selectTotalCountryList()
			throws Exception {

		ArrayList<HashMap<String, Object>> selectTotalCountryList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		

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
	
	
	//INSERT문----------
	
	//국가 입력(insert)  - [param]- 새로 입력하려는 국가명 변수값 받음
	public static int insertCountry(String countryName)
			throws Exception {

		int insertCountry = 0;

		Connection conn = DBHelper.getConnection();
		
		String sql = "INSERT INTO country(country_name, update_date, create_date) VALUES(? , now(), now())";

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
	
	
	//UPDATE문----------
	
	//국가 정보변경(update)  - [param]- 새로 변경하려는 국가명, countryId(변경하려는 국가 특정하기 위함)
	public static int updateCountry(String countryName, String countryId)
			throws Exception {

		int updateCountry = 0;

		Connection conn = DBHelper.getConnection();
	
		String sql = "update country set country_name = ?, update_date = now() WHERE country_id = ? "; 

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
	
	
	//DELETE문----------
	
	//국가 삭제(delelte)  - [param]- countryId(DB삭제하려는 국가 특정하기 위함)
	public static int deleteCountry(String countryId)
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
