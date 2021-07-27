import 'package:flutter/material.dart';
import 'package:udemy_course/model/user/user_model.dart';

class UserScreen extends StatelessWidget {
  List<UserModel> users = [
    UserModel(
      id: 1,
      name: 'Hossam Bakry',
      phone: '+201066309866',
    ),
    UserModel(
      id: 2,
      name: 'Hazem Bakry',
      phone: '+201010805092',
    ),
    UserModel(
      id: 3,
      name: 'Mostafa Bakry',
      phone: '+201003061121',
    ),
    UserModel(
      id: 4,
      name: 'Mohamed Bakry',
      phone: '+201066309866',
    ),
    UserModel(
      id: 5,
      name: 'Salma Bakry',
      phone: '+201066309866',
    ),
    UserModel(
      id: 6,
      name: 'Hosina El Said ',
      phone: '+201066309866',
    ),
    UserModel(
      id: 7,
      name: 'Rana Yehia ',
      phone: '+201066309866',
    ),
    UserModel(
      id: 8,
      name: 'Hossam Bakry',
      phone: '+201066309866',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users',
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => buildItem(users[index]),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
        ),
        itemCount: users.length,
      ),
    );
  }

  Widget buildItem(UserModel value) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              child: Text(
                '#${value.id}',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${value.name}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${value.phone}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
