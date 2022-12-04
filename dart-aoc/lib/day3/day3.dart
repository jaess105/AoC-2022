import 'dart:io';

const inPath = 'resources/day3.txt';

void day3() {
  final inFile = File(inPath);
  final part1 = task1(inFile);
  final part2 = task2(inFile);
  print('Day3 Part1: $part1');
  print('Day3 Part2: $part2');
}

int task1(File input) => input
    .readAsStringSync()
    .split('\n')
    .map((backpack) => getCompartments(backpack))
    .map((compartments) => getMatchingLetter(compartments))
    .map((letter) => getLetterVal(letter))
    .fold(0, (previousValue, val) => previousValue + val);

int task2(File input) => input
    .readAsStringSync()
    .split('\n')
    .fold([<String>[]], (container, line) {
      if (container.last.length == 3) {
        container.add([line]);
      } else {
        container.last.add(line);
      }
      return container;
    })
    .map((rucksacks) => getMatchingLetterForThree(rucksacks))
    .map((letter) => getLetterVal(letter))
    .fold(0, (previousValue, val) => previousValue + val);

String getMatchingLetterForThree(List<String> rucksacks) {
  final firstRucksack = Set.from(rucksacks[0].split(''));
  final matchingLetters = <String>{};
  rucksacks[1].split('').forEach((letter) {
    if (firstRucksack.contains(letter)) {
      matchingLetters.add(letter);
    }
  });
  for (final letter in rucksacks[2].split('')) {
    if (matchingLetters.contains(letter)) {
      return letter;
    }
  }
  throw FormatException('The rucksacks had no matching Letter!');
}

List<String> getCompartments(String s) {
  var half = (s.length ~/ 2);
  return [s.substring(0, half), s.substring(half)];
}

String getMatchingLetter(List<String> compartments) {
  final firstCompartment = Set.from(compartments[0].split(''));
  for (final letter in compartments[1].split('')) {
    if (firstCompartment.contains(letter)) {
      return letter;
    }
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
