package dao;
import java.io.FileReader;
import java.sql.*;
import java.util.Properties;


public class DBHelper {
	public static Connection getConnection() throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		
		//로컬 pc의 Properties 파일 읽어오기
		FileReader fr = new FileReader("c:\\mariadb.properties"); 
		Properties prop = new Properties();
		prop.load(fr);
	
		
		String db = prop.getProperty("db");
		String id = prop.getProperty("id");
		String pw = prop.getProperty("pw");
		
		Connection conn = DriverManager.getConnection(db,id,pw);
		
		return conn;
	}
}