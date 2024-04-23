public static int[][] deepCopy2D(int[][] original) {
  if (original == null) {
    return null;
  }

  int[][] result = new int[original.length][];

  for (int i = 0; i < original.length; i++) {
    result[i] = new int[original[i].length];
    for (int j = 0; j < original[i].length; j++) {
      result[i][j] = original[i][j];
    }
  }

  return result;
}

String truncateString(String input, int maxLength) {
  if (input.length() > maxLength) {
    return input.substring(0, maxLength - 3) + "...";
  } else {
    return input;
  }
}

boolean containsElement(int[] array, int target) {
  for (int num : array) {
    if (num == target) {
      return true;
    }
  }
  return false;
}
