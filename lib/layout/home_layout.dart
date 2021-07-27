import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy_course/modules/archived_tasks/archived_task_screen.dart';
import 'package:udemy_course/modules/done_tasks/done_task_screen.dart';
import 'package:udemy_course/modules/new_tasks/new_task_screen.dart';
import 'package:udemy_course/shared/components/components.dart';
import 'package:udemy_course/shared/components/constants.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:udemy_course/shared/cubit/cubit.dart';
import 'package:udemy_course/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if(state is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            key: scaffoldkey,
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
              ),
            ),
            body: Conditional.single(
              context: context,
              conditionBuilder: (context) => state is! AppGetDatabaseLoadingState,
              widgetBuilder: (context) => cubit.screens[cubit.currentIndex],
              fallbackBuilder: (context) =>
                  Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.teal,
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formkey.currentState!.validate())
                  cubit.insertToDatabase(
                    title: titleController.text,
                    time: timeController.text,
                    date: dateController.text,
                  );
                } else {
                  scaffoldkey.currentState!
                      .showBottomSheet(
                        (context) => Container(
                          padding: EdgeInsets.all(20.0),
                          child: Form(
                            key: formkey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'title must not be empty';
                                    }
                                  },
                                  controller: titleController,
                                  onTap: () {},
                                  inputeType: TextInputType.text,
                                  labelText: 'Task Title',
                                  priIcon: Icons.title,
                                ),
                                SizedBox(height: 15.0),
                                defaultFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'time must not be empty';
                                    }
                                  },
                                  controller: timeController,
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text =
                                          value!.format(context).toString();
                                    }).catchError((error) {
                                      print('Error => ${error.toString()}');
                                    });
                                    print('timeing tabed');
                                  },
                                  inputeType: TextInputType.datetime,
                                  labelText: 'Task Time',
                                  priIcon: Icons.watch_later_outlined,
                                ),
                                SizedBox(height: 15.0),
                                defaultFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'date must not be empty';
                                    }
                                  },
                                  controller: dateController,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2021-08-25'),
                                    ).then((value) {
                                      dateController.text =
                                          DateFormat.yMMMd().format((value!));
                                    }).catchError((error) {
                                      print('Error => ${error.toString()}');
                                    });
                                  },
                                  inputeType: TextInputType.datetime,
                                  labelText: 'Task Date',
                                  priIcon: Icons.calendar_today,
                                ),
                              ],
                            ),
                          ),
                        ),
                        elevation: 20.0,
                      )
                      .closed
                      .then((value) {
                    cubit.changBottomSheetState(
                      isShow: false,
                      icone: Icons.edit,
                    );
                  });
                  cubit.changBottomSheetState(
                    isShow: true,
                    icone: Icons.add,
                  );
                }
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.teal,
              selectedFontSize: 16,
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: 'Archived',
                ),
              ],
            ),

          );
        },
      ),
    );
  }
}
