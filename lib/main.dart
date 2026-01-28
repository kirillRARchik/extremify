import 'package:flutter/material.dart';
import 'register_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    home: const RegisterScreen(),
  ));
}