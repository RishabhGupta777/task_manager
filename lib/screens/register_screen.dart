import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/widgets/button.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  final AuthService auth = AuthService();

  void register() async {
    try {

      final data = await auth.register(
        name.text,
        email.text,
        password.text,
      );

      if (data["message"] == "User already exists") {

        Get.snackbar(
          "Registration Failed",
          data["message"],
          snackPosition: SnackPosition.TOP,
        );

      } else {

        Get.snackbar(
          "Success",
          data["message"] ?? "Registration Successful",
          snackPosition: SnackPosition.BOTTOM,
        );

        Navigator.pushReplacementNamed(context, "/login");

      }

    } catch (e) {

      Get.snackbar(
        "Error",
        "Something went wrong",
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
                      Icons.person_add_alt_1,
                      size: 70,
                      color: Colors.deepPurple,
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      "Register to get started",
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),

                    SizedBox(height: 30),

                    TextField(
                      controller: name,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

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

                    TButton(
                      text: "Register",
                      onTap: register,
                      backgroundColor: Colors.deepPurple,
                      height: 50,
                    ),

                    SizedBox(height: 15),

                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Already have an account? Login",
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