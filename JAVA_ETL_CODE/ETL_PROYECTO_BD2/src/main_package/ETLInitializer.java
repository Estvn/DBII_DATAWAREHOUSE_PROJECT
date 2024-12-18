package main_package;

import java.sql.Connection;
import java.sql.SQLException;
import BDConnectors.OLAPConnector;
import ETLProcessors.EtlsExecutor;

/**
 * Main class where the user will initialize the ETL.
 * 
 * @since 2024/11/30
 * @version 0.0.2
 */
public class ETLInitializer {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		
		// Initializing connection with the DB.
		System.out.println("Trying to connect with the database...");
		OLAPConnector olap = new OLAPConnector();
		Connection c =(Connection) olap.connectToOlap();
		
		// Calling the method who has the ETLs execution.
		EtlsExecutor etlsExecutor = new EtlsExecutor();
		System.out.println(etlsExecutor.etlsExecuter(c));
		
	}
}
