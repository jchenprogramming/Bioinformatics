import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class SamSplitter {
    public static void main(String[] args) throws IOException {
        String inputFile = "vertpistil.sam";
        
        try (BufferedReader br = new BufferedReader(new FileReader(inputFile))) {
            // Create ten BufferedWriter instances for output files
            BufferedWriter[] bws = new BufferedWriter[10];
            for (int i = 0; i < 10; i++) {
                bws[i] = new BufferedWriter(new FileWriter("Chrom" + (i + 1) + ".txt"));
            }
            
            String line;
            while ((line = br.readLine()) != null) {
                // Check if the line starts with "V"
                if (line.startsWith("V")) {
                    String[] fields = line.split("\t");
                    String chr = fields[2];

                    for (int i = 0; i < 10; i++) {
                        if (chr.equals("Chr" + String.format("%02d", i + 1))) {
                            bws[i].write(line + "\n");
                        }
                    }
                }
            }
            
            // Close all the BufferedWriter instances
            for (BufferedWriter bw : bws) {
                bw.close();
            }
        }
    }
}

