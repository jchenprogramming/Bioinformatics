import java.io.*;
import java.util.*;

public class RemoveDupes {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Enter the input file path: ");
        String inputFilePath = scanner.nextLine();
        System.out.print("Enter the output file path: ");
        String outputFilePath = scanner.nextLine();

        try {
            BufferedReader reader = new BufferedReader(new FileReader(inputFilePath));
            Set<String> uniqueReadIDs = new HashSet<>();
            BufferedWriter writer = new BufferedWriter(new FileWriter(outputFilePath));

            String line;
            while ((line = reader.readLine()) != null) {
                // Skip lines that start with "Chr" (assuming they are headers)
                if (line.startsWith("Chr")) {
                    continue;
                }

                String[] parts = line.split("\t"); // Assuming tab-separated values
                if (parts.length >= 1) {
                    String readID = parts[0].trim();
                    if (!uniqueReadIDs.contains(readID)) {
                        writer.write(line + "\n");
                        uniqueReadIDs.add(readID);
                    }
                }
            }

            reader.close();
            writer.close();
            System.out.println("Duplicates removed, headers skipped, and output written to " + outputFilePath);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

