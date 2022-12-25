// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.pink.shade200, Colors.purple.shade600],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight),
        ),
        child: SpinKitFadingCircle(
          color: Colors.blue.shade300,
          size: 50,
          duration: Duration(milliseconds: 1500),
        ),
      ),
    );
  }
}
