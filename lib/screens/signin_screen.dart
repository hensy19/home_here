import 'package:flutter/material.dart';
import '../main.dart'; // 🔹 Import MyApp to access isOwnerMode
import 'signup_screen.dart';
import 'select_location_screen.dart';
import 'owner_signin_screen.dart';
import 'forgot_pw_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 🔹 Ensure theme switches back to USER mode when this screen loads
    MyApp.isOwnerMode.value = false;
  }

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SelectLocationScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade700,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ---------- HEADER ----------
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: Image.asset("assets/logo.png", fit: BoxFit.contain),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Sign in",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(33, 150, 243, 1),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: "Email",
                              hintText: "abc@gmail.com",
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your email";
                              }
                              if (!value.contains("@gmail.com")) {
                                return "Enter a valid email";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: "Password",
                              hintText: "your password",
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your password";
                              }
                              if (value.length < 6) {
                                return "Password must be at least 6 characters";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade700,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            onPressed: _signIn,
                            child: const Text(
                              "Continue",
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 15),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgotPasswordPage(),
                                ),
                              );
                            },
                            child: const Text(
                              "Forgot password?",
                              style: TextStyle(
                                color: Colors.black54,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ---------- FOOTER ----------
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don’t have an account? ",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // 🔹 OWNER SIGN-IN LINK
                  GestureDetector(
                    onTap: () {
                      // When going to owner panel, switch theme mode before navigation
                      MyApp.isOwnerMode.value = true;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OwnerSignInScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Want to register your property? Owner Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
