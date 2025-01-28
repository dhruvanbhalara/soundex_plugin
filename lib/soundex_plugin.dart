
import 'soundex_plugin_platform_interface.dart';

class SoundexPlugin {
  Future<String?> getPlatformVersion() {
    return SoundexPluginPlatform.instance.getPlatformVersion();
  }
  static String encode(String input) {
    // Convert the input to uppercase for uniformity
    input = input.toUpperCase();
    // Soundex encoding logic
    Map<String, String> codes = {
      'A': '', 'E': '', 'I': '', 'O': '', 'U': '', 'H': '', 'W': '', 'Y': '',
      'B': '1', 'F': '1', 'P': '1', 'V': '1',
      'C': '2', 'G': '2', 'J': '2', 'K': '2', 'Q': '2', 'S': '2', 'X': '2', 'Z': '2',
      'D': '3', 'T': '3',
      'L': '4',
      'M': '5', 'N': '5',
      'R': '6'
    };
    // Initial letter
    String result = input.substring(0, 1);
    // Encode the rest of the letters
    String lastCode = codes[input.substring(0, 1)] ?? "";
    for (int i = 1; i < input.length; i++) {
      String currentChar = input.substring(i, i + 1);
      String code = codes[currentChar] ?? "";
      if (code.isNotEmpty && code != lastCode) {
        result += code;
      }
      lastCode = code;
    }
    // Pad with zeros or truncate to make the code length 4
    return result.padRight(4, '0').substring(0, 4);
  }
}
