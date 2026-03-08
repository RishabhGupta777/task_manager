import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiTest extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  ApiTest({super.key});

  Future<void> testLogin() async {

    try {

      final url = Uri.parse("http://localhost:3000/api/user/login");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "email": emailController.text,
          "password": passwordController.text
        }),
      );

      print("Status Code: ${response.statusCode}");
      print("Response: ${response.body}");

    } catch (e) {

      print("Error: $e");

    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("API Login Test"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(

          children: [

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "Enter Email",
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Enter Password",
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: testLogin,
              child: const Text("Test Login API"),
            ),

          ],
        ),
      ),
    );
  }
}