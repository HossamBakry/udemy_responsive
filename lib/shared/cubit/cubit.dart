import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy_course/modules/archived_tasks/archived_task_screen.dart';
import 'package:udemy_course/modules/done_tasks/done_task_screen.dart';
import 'package:udemy_course/modules/new_tasks/new_task_screen.dart';
import 'package:udemy_course/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    NewTaskScreen(),
    DoneTaskScreen(),
    ArchivedTaskScreen(),
  ];

  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  late Database database;

  List<Map> tasks = [];

  void createDatabase() {
    openDatabase(
      'Todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, data TEXT, time TEXT, status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error When Creating Table=> ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database).then((value) {
          tasks = value;
          print(tasks);
          emit(AppGetDatabaseState());
        });
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) async {
       txn.rawInsert(
              'INSERT INTO tasks(title, data, time, status) VALUES("$title", "$date", "$time", "new")')
          .then((value) {
        print('$value inserted successfuly');
        emit(AppInsertDatabaseState());

        getDataFromDatabase(database).then((value) {
          tasks = value;
          print(tasks);
          emit(AppGetDatabaseState());
          
        });
      }).catchError((error) {
        print('Error When Inserting Table=> ${error.toString()}');
      });
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {

    emit(AppGetDatabaseLoadingState());
    return await database.rawQuery('SELECT * FROM tasks');
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changBottomSheetState({
    required bool isShow,
    required IconData icone,
  })
  {
    isBottomSheetShown = isShow;
    fabIcon = icone;

    emit(AppChangeBottomSheetState());
  }
}
