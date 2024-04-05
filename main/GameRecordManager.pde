import java.io.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class GameRecordManager {
    private String filename;

    public GameRecordManager(String filename, GameMap gameMap) {
        this.filename = sketchPath(filename);
        File file = new File(this.filename);

        String header = "Player Name,Score,Time\n";
        if (!file.exists()) {
            try {
                file.createNewFile();
                PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(file, true)));
                out.print(header);
                out.close();
                print("Created!");
                return;
            } catch (IOException e) {
                e.printStackTrace();
                return;
            }
        }
        print("EXIST!");
    }

    public void saveRecord(String playerName) {
        finalscore = gameMap.score + gameMap.money * 10;
        String timeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        String record = playerName + ", " + finalscore + ", " + timeStamp + "\n";
        try {
            PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(this.filename, true)));
            out.print(record);
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public List<String> loadRecords() {
        List<String> records = new ArrayList<>();
        File file = new File(this.filename);
        if (file.exists()) {
            try {
                BufferedReader reader = new BufferedReader(new FileReader(file));
                String line;
                int id = 1;
                reader.readLine(); // Skip header
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split(", ");
                    if (parts.length == 3) {
                        String playerName = parts[0];
                        // int score = Integer.parseInt(parts[1]);
                        String score = parts[1];
                        String time = parts[2];
                        records.add("" + id + "\t" + playerName + "\t" + score + "\t" + time);
                    }
                    println("Something error in records.");
                }
                reader.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            println("No records found.");
        }
        return records;
    }
}