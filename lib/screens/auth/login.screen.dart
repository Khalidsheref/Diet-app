import 'package:diet_app/core/data/user.model.dart';
import 'package:diet_app/core/services.dart';
import 'package:diet_app/core/utils/local_storage.utils.dart';
import 'package:diet_app/screens/auth/resetPassword.screen.dart';
import 'package:diet_app/screens/auth/signup.screen.dart';
import 'package:diet_app/screens/home/home.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../widgets/overlay_loading.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? emailCont = TextEditingController();

  TextEditingController? passCont = TextEditingController();

  UserCredential? userCredential;
  String? idToken;
  GlobalKey<FormState> formkey = GlobalKey();

  late LoadingOverlay overlay;

  goToResetPassword() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (c) => ResetPasswordScreen()));
  }

  goToSignUp() {
    Navigator.push(context, MaterialPageRoute(builder: (c) => SignUpScreen()));
    emailCont?.clear();
    passCont?.clear();
  }

  login() async {
    overlay.show();
    if (emailCont?.text != '' && passCont?.text != '') {
      try {
        userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailCont?.text ?? "", password: passCont?.text ?? "");
        idToken = await userCredential?.user?.getIdToken();
        LocalStorageUtils.setToken(idToken);
        overlay.hide();
        if (userCredential != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (c) => HomeScreen(
                        idToken: idToken?.substring(0, 6),
                      )),
              (route) => false);
        }
      } catch (e) {
        overlay.hide();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$e'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('fill the fields'),
        ),
      );
      overlay.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    overlay = LoadingOverlay.of(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/pict2.png'), fit: BoxFit.cover)),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Center(
                  child: Text('Welcome Back!',
                      style: TextStyle(
                          fontSize: 50,
                          color: Colors.green[900],
                          fontWeight: FontWeight.w500)),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Card(
                        color: Colors.white70,
                        child: TextFormField(
                          validator: (data) {
                            if (data!.isEmpty) {
                              return 'Email is Required';
                            }
                          },
                          controller: emailCont,
                          decoration: InputDecoration(
                              hintText: 'email',
                              prefixIcon: const Icon(
                                Icons.mail,
                                size: 20,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Card(
                        color: Colors.white70,
                        child: TextFormField(
                          validator: (data) {
                            if (data!.isEmpty) {
                              return 'Password is required';
                            }
                            if (data.length > 8) {
                              return 'password is weak ';
                            }
                          },
                          controller: passCont,
                          decoration: InputDecoration(
                            hintText: 'password',
                            prefixIcon: const Icon(
                              Icons.lock,
                              size: 20,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none),
                          ),
                          obscureText: true,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                            onPressed: () {
                              goToResetPassword();
                            },
                            child: Text(
                              'forgot password',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.green[900]),
                            )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ElevatedButton(
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              return login();
                            }
                            ;
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) =>
                                      Colors.green[800] ?? Colors.green)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 80.0, vertical: 12.0),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                          )),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Do not have an account?',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              goToSignUp();
                            },
                            child: Text(
                              'signup',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.green[900]),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
