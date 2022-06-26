import 'package:firstapp/shared/components/components.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('Calc age group test', () {

    test('get age right', () {
      const bYear = 2000;
      final age = calcAge(bYear);

      expect(age, 22);
    });
  });

  test('test network connection',() async {
    final hasConnection = await hasNetwork();
    expect(hasConnection, true);
  });

}

int calcAge(int bYear){
  final currentYear = DateTime.now().year;

  return currentYear - bYear;
}