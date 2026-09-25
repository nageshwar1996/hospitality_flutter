import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Text(
            "Register",
            style: TextStyle(
              fontFamily: "Inter",
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: Color(0xCC3E3E3E),
            ),
          ),
        ),
      ),
    );
  }
}
