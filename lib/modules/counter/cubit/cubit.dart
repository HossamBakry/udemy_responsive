import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/modules/counter/cubit/states.dart';

class CounterCubit extends Cubit<CounterStates>{

  CounterCubit() : super(CounterInitialSate());

  static CounterCubit get(context) => BlocProvider.of(context);

  int counter = 0;

  void minus()
  {
    counter--;
    emit(CounterMinusSate(counter));
  }

  void plus()
  {
    counter++;
    emit(CounterPlusSate(counter));
  }
}