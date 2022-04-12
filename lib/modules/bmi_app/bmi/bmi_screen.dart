import 'dart:math';

import 'package:firstapp/modules/bmi_app/bmi_result/bmi_result_screen.dart';
import 'package:flutter/material.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({Key? key}) : super(key: key);

  @override
  _BMIScreenState createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {

  bool _isMale = true;
  double _height = 100;
  int _weight = 80;
  int _age = 21;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
              'حاسب مؤشر كتلة الجسم',
            textDirection: TextDirection.rtl,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  /// male
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          _isMale = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _isMale
                              ? Colors.lightBlue : Colors.grey[300],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            // Image(
                            //   image: AssetImage(
                            //     "assets/images/male icon.png",
                            //   ),
                            //   height: 80,
                            //   width: 80,
                            // ),
                            SizedBox(height: 15,),
                            Text(
                              'ذكــر',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  /// female
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          _isMale = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: !_isMale
                              ? Colors.lightBlue : Colors.grey[300],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            // Image(
                            //   image: AssetImage(
                            //     'assets/images/female icon.png'
                            //   ),
                            //   width: 80,
                            //   height: 80,
                            // ),
                            SizedBox(height: 15,),
                            Text(
                              'أنثــى',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'الطــول',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8,),
                    /// height value in cm
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      mainAxisAlignment: MainAxisAlignment.center,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '${_height.round()}',
                          style: const TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(width: 5,),
                        const Text(
                          'CM',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                    Slider(
                      value: _height,
                      max: 220,
                      min: 80,
                      activeColor: Colors.blue[300],
                      inactiveColor: Colors.blue[150],
                      onChanged: (value){
                        setState(() {
                          _height = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  /// weight
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'الــوزن',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8,),
                          Text(
                            '$_weight',
                            style: const TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 8,),
                          /// two buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              /// minus
                              FloatingActionButton(
                                onPressed: (){
                                  setState(() {
                                    _weight--;
                                  });
                                },
                                heroTag: 'weight-',
                                mini: true,
                                elevation: 1,
                                child: const Icon(
                                  Icons.remove,
                                ),
                              ),
                              const SizedBox(width: 8,),
                              /// plus
                              FloatingActionButton(
                                onPressed: (){
                                  setState(() {
                                    _weight++;
                                  });
                                },
                                heroTag: 'wieght+',
                                mini: true,
                                elevation: 1,
                                child: const Icon(
                                  Icons.add,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  /// age
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'العمــر',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8,),
                          Text(
                            '$_age',
                            style: const TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 8,),
                          /// two buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              /// minus
                              FloatingActionButton(
                                onPressed: (){
                                  setState(() {
                                    _age--;
                                  });
                                },
                                heroTag: 'age-',
                                mini: true,
                                elevation: 1,
                                child: const Icon(
                                  Icons.remove,
                                ),
                              ),
                              const SizedBox(width: 8,),
                              /// plus
                              FloatingActionButton(
                                onPressed: (){
                                  setState(() {
                                    _age++;
                                  });
                                },
                                heroTag: 'age+',
                                mini: true,
                                elevation: 1,
                                child: const Icon(
                                  Icons.add,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.blue,
            width: double.infinity,
            child: MaterialButton(
              color: Colors.pink,
              height: 60,
              onPressed: (){
                double result = _weight / pow(_height / 100, 2);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BMIResult(
                        age: _age,
                        gender: _isMale ? 'ذكر' : 'أنثى',
                        result: result.round(),
                      ),
                    ),
                );
              },
              child: const Text(
                'احـــســب',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 23,
                  letterSpacing: 0.5,
                ),
              ),
                ),
          ),
        ],
      ),
    );
  }
}
