import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CounterStates {}

class CounterInitState extends CounterStates {}

class CounterPlusState extends CounterStates {}

class CounterMinusState extends CounterStates {}