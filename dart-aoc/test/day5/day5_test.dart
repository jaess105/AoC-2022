import 'dart:io';

import 'package:dart_aoc/day5/day5.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('task2', () {
    test('Test of all data', () {
      expect(task2(File('resources/day5_test.txt')), 'MCD');
    });
    test('Test all example Data', () {
      final stack = [
        ['[N]', '[Z]'],
        ['[D]', '[C]', '[M]'],
        ['[P]'],
      ];
      final instructions = [
        [1, 2, 1],
        [3, 1, 3],
        [2, 2, 1],
        [1, 1, 2],
      ];

      final expected = [
        ['[M]'],
        ['[C]'],
        ['[D]', '[N]', '[Z]', '[P]'],
      ];

      final result = executeInstructionsWithCrane9001(stack, instructions);
      expect(result, expected);
    });
  });
  group('task 1', () {
    test('Test of all data', () {
      expect(task1(File('resources/day5_test.txt')), 'CMZ');
    });
    test('Test all example Data', () {
      final stack = [
        ['[N]', '[Z]'],
        ['[D]', '[C]', '[M]'],
        ['[P]'],
      ];
      final instructions = [
        [1, 2, 1],
        [3, 1, 3],
        [2, 2, 1],
        [1, 1, 2],
      ];

      final expected = [
        ['[C]'],
        ['[M]'],
        ['[Z]', '[N]', '[D]', '[P]'],
      ];

      final result = executeInstructions(stack, instructions);
      expect(result, expected);
    });
    group('Split content correct', () {
      test('assert correct split', () {
        final input = File('resources/day5_test.txt').readAsStringSync();
        final stackAndInstructions = splitIntoStackAndInstruction(input);
        expect(stackAndInstructions, [
          '''    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 ''',
          '''move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2'''
        ]);
      });
      test('split first line correct', () {
        final lineSplit = splitLine('    [D]    ');
        expect(lineSplit, ['', '[D]', '']);
      });
      test('split second line correct', () {
        final lineSplit = splitLine('[N] [C]    ');
        expect(lineSplit, ['[N]', '[C]', '']);
      });
      test('split third line correct', () {
        final lineSplit = splitLine('[Z] [M] [P]');
        expect(lineSplit, ['[Z]', '[M]', '[P]']);
      });
      test('split left and right line correct', () {
        final lineSplit = splitLine('[N]     [C]');
        expect(lineSplit, ['[N]', '', '[C]']);
      });
      test('split right line correct', () {
        final lineSplit = splitLine('        [C]');
        expect(lineSplit, ['', '', '[C]']);
      });
      test('split right line with 5 correct', () {
        final lineSplit = splitLine('        [C]        ');
        expect(lineSplit, ['', '', '[C]', '', '']);
      });
    });
    group('generate correct Stack from String', () {
      test('AoC Example: Stack generation', () {
        final input = '''    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 ''';
        final output = [
          ['[N]', '[Z]'],
          ['[D]', '[C]', '[M]'],
          ['[P]'],
        ];

        final stack = generateStackFromString(input);

        expect(stack, output);
      });
    });
    group('Instruction parsing', () {
      final instructionsAndParsed = {
        'move 1 from 2 to 1': [1, 2, 1],
        'move 3 from 1 to 3': [3, 1, 3],
        'move 2 from 2 to 1': [2, 2, 1],
        'move 1 from 1 to 2': [1, 1, 2],
        'move 100 from 20 to 2': [100, 20, 2],
      };
      instructionsAndParsed.forEach(
        (instruction, parsed) {
          test('Convert instruction "$instruction" to $parsed', () {
            final converted = converteInstructions(instruction);
            expect(converted, parsed);
          });
        },
      );
      test('Generate all instructions', () {
        final input = '''move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2''';
        final output = [
          [1, 2, 1],
          [3, 1, 3],
          [2, 2, 1],
          [1, 1, 2],
        ];

        final allInstructions = generateAllInstructions(input);
        expect(allInstructions, output);
      });
    });
  });
}
