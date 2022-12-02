import 'dart:io';
import 'dart:math';

class Bag {
  final int gesamt;
  final List<int> bag;

  Bag(this.gesamt, this.bag);
}

void day1() {
  final inpunt = File('./resources/day1.txt');
  final splittedContents = inpunt.readAsStringSync().split('\n');

  final bagList = splittedContents.fold(<List<int>>[[]],
      (previousValue, element) {
    var newVal = int.tryParse(element);
    if (newVal == null) {
      previousValue.add([]);
    } else {
      previousValue.last.add(newVal);
    }
    return previousValue;
  }).map((e) =>
      Bag(e.fold(0, (previousValue, element) => previousValue + element), e));
  print(getMax(bagList));
  print(getSumOfMaxThre(bagList));
}

int getMax(Iterable<Bag> bagList) =>
    bagList.map((e) => e.gesamt).reduce((a, b) => max(a, b));

int getSumOfMaxThre(Iterable<Bag> bagList) => bagList
    .map((e) => e.gesamt)
    .fold<List<int>>([0, 0, 0], (a, b) => maxThree(a, b)).fold<int>(
        0, (previousValue, element) => previousValue + element);

List<int> maxThree(List<int> three, int newVal) {
  if (three[2] < newVal) {
    three[2] = newVal;
    if (three[1] < newVal) {
      three[2] = three[1];
      three[1] = newVal;
      if (three[0] < newVal) {
        three[1] = three[0];
        three[0] = newVal;
      }
    }
  }
  return three;
}
