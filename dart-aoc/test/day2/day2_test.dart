import 'dart:io';

import 'package:dart_aoc/day2/day2.dart';
import 'package:test/test.dart';

void main() {
  group('Task 2 Tests', () {
    test('Test of all data', () {
      expect(task2(File('resources/day2_test.txt')), 12);
    });
    // In the first round, your opponent will choose Rock (A),
    //and you need the round to end in a draw (Y),
    //so you also choose Rock.
    //This gives you a score of 1 + 3 = 4.
    test('Should be 4', () {
      expect(calculateScoreTask2('A', 'Y'), 4);
    });
    // In the second round, your opponent will choose Paper (B),
    //and you choose Rock so you lose (X) with a score of 1 + 0 = 1.
    test('Should be 1', () {
      expect(calculateScoreTask2('B', 'X'), 1);
    });
    // In the third round, you will defeat your opponent's Scissors
    //with Rock for a score of 1 + 6 = 7.
    test('Should be 7', () {
      expect(calculateScoreTask2('C', 'Z'), 7);
    });
  });

  group('Task 1 Tests', () {
    test('calculate', () {
      expect(symToNum[PAPER], 2);
      expect(symToNum[SICCOR], 3);
      expect(symToNum[ROCK], 1);
    });
// In the first round, your opponent will choose Rock (A),
// and you should choose Paper (Y).
// This ends in a win for you with a score of 8
// (2 because you chose Paper + 6 because you won).
    test('Should be 8', () {
      expect(calculateScore("A", "Y"), 8);
    });

// In the second round, your opponent will choose Paper (B),
// and you should choose Rock (X).
// This ends in a loss for you with a score of 1 (1 + 0).
    test('Should be 1', () {
      expect(calculateScore("B", "X"), 1);
    });

// The third round is a draw with both players choosing Scissors,
// giving you a score of 3 + 3 = 6.
    test('Should be 6', () {
      expect(calculateScore("C", "Z"), 6);
    });
  });
}
