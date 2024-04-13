import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

public class GameRecordManager {
  private String filename;
  private List<String> records = new ArrayList<>();
  int maxNum = 5;
  // private GameMap gameMap;

  public GameRecordManager(String filename) {
    this.filename = sketchPath(filename);
    // this.gameMap = gameMap;
    File file = new File(this.filename);

    String header = "Player Name,Score,Time\n";
    try {
      if (!file.exists()) {
        file.createNewFile();
        try (PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(file)))) {
          out.print(header);
        }
      } else {
        // Load existing records into the list
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
          String line = reader.readLine(); // Skip header
          while ((line = reader.readLine()) != null) {
            records.add(line);
          }
        }
      }
    }
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  public void saveRecord(String playerName) {
    int finalScore = (gameMap.score + gameMap.money * 10) * (1 + level / 10);
    String timeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
    String record = playerName + "," + finalScore + "," + timeStamp;
    records.add(record);

    // Sort by score descending, then by time ascending if scores are equal
    records.sort((a, b) -> {
      String[] splitA = a.split(",");
      String[] splitB = b.split(",");
      int scoreA = Integer.parseInt(splitA[1].trim());
      int scoreB = Integer.parseInt(splitB[1].trim());
      if (scoreA != scoreB) {
        return Integer.compare(scoreB, scoreA); // Descending order
      }
      return splitA[2].compareTo(splitB[2]); // Ascending order by time
    }
    );

    // Keep only the top maxNum records
    if (records.size() > maxNum) {
      records = records.subList(0, maxNum);
    }

    // Rewrite the file
    try (PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(this.filename)))) {
      out.println("Player Name,Score,Time"); // Write header
      for (String r : records) {
        out.println(r);
      }
    }
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  public List<String> loadRecords() {
    return records;
  }
}
