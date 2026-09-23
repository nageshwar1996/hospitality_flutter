import 'package:flutter/material.dart';

class LoginScreenV2 extends StatefulWidget {
  const LoginScreenV2({super.key});
  @override
  State<LoginScreenV2> createState() => _LoginScreenV2State();
}

class _LoginScreenV2State extends State<LoginScreenV2> {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      // Scaffold is a widget that provides a standard Material Design layout structure for a screen
      body: SafeArea(
        // SafeArea is a widget that ensures that its child is displayed within the safe area of the screen
        // which is the area that is not covered by the status bar, navigation bar, or other system UI
        child: GestureDetector(
          // GestureDetector is a widget that detects gestures such as taps, drags, and
          // long presses
          onTap: () {
            FocusScope.of(context).unfocus();
            // unfocus() is a method that removes the focus from the current focus node
            // (keyboard) when the user taps anywhere else on the screen
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Center(child: Image.asset("assets/images/login.png")),
                SizedBox(height: 31),
                Text(
                  "Login",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Color(0xCC3E3E3E),
                  ),
                ),
                SizedBox(height: 45),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Enter phone number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: DropdownButton<String>(
                      value: '+91',
                      items: [
                        DropdownMenuItem(value: '+91', child: Text('+91')),
                        DropdownMenuItem(value: '+1', child: Text('+1')),
                      ],
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Color(0xFF000000),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
