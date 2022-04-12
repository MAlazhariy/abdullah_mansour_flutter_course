import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CounterCubit(),
        child: BlocConsumer<CounterCubit, CounterStates>(
          listener: (context, state){},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Counter',
                ),
              ),
              body: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// sub
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blue,
                      child: TextButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.zero
                          ),
                        ),
                        onPressed: (){
                          CounterCubit.get(context).counterMinus();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            '-',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 35,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Text(
                        '${CounterCubit.get(context).counter}',
                        style: TextStyle(
                          fontSize: 60,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    /// plus
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blue,
                      child: TextButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.zero
                          ),
                        ),
                        onPressed: (){
                          CounterCubit.get(context).counterPlus();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            '+',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
    );
  }
}
