import 'dart:io';

const inPath = 'resources/day5.txt';

void day5() {
  final inFile = File(inPath);
  final part1 = task1(inFile);
  final part2 = task2(inFile);
  print('Day5 Part1: $part1');
  print('Day5 Part2: $part2');
}

String task2(File input) =>
    moveAllCratesWith(input, executeInstructionsWithCrane9001);

String task1(File input) => moveAllCratesWith(input, executeInstructions);

final regexForBrackets = RegExp(r'[\[\]]');
String moveAllCratesWith(File input,
    List<List<String>> execute(List<List<String>> s, List<List<int>> i)) {
  final inStr = input.readAsStringSync();
  final stackAndInstructions = splitIntoStackAndInstruction(inStr);
  final stack = generateStackFromString(stackAndInstructions[0]);
  final instructions = generateAllInstructions(stackAndInstructions[1]);
  final resultStack = execute(stack, instructions);

  return resultStack.fold('', (concat, col) {
    return concat + col.first.replaceAll(regexForBrackets, '');
  });
}

final regexEmptyLine = RegExp(r'\n\n');
List<String> splitIntoStackAndInstruction(String input) {
  return input.replaceAll('\r\n', '\n').split(regexEmptyLine);
}

final regexForRowSplit = RegExp(r' {1,4}');
List<String> splitLine(String line) {
  return line.split(regexForRowSplit);
}

List<List<String>> generateStackFromString(String stack) {
  final stackTurned =
      (stack.split('\n')..removeLast()).map((x) => splitLine(x)).toList();
  final resultStack = List<List<String>>.generate(
      stackTurned[0].length, ((index) => <String>[]),
      growable: true);
  for (var i = 0; i < stackTurned.length; i++) {
    for (var j = 0; j < stackTurned[0].length; j++) {
      final curr = stackTurned[i][j];
      if (curr != '') {
        resultStack[j].add(curr);
      }
    }
  }
  return resultStack;
}

List<int> converteInstructions(String instructionLine) {
  final re = RegExp(r'move (\d+) from (\d+) to (\d+)');
  final match = re.firstMatch(instructionLine)!;
  return [
    int.parse(match.group(1)!),
    int.parse(match.group(2)!),
    int.parse(match.group(3)!),
  ];
}

List<List<int>> generateAllInstructions(String instructions) {
  return instructions.split('\n').map((e) => converteInstructions(e)).toList();
}

List<List<String>> executeInstructions(
    List<List<String>> stack, List<List<int>> instructions) {
  instructions.forEach((instruct) {
    final count = instruct[0];
    final from = instruct[1];
    final to = instruct[2];

    for (var i = 0; i < count; i++) {
      final curr = stack[from - 1].removeAt(0);
      stack[to - 1].insert(0, curr);
    }
  });
  return stack;
}

List<List<String>> executeInstructionsWithCrane9001(
    List<List<String>> stack, List<List<int>> instructions) {
  instructions.forEach((instruct) {
    final count = instruct[0];
    final from = instruct[1];
    final to = instruct[2];

    for (var i = 0; i < count; i++) {
      final curr = stack[from - 1].removeAt(count - 1 - i);
      stack[to - 1].insert(0, curr);
    }
  });
  return stack;
}
