import java.io.File;
import java.io.FileNotFoundException;
import java.util.HashMap;
import java.util.Scanner;

public class Evaluation {


	public static void main(String[] args) throws FileNotFoundException {
	
		File pred=new File(args[0]);
		File val=new File(args[1]);
		
		double tp=0.0,tn=0.0,fp=0.0,fn=0.0,total=0.0;
		
		Scanner vs=new Scanner(val);
		Scanner ps=new Scanner(pred);
		
		HashMap<String,String> prediction=new HashMap<String,String>();
		
		while(ps.hasNext())
		{
			String[] line=ps.nextLine().split("\t");
			prediction.put(line[0],line[1]);
		}
		ps.close();
		
		while(vs.hasNext())
		{
			String[] line=vs.nextLine().split(",");
			if(prediction.containsKey(line[0]))
			{
				//Predicted delayed
				if(prediction.get(line[0]).equals("TRUE"))
				{
					//validation delayed
					if(line[1].equals("TRUE"))
						tp++;
					else
						fp++;
					//validation not delayed
				}
				//Predicted not delayed
				else
				{
					//validation delayed
					if(line[1].equals("TRUE"))
						fn++;
					else
						tn++;
					//validation not delayed
				}
				total++;
			}
		}
		vs.close();
		
		
		System.out.println("tp"+tp+"fp"+fp+"fn"+fn+"tn"+tn+"tot"+total);
		
		System.out.println("Precision: "+(tp/(tp+fp)));
		System.out.println("Recall:"+(tp/(tp+fn)));
		System.out.println("Accuracy:" +(tp+tn)/total);

	}
}
