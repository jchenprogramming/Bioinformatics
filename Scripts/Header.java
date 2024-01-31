import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class Header {
    public static void main(String[] args) {
        String inputFileName = "vertpistil.sam";     // Replace with your input file path
        String outputFileName = "header.txt";   // Replace with your desired output file path

        try (BufferedReader reader = new BufferedReader(new FileReader(inputFileName));
             BufferedWriter writer = new BufferedWriter(new FileWriter(outputFileName))) {

            String line;
            while ((line = reader.readLine()) != null) {
                // Check if the line starts with '@'
                if (line.startsWith("@")) {
                    // Write the line to the output file
                    writer.write(line);
                    writer.newLine();
                }
		else {
			break;
		}
            }

            System.out.println("Lines starting with '@' have been extracted to " + outputFileName);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

