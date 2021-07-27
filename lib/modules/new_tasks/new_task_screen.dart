import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_course/shared/components/components.dart';
import 'package:udemy_course/shared/components/constants.dart';
import 'package:udemy_course/shared/cubit/cubit.dart';
import 'package:udemy_course/shared/cubit/states.dart';

class NewTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var tasks = AppCubit.get(context).tasks;
        return ListView.separated(
          itemBuilder: (context, index) => buildTasksItem(tasks[index]),
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey ,
            ),
          ),
          itemCount: tasks.length,
        );
      },
    );
  }
}
