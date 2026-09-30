import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../register/register_screen.dart';
import '../verify-otp/verify_otp_screen.dart';

class LoginScreenV2 extends StatefulWidget {
  const LoginScreenV2({super.key});
  @override
  State<LoginScreenV2> createState() => _LoginScreenV2State();
}

class _LoginScreenV2State extends State<LoginScreenV2> {
  String phone = "";
  String countryCode = '+91';
  bool _isLoading = false;

  List<dynamic> countryCodes = [];

  Future<void> fetchCountryCodes() async {
    try {
      final res = await http.get(
        Uri.parse('${dotenv.env['API_BASE_URL']}/api/v1/country-codes'),
      );
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        setState(() {
          countryCodes = data['data']['countryCodes'];
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Unable to fetch country codes. Please try again."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _handleLogin() async {
    if (phone.isEmpty || countryCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter phone number"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('${dotenv.env['API_BASE_URL']}/api/v1/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"phoneNumber": phone, "countryCode": countryCode}),
      );

      if (!mounted) return;

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        // Store auth token in SharedPreferences
        final String token =
            data['token'] ??
            data['accessToken'] ??
            data['data']?['token'] ??
            'logged_in_user_token';

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message'] ?? "Login Successful!"),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const VerifyOTPScreen()),
        );
      } else {
        Map<String, dynamic>? errorData;
        try {
          errorData = jsonDecode(response.body);
        } catch (_) {}

        final errorMessage =
            errorData?['message'] ??
            "Login failed. (Code: ${response.statusCode})";

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
        );
      }
    } on SocketException {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Unable to connect. Please check your internet connection.",
          ),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An error occurred: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCountryCodes();
  }

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
            // SingleChildScrollView is a widget that allows the user to scroll through a list of widgets
            // when the content is larger than the screen
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            // use to global padding for whole screen
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
                SizedBox(
                  height: 52,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        phone = value;
                      });
                    },
                    keyboardType: TextInputType.phone,
                    cursorColor: const Color(0xFF009FA8),
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Color(0xFF000000),
                    ),
                    decoration: InputDecoration(
                      hintText: "Enter phone number",
                      hintStyle: TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Color(0xFF000000),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFFB2B2B2),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF009FA8)),
                      ),
                      prefixIcon: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFB2B2B2),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                          color: Color(0x33B2B2B2),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 7,
                        ),
                        child: DropdownButton<String>(
                          icon: const SizedBox.shrink(),
                          underline: SizedBox(),
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: Color(0xFF000000),
                          ),
                          value:
                              countryCodes.any(
                                (country) =>
                                    country['dial_code'] == countryCode,
                              )
                              ? countryCode
                              : null,
                          items: countryCodes.map((country) {
                            return DropdownMenuItem<String>(
                              value: country['dial_code'],
                              child: Text(country['dial_code']),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              countryCode = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 35),
                SizedBox(
                  height: 52,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_isLoading) return;
                      _handleLogin();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF009FA8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Continue",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 34),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "New to Zydus App ?",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Color(0xFF000000),
                        ),
                      ),
                      SizedBox(width: 4),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Sing up now",
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Color(0xFFB355A0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 14),
                Center(
                  child: Text(
                    "or sing up in with",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
                SizedBox(height: 21),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          debugPrint("Google login");
                        },
                        icon: Image.asset("assets/images/google.png"),
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        onPressed: () {
                          debugPrint("Facebook login");
                        },
                        icon: Image.asset("assets/images/facebook.png"),
                      ),
                    ],
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
