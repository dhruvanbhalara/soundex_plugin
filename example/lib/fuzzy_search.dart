import 'dart:math';

class FuzzySearch {
  final double fuzzySearchThresholdPct;

  FuzzySearch(this.fuzzySearchThresholdPct);

  bool isExactMatch(String term1, String term2) {
    return term1.toLowerCase() == term2.toLowerCase();
  }

  bool isPartialMatch(String term1, String term2) {
    return term1.toLowerCase().contains(term2.toLowerCase()) ||
        term2.toLowerCase().contains(term1.toLowerCase());
  }

  String soundex(String s) {
    if (s.isEmpty) return "";

    // Map letters to Soundex categories
    final Map<String, String> soundexMap = {
      'B': '1', 'F': '1', 'P': '1', 'V': '1',
      'C': '2', 'G': '2', 'J': '2', 'K': '2', 'Q': '2', 'S': '2', 'X': '2', 'Z': '2',
      'D': '3', 'T': '3',
      'L': '4',
      'M': '5', 'N': '5',
      'R': '6'
    };

    // Prepare string: convert to uppercase and remove non-alphabet characters
    s = s.toUpperCase().replaceAll(RegExp('[^A-Z]'), '');

    // Save the first letter and remove it from the string
    String firstLetter = s[0];
    String result = '';

    // Convert letters to their corresponding numbers
    for (int i = 0; i < s.length; i++) {
      String char = s[i];
      String? code = soundexMap[char];
      if (code != null && (result.isEmpty || result[result.length - 1] != code)) {
        result += code;
      }
    }

    // Return the first letter and the first three digits, padded with zeros if necessary
    return firstLetter + result.padRight(3, '0').substring(0, 3);
  }

  String metaphone(String word) {
    if (word.isEmpty) return "";

    // Normalize the word to uppercase
    word = word.toUpperCase();

    // Some basic replacements for common phonetic sounds
    final Map<String, String> replacements = {
      'PH': 'F',
      'GH': 'H',
      'KN': 'N',
      'GN': 'N',
      'PN': 'N',
      'AE': 'E',
      'IE': 'Y',
      'CK': 'K',
      'C': 'K',
      'Q': 'K',
      'X': 'S',
      'V': 'F',
      'D': 'T',
      'B': 'P',
      'M': 'N',
      'Z': 'S',
      'SH': 'S',
      'ZH': 'S',
      'CH': 'K'
    };

    // Apply replacements
    replacements.forEach((k, v) {
      word = word.replaceAll(k, v);
    });

    // Remove duplicate adjacent letters
    var result = StringBuffer();
    for (int i = 0; i < word.length; i++) {
      if (i == 0 || word[i] != word[i - 1]) {
        result.write(word[i]);
      }
    }

    // Return the resulting string
    return result.toString();
  }


  int levenshtein(String s1, String s2) {
    if (s1.isEmpty) return s2.length;
    if (s2.isEmpty) return s1.length;

    List<List<int>> d = List.generate(s1.length + 1, (i) => List.filled(s2.length + 1, 0));

    for (int i = 0; i <= s1.length; i++) d[i][0] = i;
    for (int j = 0; j <= s2.length; j++) d[0][j] = j;

    for (int i = 1; i <= s1.length; i++) {
      for (int j = 1; j <= s2.length; j++) {
        int cost = (s1[i - 1] == s2[j - 1]) ? 0 : 1;
        d[i][j] = min(
          min(d[i - 1][j] + 1, d[i][j - 1] + 1),
          d[i - 1][j - 1] + cost,
        );
      }
    }

    return d[s1.length][s2.length];
  }

  bool isFuzzyMatch(String term1, String term2) {
    if (isExactMatch(term1, term2) || isPartialMatch(term1, term2)) {
      return true;
    }
    if (soundex(term1) == soundex(term2)) {
      return true;
    }

    int levenshteinSimilarityScore = levenshtein(term1, term2);
    int avgCount = ((term1.length + term2.length) / 2).ceil();
    int minPctLevenshteinScore = (avgCount * (1 - fuzzySearchThresholdPct / 100.0)).ceil();

    return levenshteinSimilarityScore <= minPctLevenshteinScore;
  }
}

void main() {
  FuzzySearch fuzzySearch = FuzzySearch(20.0); // Set threshold percentage

  String term1 = "example";
  String term2 = "exampel";

  bool result = fuzzySearch.isFuzzyMatch(term1, term2);
  print("Are the terms '$term1' and '$term2' a fuzzy match? $result");
}