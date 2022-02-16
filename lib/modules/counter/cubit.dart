import 'package:bloc/bloc.dart';
import 'package:firstapp/modules/counter/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterStates>{
  CounterCubit() : super(CounterInitState());

  static CounterCubit get(context){
    return BlocProvider.of(context);
  }

  int number = 0;


  void numberPlus(){
    this.number++;
    emit(CounterPlusState());
  }

  void numberMinus(){
    this.number--;
    emit(CounterMinusState());
  }

}