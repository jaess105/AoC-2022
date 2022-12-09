import 'dart:io' as io;
import 'dart:math' as math;

import 'package:quiver/iterables.dart';

import 'FileTree.dart';

const inPath = 'resources/day7.txt';

void day7() {
  final inFile = io.File(inPath);
  final part1 = task1(inFile);
  final part2 = task2(inFile);
  print('Day7 Part1: $part1');
  print('Day7 Part2: $part2');
}

int task2(io.File inFile) {
  Set<AbstractDir> findAllDirsMatchingCondition(
      AbstractDir dir, bool Function(AbstractDir dir) condition) {
    final ret = <AbstractDir>{};
    if (condition(dir)) {
      ret.add(dir);
    }
    for (final childDir in dir.children.whereType<AbstractDir>()) {
      if (condition(childDir)) {
        ret.add(childDir);
      }
      ret.addAll(childDir.children
          .whereType<AbstractDir>()
          .expand((e) => findAllDirsMatchingCondition(e, condition)));
    }
    return ret;
  }

  final root = constructTree(inFile.readAsStringSync());

  final spaceToFree = 30000000 - (70000000 - root.size);
  bool condition(AbstractDir dir) {
    final ret = dir.size >= spaceToFree;
    return ret;
  }

  final ret = findAllDirsMatchingCondition(root, condition);
  final minimum = ret
      .map((e) => e.size)
      .reduce((value, element) => math.min(value, element));
  return minimum;
}

int task1(io.File inFile) {
  Set<AbstractDir> findAllDirsMatchingCondition(AbstractDir dir) {
    final ret = <AbstractDir>{};
    if (dir.size <= 100000) {
      ret.add(dir);
    }
    for (final child in dir.children.whereType<AbstractDir>()) {
      if (child.size <= 100000) {
        ret.add(child);
      }
      ret.addAll(child.children
          .whereType<AbstractDir>()
          .expand((e) => findAllDirsMatchingCondition(e)));
    }
    return ret;
  }

  final root = constructTree(inFile.readAsStringSync());
  final ret = findAllDirsMatchingCondition(root);
  return ret.map((e) => e.size).fold(0, (prev, size) => prev + size);
}

Root constructTree(String input) {
  final lines = input.split("\n");
  final Root root = Root();
  AbstractDir curr = root;
  for (var i = 0; i < lines.length; i++) {
    var line = lines[i];
    if (line.startsWith("\$ cd")) {
      curr = _handleCdCommand(root, curr, line);
    } else {
      i = _handleLs(curr, lines, line, i);
    }
  }
  return root;
}

AbstractDir _handleCdCommand(Root root, AbstractDir curr, String line) {
  final dirName = line.split(" ")[2];
  if (dirName == "/") {
    return root;
  } else if (dirName == "..") {
    return curr.parent;
  } else {
    return curr.getChildWithName(dirName);
  }
}

int _handleLs(AbstractDir curr, List<String> lines, String line, int i) {
  // get next line
  for (i = i + 1; i < lines.length; i++) {
    line = lines[i];
    // Next command
    if (line.startsWith("\$")) {
      break;
    }
    // New Directory entry
    if (line.startsWith("dir")) {
      final dirName = line.split(" ")[1];
      curr.addChild(Dir(dirName, curr));
      // New file entry
    } else {
      final sizeAndName = line.split(" ");
      curr.addChild(File(sizeAndName[1], curr, int.parse(sizeAndName[0])));
    }
  }
  // revert to the line before $ as the out loop will increase as well.
  return --i;
}
