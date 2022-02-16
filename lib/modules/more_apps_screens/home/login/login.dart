import 'package:firstapp/modules/more_apps_screens/home/home_screen.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _emailCtrl = TextEditingController();

  var _passwordCtrl = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
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
                SizedBox(
                  height: 20,
                ),
                //Login word title
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.blue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                //email
                TextFormField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
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
                SizedBox(
                  height: 20,
                ),
                //password
                TextFormField(
                  controller: _passwordCtrl,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _hidePassword,
                  validator: (value){
                    if (value.isEmpty) {
                      return 'Invalid password';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(
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
                SizedBox(
                  height: 30,
                ),
                // login button
                defaultButton(
                  onPressedFunction: (){
                    if (formKey.currentState.validate()) {
                      print(_passwordCtrl.text);
                    }
                  },
                  text: 'login',
                  backgroundColor: Colors.pink,
                  isUpperCase: false,
                  border: 12,
                  fontsize: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                    ),
                    // register now
                    TextButton(
                      onPressed: (){},
                      child: Text(
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