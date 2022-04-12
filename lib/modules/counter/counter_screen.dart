import 'package:firstapp/modules/counter/cubit.dart';
import 'package:firstapp/modules/counter/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Counter extends StatelessWidget {
  const Counter({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
          listener: (context, state){},
          builder: (context, state){

            CounterCubit cubit = CounterCubit.get(context);

            return Scaffold(
              body: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 15,),
                    IconButton(
                      onPressed: (){
                        cubit.numberPlus();
                      },
                      icon: const Icon(Icons.add),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          '${cubit.number}',
                          style: const TextStyle(
                            fontSize: 50,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                        cubit.numberMinus();
                      },
                      icon: const Icon(Icons.minimize),
                    ),
                    const SizedBox(width: 15,),
                  ],
                ),
              ),
            );
          },
      ),
    );
  }
}
