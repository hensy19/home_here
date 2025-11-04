import 'package:flutter/material.dart';
import 'owner_signin_screen.dart';

class OwnerSignUpScreen extends StatefulWidget {
  const OwnerSignUpScreen({super.key});

  @override
  State<OwnerSignUpScreen> createState() => _OwnerSignUpScreenState();
}

class _OwnerSignUpScreenState extends State<OwnerSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final pass = TextEditingController();
  final confirm = TextEditingController();
  final property = TextEditingController();
  final location = TextEditingController();

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OwnerSignInScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF004AAD),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: Image.asset("assets/logo.png", fit: BoxFit.contain),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Owner Sign up",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF004AAD),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(controller: name, decoration: const InputDecoration(labelText: "Name", border: OutlineInputBorder()), validator: (v) => v!.isEmpty ? "Enter name" : null),
                          const SizedBox(height: 12),
                          TextFormField(controller: email, decoration: const InputDecoration(labelText: "Email", border: OutlineInputBorder()), validator: (v) => v!.contains("@") ? null : "Invalid email"),
                          const SizedBox(height: 12),
                          TextFormField(controller: phone, decoration: const InputDecoration(labelText: "Phone Number", border: OutlineInputBorder()), keyboardType: TextInputType.phone, validator: (v) => v!.length < 10 ? "Enter valid number" : null),
                          const SizedBox(height: 12),
                          TextFormField(controller: pass, obscureText: true, decoration: const InputDecoration(labelText: "Password", border: OutlineInputBorder()), validator: (v) => v!.length < 6 ? "Min 6 chars" : null),
                          const SizedBox(height: 12),
                          TextFormField(controller: confirm, obscureText: true, decoration: const InputDecoration(labelText: "Confirm password", border: OutlineInputBorder()), validator: (v) => v != pass.text ? "Passwords don’t match" : null),
                          const SizedBox(height: 12),
                          TextFormField(controller: property, decoration: const InputDecoration(labelText: "Property Name", border: OutlineInputBorder())),
                          const SizedBox(height: 12),
                          TextFormField(controller: location, decoration: const InputDecoration(labelText: "Location", border: OutlineInputBorder())),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _signUp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF004AAD),
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Text("Continue", style: TextStyle(color: Colors.white, fontSize: 16)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const OwnerSignInScreen()),
                  );
                },
                child: const Text(
                  "Already have an owner account? Sign in",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
