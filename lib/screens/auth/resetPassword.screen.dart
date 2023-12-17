import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/overlay_loading.dart';

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController? emailCont = TextEditingController();

  late LoadingOverlay overlay;

  resetPassword() async {
    overlay.show();
    if (emailCont?.text != '') {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailCont?.text ?? "");
      overlay.hide();
      Navigator.pop(context);
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
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
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text('Forget password',
                          style: TextStyle(
                              fontSize: 35,
                              color: Colors.white54,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 70),
              const Text('Mail Address Here',
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.white54,
                      fontWeight: FontWeight.w600)),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                    'Enter your email address associated with your account',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Card(
                  color: Colors.white70,
                  child: TextFormField(
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
                child: ElevatedButton(
                    onPressed: () async {
                      resetPassword();
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.green[800] ?? Colors.green)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 70.0, vertical: 10.0),
                      child: Text(
                        'Reset password',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            color: Colors.amber),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
