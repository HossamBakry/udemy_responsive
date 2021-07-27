import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color color = Colors.blue,
  bool isUpperCase = true,
  required Function function,
  required String text,
}) =>
    Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      width: width,
      child: MaterialButton(
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          function();
        },
      ),
    );

Widget defaultFormField({
  required Function validator,
  required TextEditingController? controller,
  required TextInputType? inputeType,
  Function? onSubmite,
  Function? onChnge,
  Function? onTap,
  bool isPassword = false,
  required String? labelText,
  IconData? priIcon,
  IconData? sufIcon,
  Function? sufpressed,
}) =>
    TextFormField(
      validator: (v) => validator(v),
      controller: controller,
      keyboardType: inputeType,
      obscureText: isPassword,
      onFieldSubmitted: (s) => onSubmite,
      onChanged: (s) => onChnge,
      onTap: () {
        onTap!();
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        labelText: labelText,
        prefixIcon: Icon(priIcon),
        suffixIcon: sufIcon != null
            ? IconButton(
                onPressed: () {
                  sufpressed!();
                },
                icon: Icon(sufIcon),
              )
            : null,
      ),
    );

Widget buildTasksItem(Map model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${model['time']}',
                style: TextStyle(fontSize: 16.0),
                // overflow: TextOverflow.clip,
                // maxLines: 2,
              ),
            ),
          ),
          SizedBox(width: 15.0),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model['title']}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                '${model['data']}',
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ],
      ),
    );
