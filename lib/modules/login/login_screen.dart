import 'package:flutter/material.dart';
import 'package:udemy_course/shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool ispassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40),
                  defaultFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'email adress can\'t be empty';
                      }
                      return null;
                    },
                    controller: emailController,
                    inputeType: TextInputType.emailAddress,
                    priIcon: Icons.email,
                    sufIcon: null,
                    labelText: 'E-mail Adress',
                  ),
                  SizedBox(height: 15.0),
                  defaultFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'password adress can\'t be empty';
                      }
                      return null;
                    },
                    controller: passwordController,
                    inputeType: TextInputType.visiblePassword,
                    isPassword: ispassword,
                    sufpressed: () {
                      setState(() {
                        ispassword = !ispassword;
                      });
                    },
                    labelText: 'Password',
                    priIcon: Icons.lock,
                    sufIcon:
                        ispassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  SizedBox(height: 15.0),
                  defaultButton(
                    text: 'Login',
                    function: () {
                      if (formKey.currentState!.validate()) {
                        print(emailController.text);
                        print(passwordController.text);
                      }
                    },
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'don\'t have account ?',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('Register now '),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
