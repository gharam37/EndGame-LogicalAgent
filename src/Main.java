import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
public class Main {

	public static void GenGrid (String grid)
	{
		try {
			
		      File myObj = new File("KB.pl");

		      
		      if (myObj.createNewFile()) {
		        System.out.println("File created: " + myObj.getName());
			      String[] parts = grid.split(";");
			      
					
				String Dimension="limits("+Integer.parseInt(parts[0].split(",")[0])+","+
						Integer.parseInt(parts[0].split(",")[1])+").";
				
				System.out.println(Dimension);
				String IronMan="ironman("+Integer.parseInt(parts[1].split(",")[0])+","+
						Integer.parseInt(parts[1].split(",")[1])+",0,s).";
				String thanos="thanos("+Integer.parseInt(parts[2].split(",")[0])+","+
						Integer.parseInt(parts[2].split(",")[1])+",s).";
				
				
				BufferedWriter writer = new BufferedWriter(new FileWriter("KB.pl"));
				writer.append(Dimension);
				writer.append("\n");
				writer.append(IronMan);
				writer.append("\n");
				writer.append(thanos);
				
				
				String[] StonesStrings = parts[3].split(",");
		    	for(int i=0;i+1<StonesStrings.length;i+=2)
		    	{
		    		String stone="stone("+Integer.parseInt(StonesStrings[i])+","+
		    				Integer.parseInt(StonesStrings[i+1])+",s).";
		    		writer.append("\n");
					writer.append(stone);
		    		
		    	}

				
				writer.close();

						

		      } else {
		        System.out.println("File already exists.");
		      }
		    } catch (IOException e) {
		      System.out.println("An error occurred.");
		      e.printStackTrace();
		    }
		
	
	}

	
	
	public static void main(String[]args) {
		System.out.println("Hello");
		GenGrid("5,5;1,2;3,4;1,1,2,1,2,2,3,3");
	}
}
