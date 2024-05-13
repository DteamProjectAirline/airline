package dao;

import java.sql.*;

import java.util.*;

//import org.mariadb.jdbc.message.client.ExecutePacket;

import dao.DBHelper;

public class QnaDAO {
	//QnA생성
	public static int qaInsert(String qna_id, String title, String content, String empId) throws Exception{
		int QaRow = 0;
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "INSERT INTO q&a(title, content, create_date, update_date)VALUES(?,?,now(),now())";
		stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, title);
		stmt.setString(2, content);
		rs = stmt.executeQuery();
		System.out.println(stmt+"<--qna생성");
		QaRow = stmt.executeUpdate();
		
		conn.close();
		return QaRow;
	}
	
	//QnA수정
	public static int qaModify(String qnaId, String title, String content) throws Exception{
		int QaRow = 0;
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "UPDATE q&a SET title=?, content=?, update_date=now() WHERE qna_id";
		stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, title);
		stmt.setString(2, content);
		stmt.setString(3, qnaId);
		rs = stmt.executeQuery();
		System.out.println(stmt+"<--qna수정");
		QaRow = stmt.executeUpdate();
		
		conn.close();
		return QaRow;
	}
	
	//QnA삭제
	public static int qaDelete(String qnaId, String title, String content, String empId) throws Exception{
		int QaRow = 0;
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "DELETE FROM q&a WHERE qna_id=?";
		stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, qnaId);
		rs = stmt.executeQuery();
		System.out.println(stmt+"<--qna삭제");
		QaRow = stmt.executeUpdate();
		
		conn.close();
		return QaRow = 0;
	}
	
	//QnA조회
	public static ArrayList<HashMap<String, Object>> qaList(int startRow, int rowPerPage) throws Exception{
		ArrayList<HashMap<String, Object>> qaList = new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT qna_id qnaId, title, content, create_date createDate, update_date updateDate FROM q&a LIMIT ?, ?";
		stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("qnaId", rs.getString("qnaId"));
			m.put("title", rs.getString("title"));
			m.put("content", rs.getString("content"));
			m.put("createDate", rs.getString("createDate"));
			m.put("updateDate", rs.getString("updateDate"));
			
			qaList.add(m);
		}
		conn.close();
		return qaList;
	}

}
