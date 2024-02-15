import java.io.*;
import java.util.*;

public class Translator {
    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);

        // Default values for name and path
        String name = "output";
        String path = "input.vcf"; // Default input file name

        File inputFile = new File(path);

        // Check if the specified file exists
        if (!inputFile.exists()) {
            System.out.println("Error: File not found.");
            return;
        }

        makeEntries(inputFile, name);
    }

    // Method to create a spreadsheet from VCF data
    public static void makeSpreadsheet(String name, ArrayList<String[]> arr) {
        try {
            // Create a FileWriter for the output file
            FileWriter myWriter = new FileWriter(name + ".txt");

            // Write file label
            myWriter.write(name + "\n");

            // Write header for the spreadsheet
            myWriter.write("Chromosome" + "\t" + "Position" + "\t" + "Reference" + "\t" + "Alternate" + "\t" + "Genotype" + "\n");

            // Iterate through the VCF data and write relevant information to the file
            for (int i = 0; i < arr.size(); i++) {
                String[] temp = arr.get(i);
                if (temp[3].length() == 1 && (temp[4].length() == 1 || temp[4].indexOf("*") != -1)) {
                    myWriter.write(temp[0] + "\t" + temp[1] + "\t" + temp[3] + "\t" + temp[4] + "\t" + temp[9].substring(0, 3) + "\t" + temp[10].substring(0, 3) + "\t" + temp[11].substring(0, 3) + "\n");
                }
            }

            // Close the FileWriter
            myWriter.close();

            System.out.println("File created.");
        } catch (IOException e) {
            System.out.println("An error occurred.");
            e.printStackTrace();
        }
    }

    // Method to read and parse VCF data from a file
    public static ArrayList<String[]> makeEntries(File input, String name) {
        ArrayList<String[]> data = new ArrayList<>();

        try (BufferedReader br = new BufferedReader(new FileReader(input))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] values = line.split("\t");
                if (values.length > 1) {
                    data.add(values);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Call the method to create a spreadsheet from the parsed VCF data
        makeSpreadsheet(name, data);

        return data;
    }
}
