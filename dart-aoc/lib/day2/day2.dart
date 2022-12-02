import 'dart:io';

const ROCK = "ROCK";
const SICCOR = "SICCOR";
const PAPER = "PAPER";
// (1 for Rock, 2 for Paper, and 3 for Scissors)
const symToNum = {
  ROCK: 1,
  PAPER: 2,
  SICCOR: 3,
};

void day2() {
  final input = File('resources/day2.txt');
  print(task2(input));
}

int task1(File input) {
  return input.readAsStringSync().split('\n').map((e) {
    var splitted = e.split(' ');
    return calculateScore(splitted[0], splitted[1]);
  }).fold(0, (previousValue, element) => previousValue + element);
}

int task2(File input) {
  return input.readAsStringSync().split('\n').map((e) {
    var splitted = e.split(' ');
    return calculateScoreTask2(splitted[0], splitted[1]);
  }).fold(0, (previousValue, element) => previousValue + element);
}

int calculateScoreTask2(String enemy, String you) {
  // X means you need to lose,
  // Y means you need to end the round in a draw,
  // and Z means you need to win. Good luck!
  //(0 if you lost, 3 if the round was a draw, and 6 if you won).
  int enemySymToOwnPoints(String sym, int offset) {
    final x = symToNum[sym]! + offset;
    return x > 3 ? x - 3 : x;
  }

  int calculatePoints(String yourSym, String enemySym) {
    switch (yourSym) {
      case 'Z':
        return 6 + enemySymToOwnPoints(enemySym, 1);
      case 'Y':
        return 3 + enemySymToOwnPoints(enemySym, 0);
      case 'X':
        return 0 + enemySymToOwnPoints(enemySym, 2);
      default:
        throw FormatException('The retrieved value for you was wrong');
    }
  }

  you = you.trim();
  return calculatePoints(you, translate(enemy));
}

int calculateScore(String enemy, String you) {
  final ene = translate(enemy);
  final y = translate(you);
  var res = 0;
  //(0 if you lost, 3 if the round was a draw, and 6 if you won).
  if (ene == y) {
    res += 3;
  } else if (y == ROCK && ene == SICCOR ||
      y == SICCOR && ene == PAPER ||
      y == PAPER && ene == ROCK) {
    res += 6;
  }
  return res + symToNum[y]!;
}

String translate(String x) {
  x = x.trim();
  if (x == "A" || x == "X") {
    return ROCK;
  } else if (x == "B" || x == "Y") {
    return PAPER;
  } else if (x == "C" || x == "Z") {
    return SICCOR;
  }
  return '';
}
