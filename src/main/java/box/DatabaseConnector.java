package box;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Locale;


public class DatabaseConnector {
	
	private static final String DB_URL = "jdbc:mysql://avnadmin:AVNS_ulJE6yjjhpfvRhKOlIo@mysql-311964e8-brandonmarquez505-6c36.h.aivencloud.com:20722/defaultdb?";
	private static final String DB_USER = "avnadmin";
	private static final String DB_PASSWORD = "AVNS_ulJE6yjjhpfvRhKOlIo";

	public static void main(String[] args) throws ClassNotFoundException {
		  String host = "mysql-311964e8-brandonmarquez505-6c36.h.aivencloud.com";
	        String port = "20722";
	        String databaseName = "defaultdb";
	        String userName = "avnadmin";
	        String password = "AVNS_ulJE6yjjhpfvRhKOlIo";
	    for (int i = 0; i < args.length - 1; i++) {
	      switch (args[i].toLowerCase(Locale.ROOT)) {
	        case "-host": host = args[++i]; break;
	        case "-username": userName = args[++i]; break;
	        case "-password": password = args[++i]; break;
	        case "-database": databaseName = args[++i]; break;
	        case "-port": port = args[++i]; break;
	      }
	    }
	    try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
	    
	    // JDBC allows to have nullable username and password
	    if (host == null || port == null || databaseName == null) {
	      System.out.println("Host, port, database information is required");
	      return;
	    }
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    try (final Connection connection =
	                DriverManager.getConnection("jdbc:mysql://" + host + ":" + port + "/" + databaseName + "?sslmode=YES", userName, password);
	         final Statement statement = connection.createStatement();
	         final ResultSet resultSet = statement.executeQuery("SELECT version() AS version")) {

	      while (resultSet.next()) {
	        System.out.println("Version: " + resultSet.getString("version"));
	      }
	    } catch (SQLException e) {
	      System.out.println("Connection failure.");
	      e.printStackTrace();
	    }
	  }
}