package ETLProcessors;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * Class used to execute the ETL to all the OLTP DB tables.
 * 
 * @since 2024/12/01
 * @version 0.0.3
 */
public class EtlsExecutor {

	// An static array variable that storage the SP names.
	public static final String[] STORAGE_PROCEDURE_LIST = {
			"{call PK_ETL_CANCIONES.SP_INSERTAR_CANCIONES(?,?)}",
			"{call PK_ETL_TIEMPO.SP_INSERTAR_TIEMPOS(?,?)}",
			"{call PK_ETL_ARTISTAS.SP_INSERTAR_ARTISTAS(?,?)}",
			"{call PK_ETL_USUARIOS.SP_INSERTAR_USUARIOS(?,?)}",
			"{call PK_ETL_PLANES.SP_INSERTAR_PLANES(?,?)}",
			"{call PK_HECHOS_REPRODUCCIONES.SP_INSERTAR_REPRODUCCIONES(?,?)}"
			};
	
	String storageProcedureResponse, returnedResponse;
	
	public String etlsExecuter(Connection connection) {
		
		// Creating a instance to the file that we use to get the querys to the origin table
        File file = new File("querysFile.csv");
        int i = 0;
        String queryFromCsv;
		
		for(String storageProdecure: STORAGE_PROCEDURE_LIST) {
			
			 try (CallableStatement stmt = connection.prepareCall(storageProdecure)) {
				 
				queryFromCsv = QuerysFileReader.readQueryFile(file.getAbsolutePath() ,i).replace("\"", "").replace("''", "'");
				 
				// Inserting the params to the SP
				stmt.setString(1, queryFromCsv);
				stmt.registerOutParameter(2, java.sql.Types.VARCHAR);   
	            stmt.execute();
                
                // Retrieves the value that returns the procedure.
                storageProcedureResponse = stmt.getString(2);
                
                System.out.println(storageProcedureResponse);
                
                if (!storageProcedureResponse.contains("CORRECTAMENTE.")) {
                	
                	returnedResponse = "An ETL hasn't finalized correctly. Stopping ETL...";
                    break;
                }
                
                returnedResponse = "\nETL process finalized without errors.\nCheck the OLAP DB to see the new values inserted in the tables.";
                
			 } catch (SQLException e) {
	                e.printStackTrace();
	                return "An error has ocurred: " + storageProdecure;
	         }	
			 
			 i++;
		}
		
		return returnedResponse;
	}
}
