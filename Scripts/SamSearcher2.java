import java.io.*;
import java.util.*;

public class SamSearcher2 {

    public static void main(String[] args) throws IOException {
        Scanner input = new Scanner(System.in);
        System.out.print("Reference: ");
        String reference = input.nextLine();

        System.out.print("Dictionary: ");
        String dictionary = input.nextLine();

        System.out.print("Output: ");
        String output = input.nextLine();

        BufferedReader reader = new BufferedReader(new FileReader(dictionary));
        BufferedWriter writer = new BufferedWriter(new FileWriter(output));
        BufferedReader reader2;

        String line;
        while ((line = reader.readLine()) != null) {
            //System.out.println(line);
            writer.write("\n" + line + "\n");
            String[] parts = line.split("\t");
            int targetPos = Integer.parseInt(parts[1]);
            boolean matching = false;
            char allele = getAllele(parts[2], parts[3], parts[4]);

            String line2;
            
            reader2 = new BufferedReader(new FileReader(reference));
            while ((line2 = reader2.readLine()) != null) {
                //System.out.println(line2);
                String[] parts2 = line2.split("\t");
                int referencePos = Integer.parseInt(parts2[3]);
                String referenceSeq = parts2[9];
                //System.out.println("Searching " +  targetPos + "\t" + referencePos);
                //System.out.println("" + targetPos + "\t" + referencePos + "\t" + (referencePos + referenceSeq.length()));

                if (targetPos >= referencePos) {
                    //System.out.println("" + targetPos + "\t" + referencePos + "\t" + (referencePos + referenceSeq.length()));
                    //System.out.println(referencePos + referenceSeq.length() - targetPos);
                    if (((referencePos + referenceSeq.length()) - targetPos) > 0) {
                        if (referenceSeq.charAt(targetPos - referencePos) == allele) {
                            	System.out.println("Found");
				writer.write(line2 + "\n");
                        }
                    }
                } else {
                    break;
                }
            }
            reader2.close();
        }
        writer.close();
    }
    
    public static char getAllele(String ref, String alt, String genotype) {
        if (genotype.equals("0/0")) {
            return ref.charAt(0);
        }
        else if (genotype.equals("1/1") || genotype.equals("1|1")) {
            return alt.charAt(0);
        }
        else {
            return 'x';
        }
    }
}
