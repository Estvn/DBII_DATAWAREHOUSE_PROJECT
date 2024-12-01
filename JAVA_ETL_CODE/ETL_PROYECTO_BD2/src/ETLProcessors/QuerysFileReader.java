package ETLProcessors;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;


/**
 * A class used to initialize the read to the .csv file that contains all the querys we send to the SP params.
 * 
 * @version 0.0.1
 * @since 2024/11/29
 */
public class QuerysFileReader {
	
	public static String readQueryFile(String path, int queryNumber) {
		
		try(BufferedReader br = new BufferedReader(new FileReader(path))){
			
			String lineContent;
			int index = 0;
			
			while((lineContent = br.readLine()) != null) {
				
				if(index == queryNumber) {
					
					return lineContent;
				}
				index++;
			}
			return "The position " + queryNumber + "not exist in the file";
		
		}catch(IOException e) {
			
			return e.getMessage();
		}	
	}
}
