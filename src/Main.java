import java.io.File;
import java.io.IOException;
public class Main {

	public static void GenGrid (String grid)
	{
		try {
		      File myObj = new File("filename.pl");
		      
		      if (myObj.createNewFile()) {
		        System.out.println("File created: " + myObj.getName());
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
		GenGrid("Hi");
	}
}
