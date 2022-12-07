import 'package:dart_aoc/day6/day6.dart';
import 'package:test/test.dart';

void main() {
  group("Example Tests for task 1", () {
    const inputWithExpect = {
      "bvwbjplbgvbhsrlpgdmjqwftvncz": 5,
      "nppdvjthqldpwncqszvftbrmjlhg": 6,
      "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg": 10,
      "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw": 11,
    };
    inputWithExpect.forEach((input, expected) {
      test('Result should be $expected!', () {
        expect(findStartPosOfXDistinctChars(input, 4), expected);
      });
    });
  });

  group("Example Tests for task 2", () {
    const inputWithExpect = {
      "mjqjpqmgbljsphdztnvjfqwrcgsmlb": 19,
      "bvwbjplbgvbhsrlpgdmjqwftvncz": 23,
      "nppdvjthqldpwncqszvftbrmjlhg": 23,
      "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg": 29,
      "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw": 26,
    };
    inputWithExpect.forEach((input, expected) {
      test('Result should be $expected!', () {
        expect(findStartPosOfXDistinctChars(input, 14), expected);
      });
    });
  });
}
