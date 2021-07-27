import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:udemy_course/layout/home_layout.dart';
import 'package:udemy_course/modules/bmi/bmi_calculator.dart';
import 'package:udemy_course/modules/counter/counter_screen.dart';
import 'package:udemy_course/modules/login/login_screen.dart';
import 'package:udemy_course/modules/messenger/messenger_screen.dart';
import 'package:udemy_course/modules/users/user_screen.dart';
import 'package:udemy_course/shared/bloc_observer.dart';
void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.teal),
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}
