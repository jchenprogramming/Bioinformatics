import java.io.*;

public class FileSplitter {

    public static void main(String[] args) throws IOException {

        String inputFilePath = args[0];

        String outputFilePath1 = args[1];
        String outputFilePath2 = args[2];

        BufferedReader inputFile = new BufferedReader(new FileReader(inputFilePath));

        BufferedWriter outputFile1 = new BufferedWriter(new FileWriter(outputFilePath1));
        BufferedWriter outputFile2 = new BufferedWriter(new FileWriter(outputFilePath2));

        int numLines = 0;
        while (inputFile.readLine() != null) {
            numLines++;
        }
        inputFile.close();

        inputFile = new BufferedReader(new FileReader(inputFilePath));

        int numLines1 = numLines / 2;
        int numLines2 = numLines - numLines1;

        for (int i = 0; i < numLines1; i++) {
            String line = inputFile.readLine();
            outputFile1.write(line);
            outputFile1.newLine();
        }
        outputFile1.close();

        for (int i = 0; i < numLines2; i++) {
            String line = inputFile.readLine();
            outputFile2.write(line);
            outputFile2.newLine();
        }
        outputFile2.close();

        inputFile.close();

        System.out.println("File split complete.");
    }
}

