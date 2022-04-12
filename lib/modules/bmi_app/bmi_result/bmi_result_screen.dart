import 'package:flutter/material.dart';

class BMIResult extends StatelessWidget {
  late final String gender;
  late final int age, result;
  late final String _finalResult;

  BMIResult({
    Key? key,
    required this.result,
    required this.age,
    required this.gender,
  }) : super(key: key) {
    if (result > 0 && result <= 20) {
      _finalResult = 'وزن أقل من الطبيعى';
    } else if (result > 20 && result <= 25) {
      _finalResult = 'وزن طبيعى';
    } else if (result > 25 && result <= 30) {
      _finalResult = 'وزن زائد';
    } else if (result > 30 && result <= 35) {
      _finalResult = 'سمنة خفيفة - من الدرجة الأولى';
    } else if (result > 35 && result <= 40) {
      _finalResult = 'سمنة متوسطة - من الدرجة الثانية';
    } else if (result > 40) {
      _finalResult = 'سمنة مفرطة - من الدرجة الثالثة';
    } else {
      _finalResult = 'عذراً حدث خطأ\nرجاء التأكد من إدخال بيانات صحيحة';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'النتيجة',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // // gender
              // Text(
              //   'النوع: $gender',
              //   textDirection: TextDirection.rtl,
              //   style: TextStyle(
              //     fontSize: 25,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'النتيجة: $result',
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    _finalResult,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 23,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'تم التصميم بواسطة: Mostafa Alazhariy',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
