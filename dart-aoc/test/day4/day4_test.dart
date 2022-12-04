import 'dart:io';

import 'package:dart_aoc/day4/day4.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('task 1', () {
    test('Full execution on first task test', () {
      expect(task1(File('resources/day4_test.txt')), 3);
    });
    group('Get Sequence String from line', () {
      var input = {
        '2-4,6-8': [
          {2, 3, 4},
          {6, 7, 8}
        ],
        '2-3,4-5': [
          {2, 3},
          {4, 5}
        ],
        '5-7,7-9': [
          {5, 6, 7},
          {7, 8, 9}
        ],
        '2-8,3-7': [
          {2, 3, 4, 5, 6, 7, 8},
          {3, 4, 5, 6, 7}
        ],
        '6-6,4-6': [
          {6},
          {4, 5, 6}
        ],
        '2-6,4-8': [
          {2, 3, 4, 5, 6},
          {4, 5, 6, 7, 8}
        ],
      };
      input.forEach((line, sequence) {
        test('Test for sequence $line', () {
          var sequences = getSequenceStrings(line);
          expect(sequences, sequence);
        });
      });
    });
  });
}
