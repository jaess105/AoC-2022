import 'dart:io';

const inPath = 'resources/day3.txt';

void day3() {
  final inFile = File(inPath);
  final part1 = task1(inFile);
  print('Day3 Part1: $part1');
}

int task1(File input) => input
    .readAsStringSync()
    .split('\n')
    .map((backpack) => getCompartments(backpack))
    .map((compartments) => getMatchingLetter(compartments))
    .map((letter) => getLetterVal(letter))
    .fold(0, (previousValue, val) => previousValue + val);

List<String> getCompartments(String s) {
  var half = (s.length ~/ 2);
  return [s.substring(0, half), s.substring(half)];
}

String getMatchingLetter(List<String> compartments) {
  final firstCompartment = Set.from(compartments[0].split(''));
  for (final letter in compartments[1].split('')) {
    if (!firstCompartment.add(letter)) {
      return letter;
    }
    firstCompartment.remove(letter);
  }
  throw FormatException('The compartments had no matching Letter!');
}

int getLetterVal(String letter) {
  var asciiVal = letter.codeUnitAt(0);
  if (asciiVal > 96) {
    // above 96 is a lowercase char.
    return asciiVal - 96; // a = 97 in ascii, removing 96 returns 1.
  } else {
    // - 65 + 27 as A starts at value 27 and in Ascii its value is 65.
    return asciiVal - 38;
  }
}
