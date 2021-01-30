package connection;

import java.sql.*;
public class ConnectDatabase {
	static Connection cn= null;
	static String driver="com.mysql.jdbc.Driver";
	static String url="jdbc:mysql://" + "localhost" + ":3306/" + "mydb";
	static String user="root";
	static String pass="";
	public static Connection getCn() throws Exception{
		Class.forName(driver);
		cn=DriverManager.getConnection(url,user,pass);
		return cn;
	}
}
