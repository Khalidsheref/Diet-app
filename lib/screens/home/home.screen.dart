import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_app/core/services.dart';
import 'package:diet_app/screens/auth/login.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/data/user.model.dart';
import '../../core/utils/local_storage.utils.dart';

class HomeScreen extends StatefulWidget {
  final String? idToken;
  const HomeScreen({super.key,this.idToken});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? user;

  signOut() async{
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c) => LoginScreen()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text(
              'No Data...',
            );
          } else {
            for (var doc in snapshot.data!.docs) {
              user = UserModel.fromJson(doc.data());
              print("doc $doc ${LocalStorageUtils.getMyDocId()}");
            }
            return Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/pic1.png'), fit: BoxFit.cover)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () { Navigator.pop(context); }, icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.black,
                            size: 35,),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text('Welcome, ${user?.fullName} to our application',
                                style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),maxLines: 2,softWrap: true,),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ElevatedButton(
                          onPressed: () async {
                            signOut();
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.green[800] ?? Colors.green)),
                          child: const Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: 80.0, vertical: 12.0),
                            child: Text(
                              'Sign out',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400,color: Colors.amber),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            );
          }
        }
      ),
    );
  }
}
