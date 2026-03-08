import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/widgets/button.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  final AuthService auth = AuthService();

  void login() async {

    final data = await auth.login(email.text, password.text);

    // Login success
    if (data != null && data["token"] != null) {

      Get.snackbar(
        "Success",
        "Login Successful",
        snackPosition: SnackPosition.BOTTOM,
      );

      Navigator.pushReplacementNamed(context, "/dashboard");

    }
    // Login failed
    else {

      Get.snackbar(
        "Login Failed",
        data?["message"] ?? "Invalid credentials",
        snackPosition: SnackPosition.TOP,
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      spreadRadius: 2,
                      offset: Offset(0, 6),
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Icon(
                      Icons.lock_outline,
                      size: 70,
                      color: Colors.deepPurple,
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      "Login to continue",
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),

                    SizedBox(height: 30),

                    TextField(
                      controller: email,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    TextField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),

                    SizedBox(height: 30),

                    TButton(text:"Login",onTap:login,backgroundColor: Colors.deepPurple,height: 50,),

                    SizedBox(height: 15),

                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/register");
                      },
                      child: Text(
                        "Don't have an account? Sign up",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}