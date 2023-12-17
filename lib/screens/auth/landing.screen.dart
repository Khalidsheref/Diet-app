import 'package:diet_app/screens/auth/login.screen.dart';
import 'package:diet_app/screens/auth/signup.screen.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/pic3.png'), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Healthy',
                style: TextStyle(
                    fontSize: 50,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('LifeStyle',
                      style: TextStyle(
                          fontSize: 50,
                          color: Colors.black,
                          fontWeight: FontWeight.w600))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (c)=> const SignUpScreen()));
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.white)),
                          child: const Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: 80.0, vertical: 12.0),
                            child: Text(
                              'Sign Up',
                              style:
                              TextStyle(fontSize: 15, fontWeight: FontWeight.w400,color: Colors.green),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.green[800] ?? Colors.green)),
                        child: const Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 80.0, vertical: 12.0),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
