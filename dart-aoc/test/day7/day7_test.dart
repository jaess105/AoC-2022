import 'package:dart_aoc/day7/FileTree.dart';
import 'package:dart_aoc/day7/day7.dart';
import 'package:quiver/collection.dart';
import 'package:test/test.dart';
import 'dart:io' as io;

void main() {
  group('task 2', () {
    test('Test correct execution of Task 2', () {
      expect(task2(io.File('resources/day7_test.txt')), 24933642);
    });
  });
  group("task 1", () {
    test('Test correct execution of Task 1', () {
      expect(task1(io.File('resources/day7_test.txt')), 95437);
    });
    test("test correct construction of input", () {
      Root expectedConstruction() {
        final root = Root();
        final folderA = Dir("a", root);
        final folderD = Dir("d", root);
        root.addChildren([
          folderA,
          File('b.txt', root, 14848514),
          File('c.dat', root, 8504156),
          folderD,
        ]);
        final folderE = Dir('e', folderA);
        folderA.addChildren([
          folderE,
          File('f', folderA, 29116),
          File('g', folderA, 2557),
          File("h.lst", folderA, 62596),
        ]);
        folderE.addChild(File('i', folderA, 584));
        folderD.addChildren([
          File("j", folderD, 4060174),
          File("d.log", folderD, 8033020),
          File("d.ext", folderD, 5626152),
          File("k", folderD, 7214296),
        ]);
        return root;
      }

      const input = '''\$ cd /
\$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
\$ cd a
\$ ls
dir e
29116 f
2557 g
62596 h.lst
\$ cd e
\$ ls
584 i
\$ cd ..
\$ cd ..
\$ cd d
\$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k''';
      final root = constructTree(input);
      final expected = expectedConstruction();
      expect(root.children, equals(expected.children));
      expect(root, equals(expected));
    });
  });
}
