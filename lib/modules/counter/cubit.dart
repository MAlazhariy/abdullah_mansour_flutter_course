import 'package:firstapp/modules/counter/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterStates>{
  CounterCubit() : super(CounterInitState());

  static CounterCubit get(context){
    return BlocProvider.of(context);
  }

  int number = 0;


  void numberPlus(){
    number++;
    emit(CounterPlusState());
  }

  void numberMinus(){
    number--;
    emit(CounterMinusState());
  }

}