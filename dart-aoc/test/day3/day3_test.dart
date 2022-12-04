import 'dart:io';

import 'package:dart_aoc/day3/day3.dart';
import 'package:test/test.dart';

void main() {
  group('task 2', () {
    test('Full execution on test Input', () {
      expect(task2(File('resources/day3_test.txt')), 70);
    });
    group('identify common between three rucksacks', () {
      test('First example input from AoC', () {
        final input = [
          'wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn',
          'ttgJtRGJQctTZtZT',
          'CrZsJsPPZsGzwwsLwLmpwMDw',
        ];
        final matchingLetter = getMatchingLetterForThree(input);
        expect(matchingLetter, 'Z');
      });
      test('Second example input from AoC', () {
        final input = [
          'vJrwpWtwJgWrhcsFMMfFFhFp',
          'jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL',
          'PmmdzqPrVvPwwTWBwg',
        ];
        final matchingLetter = getMatchingLetterForThree(input);
        expect(matchingLetter, 'r');
      });
    });
  });
  group('task 1', () {
    test('Full execution on test Input', () {
      expect(task1(File('resources/day3_test.txt')), 157);
    });

    group('correct compartments', () {
      test('first example input from AoC', () {
        var compartments = getCompartments('vJrwpWtwJgWrhcsFMMfFFhFp');
        expect(compartments, ['vJrwpWtwJgWr', 'hcsFMMfFFhFp']);
      });
      test('second example input from AoC', () {
        var compartments = getCompartments('jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL');
        expect(compartments, ['jqHRNqRjqzjGDLGL', 'rsFMfFZSrLrFZsSL']);
      });
      test('third example input from AoC', () {
        var compartments = getCompartments('PmmdzqPrVvPwwTWBwg');
        expect(compartments, ['PmmdzqPrV', 'vPwwTWBwg']);
      });
    });

    group('Get the matching letter', () {
      test('first example input from AoC', () {
        var matchingLetter =
            getMatchingLetter(['vJrwpWtwJgWr', 'hcsFMMfFFhFp']);
        expect(matchingLetter, 'p');
      });
      test('second example input from AoC', () {
        var matchingLetter =
            getMatchingLetter(['jqHRNqRjqzjGDLGL', 'rsFMfFZSrLrFZsSL']);
        expect(matchingLetter, 'L');
      });
      test('third example input from AoC', () {
        var matchingLetter = getMatchingLetter(['PmmdzqPrV', 'vPwwTWBwg']);
        expect(matchingLetter, 'P');
      });
    });

    group('Get letter values', () {
      const inputAndExpected = {
        'p': 16,
        'L': 38,
        'P': 42,
        'v': 22,
        't': 20,
        's': 19,
      };
      inputAndExpected.forEach((input, expected) {
        test('$input should be $expected', () {
          var letterVal = getLetterVal(input);
          expect(letterVal, expected);
        });
      });
    });
  });
}
