import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class ChromSplitter {
    public static void main(String[] args) throws IOException {
        String inputFile = "vpistilSNPs.txt";
        
        BufferedReader br = new BufferedReader(new FileReader(inputFile));
        BufferedWriter bw1 = new BufferedWriter(new FileWriter("SNPChrom1.txt"));
        BufferedWriter bw2 = new BufferedWriter(new FileWriter("SNPChrom2.txt"));
        BufferedWriter bw3 = new BufferedWriter(new FileWriter("SNPChrom3.txt"));
        BufferedWriter bw4 = new BufferedWriter(new FileWriter("SNPChrom4.txt"));
        BufferedWriter bw5 = new BufferedWriter(new FileWriter("SNPChrom5.txt"));
        BufferedWriter bw6 = new BufferedWriter(new FileWriter("SNPChrom6.txt"));
        BufferedWriter bw7 = new BufferedWriter(new FileWriter("SNPChrom7.txt"));
        BufferedWriter bw8 = new BufferedWriter(new FileWriter("SNPChrom8.txt"));
        BufferedWriter bw9 = new BufferedWriter(new FileWriter("SNPChrom9.txt"));
        BufferedWriter bw10 = new BufferedWriter(new FileWriter("SNPChrom10.txt"));
        
        String line;
        while ((line = br.readLine()) != null) {
            String[] fields = line.split("\t");
			String chr = fields[0];
            
            if (chr.equals("Chr01")) {
                bw1.write(line + "\n");
            }
            else if (chr.equals("Chr02")) {
                bw2.write(line + "\n");
            }
            else if (chr.equals("Chr03")) {
                bw3.write(line + "\n");
            }
            else if (chr.equals("Chr04")) {
                bw4.write(line + "\n");
            }
            else if (chr.equals("Chr05")) {
                bw5.write(line + "\n");
            }
            else if (chr.equals("Chr06")) {
                bw6.write(line + "\n");
            }
            else if (chr.equals("Chr07")) {
                bw7.write(line + "\n");
            }
            else if (chr.equals("Chr08")) {
                bw8.write(line + "\n");
            }
            else if (chr.equals("Chr09")) {
                bw9.write(line + "\n");
            }
            else if (chr.equals("Chr10")) {
                bw10.write(line + "\n");
            }
        }
        
        br.close();
        bw1.close();
        bw2.close();
        bw3.close();
        bw4.close();
        bw5.close();
        bw6.close();
        bw7.close();
        bw8.close();
        bw9.close();
        bw10.close();
    }
}
