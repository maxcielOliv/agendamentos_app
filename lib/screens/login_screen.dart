import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final _db = FirebaseFirestore.instance;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My App',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 44.0,
            ),
            const TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'User Email',
                labelStyle: TextStyle(fontSize: 20),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 26.0,
            ),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'User Password',
                labelStyle: TextStyle(fontSize: 20),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 88.0,
            ),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: const Color(0xFF0069FE),
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('HomePage');
                },
                child: const Text('Login', style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
