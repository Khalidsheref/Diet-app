import 'package:diet_app/screens/auth/login.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../core/data/user.model.dart';
import '../../core/services.dart';
import '../../core/utils/local_storage.utils.dart';
import '../../widgets/overlay_loading.dart';
import '../home/home.screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController? userNameCont = TextEditingController();

  TextEditingController? emailCont = TextEditingController();

  TextEditingController? passCont = TextEditingController();

  TextEditingController? confirmPassCont = TextEditingController();

  UserCredential? userCredential;
  String? idToken;
  GlobalKey<FormState> formkey = GlobalKey();

  late LoadingOverlay overlay;

  goToLogin() {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (c) => LoginScreen()), (route) => false);
    userNameCont?.clear();
    emailCont?.clear();
    passCont?.clear();
    confirmPassCont?.clear();
  }

  signUp() async {
    overlay.show();
    if (passCont?.text != confirmPassCont?.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('your confirmation password does not match your password'),
        ),
      );
      overlay.hide();
      return;
    }
    if (emailCont?.text != '' &&
        passCont?.text != '' &&
        passCont?.text == confirmPassCont?.text) {
      try {
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailCont!.text.trim(), password: passCont!.text.trim());
        idToken = await userCredential?.user?.getIdToken();
        LocalStorageUtils.setToken(idToken);
        FireBaseUtils.pushToFireBase(UserModel(
            fullName: userNameCont?.text,
            email: userCredential?.user?.email,
            token: idToken));
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
                image: AssetImage('assets/pic3.png'), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Form(
            key: formkey,
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 8.0),
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
                Center(
                  child: Text('Register',
                      style: TextStyle(
                          fontSize: 50,
                          color: Colors.green[900],
                          fontWeight: FontWeight.w500)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Create your new account',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.green[800],
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Card(
                        color: Colors.white70,
                        child: TextFormField(
                          validator: (data) {
                            if (data!.isEmpty) {
                              return 'Full Name is Required';
                            }
                          },
                          controller: userNameCont,
                          decoration: InputDecoration(
                              hintText: 'full name',
                              prefixIcon: const Icon(
                                Icons.person,
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
                              return 'Password is Required';
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Card(
                        color: Colors.white70,
                        child: TextFormField(
                          controller: confirmPassCont,
                          decoration: InputDecoration(
                              hintText: 'confirm password',
                              prefixIcon: const Icon(
                                Icons.lock,
                                size: 20,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none)),
                          obscureText: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ElevatedButton(
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              return signUp();
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) =>
                                      Colors.green[800] ?? Colors.green)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 80.0, vertical: 12.0),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.amber),
                            ),
                          )),
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: Colors.black),
                        text: 'I have already account ? ',
                        children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = goToLogin,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.green[900]),
                              text: 'login'),
                        ],
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
    ;
  }
}
