import 'package:firstapp/modules/more_apps_screens/home/counter/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterStates>{
  // set initial state to super
  CounterCubit() : super(CounterInitState());

  int counter = 1;

  static CounterCubit get (context){
    return BlocProvider.of(context);
  }

  void counterPlus (){
    counter++;
    emit(CounterPlusState());
  }

  void counterMinus(){
    counter--;
    emit(CounterMinusState());
  }
}