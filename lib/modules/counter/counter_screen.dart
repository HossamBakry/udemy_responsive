import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/modules/counter/cubit/cubit.dart';
import 'package:udemy_course/modules/counter/cubit/states.dart';

class CounterScreen extends StatelessWidget {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener:  (context, state) {
          if(state is CounterPlusSate)
          {
            print('plus state ${state.counter}');
          }
          if(state is CounterMinusSate)
          {
            print('minus state ${state.counter}');
          }
        },
        builder: (context, state)
        {
          return Scaffold(
            appBar: AppBar(
              title: Text('Counter'),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: Text(
                      'MINS',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onPressed: ()
                    {
                      CounterCubit.get(context).minus();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      '${CounterCubit.get(context).counter}',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  TextButton(
                    child: Text(
                      'PLUS',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onPressed: ()
                    {
                      CounterCubit.get(context).plus();
                    },
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


