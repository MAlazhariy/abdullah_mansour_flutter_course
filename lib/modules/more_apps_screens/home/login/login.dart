import 'dart:developer';

import 'package:firstapp/shared/components/components.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();

  final _passwordCtrl = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Mostafa Alazhariy',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                //Login word title
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.blue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                //email
                TextFormField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(15)
                      ),
                      // gapPadding: 50.0,
                    ),
                    // suffixText: '@gmail.com',
                    labelText: 'Email Address',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //password
                TextFormField(
                  controller: _passwordCtrl,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _hidePassword,
                  validator: (value){
                    if (value!.isEmpty) {
                      return 'Invalid password';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(
                      Icons.lock,
                    ),
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          _hidePassword = !_hidePassword;
                        });
                      },
                      icon: Icon(
                        _hidePassword
                            ? Icons.remove_red_eye : Icons.visibility_off,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                // login button
                defaultButton(
                  onPressedFunction: (){
                    if (formKey.currentState!.validate()) {
                      log(_passwordCtrl.text);
                    }
                  },
                  text: 'login',
                  backgroundColor: Colors.pink,
                  isUpperCase: false,
                  border: 12,
                  fontSize: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                    ),
                    // register now
                    TextButton(
                      onPressed: (){},
                      child: const Text(
                        'Regiser now',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}