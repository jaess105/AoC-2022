import 'dart:io';

const inPath = 'resources/day6.txt';

void day6() {
  final inFile = File(inPath);
  final part1 = task1(inFile);
  final part2 = task2(inFile);
  print('Day6 Part1: $part1');
  print('Day6 Part2: $part2');
}

int task1(File input) =>
    findStartPosOfXDistinctChars(input.readAsStringSync(), 4);
int task2(File input) =>
    findStartPosOfXDistinctChars(input.readAsStringSync(), 14);

int findStartPosOfXDistinctChars(String input, int x) {
  final listOfChars = input.split('');
  final distinctChars = listOfChars.take(x).toList();
  if (allDistinct(distinctChars)) {
    return x;
  }
  for (var i = x; i < listOfChars.length; i++) {
    distinctChars.removeAt(0);
    distinctChars.add(listOfChars[i]);
    if (allDistinct(distinctChars)) {
      return i + 1;
    }
  }
  return -1;
}

bool allDistinct(Iterable<String> list) => list.toSet().length == list.length;
