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

// PImage enlargeImage(PImage img, flost factor) {
//     if(factor<1){
//         println
//     }
//     int newWidth = img.width * factor;
//     int newHeight = img.height * factor;
//     PImage result = createImage(newWidth, newHeight, ARGB); // 创建一个新的图像，保留透明度

//     img.loadPixels();
//     result.loadPixels();
    
//     for (int y = 0; y < newHeight; y++) {
//         for (int x = 0; x < newWidth; x++) {
//             int oldX = x / factor;
//             int oldY = y / factor;
//             result.pixels[y * newWidth + x] = img.pixels[oldY * img.width + oldX]; // 复制像素
//         }
//     }
    
//     result.updatePixels();
//     return result;
// }