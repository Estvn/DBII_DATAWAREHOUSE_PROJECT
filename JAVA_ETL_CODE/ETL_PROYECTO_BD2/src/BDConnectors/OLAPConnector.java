package BDConnectors;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Class that contains a method created to make a connection with the DB where all the ETL objects are stored.
 * 
 * @since 2024/11/30
 * @version 0.0.1
 */
public class OLAPConnector {
	
	Connection olapConnection;
	
	public OLAPConnector() {
		olapConnection = null;
	}
	
	public Connection connectToOlap() throws ClassNotFoundException, SQLException {
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		
		try {
			
			olapConnection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "C##_OLAP_ADMIN_DBII_PROJECT", "123");
			System.out.println("Connected\n");
			return olapConnection;
			
		} catch (SQLException e) {
			
			System.out.println("Connection failed: " + e.getMessage());
			throw e;
		}
	}
}
