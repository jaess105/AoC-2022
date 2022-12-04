import 'dart:io';

const inPath = 'resources/day4.txt';

void day4() {
  final inFile = File(inPath);
  final part1 = task1(inFile);
  final part2 = task2(inFile);
  print('Day4 Part1: $part1');
  print('Day3 Part2: $part2');
}

int task1(File input) => input
    .readAsStringSync()
    .split('\n')
    .map((line) => getSequenceStrings(line))
    .where((sequences) => oneContainsTheOther(sequences[0], sequences[1]))
    .toList()
    .length;

int task2(File input) => input
    .readAsStringSync()
    .split('\n')
    .map((line) => getSequenceStrings(line))
    .where((sequences) => sequences[0].any((num) => sequences[1].contains(num)))
    .toList()
    .length;

bool oneContainsTheOther(Set<int> a, Set<int> b) =>
    a.containsAll(b) || b.containsAll(a);

List<Set<int>> getSequenceStrings(String line) => line.split(',').map((pair) {
      final beginningAndEnd = pair.split('-');
      final start = int.parse(beginningAndEnd[0]);
      final end = int.parse(beginningAndEnd[1]);
      var seq = <int>{};
      for (var i = start; i <= end; i++) {
        seq.add(i);
      }
      return seq;
    }).toList();
