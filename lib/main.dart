import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:task_manager/screens/task_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/register_screen.dart';
import 'providers/task_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  Future<bool> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    if (token != null && token.isNotEmpty) {
      return true; // user pahle se hi logged in ho to
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,

        routes: {
          "/login": (_) => LoginScreen(),
          "/register": (_) => RegisterScreen(),
          "/dashboard": (_) => DashboardScreen(),
          "/taskScreen": (_)=> TaskScreen(),
        },

        home: FutureBuilder(
          future: checkLogin(),
          builder: (context, snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (snapshot.data == true) {
              return DashboardScreen(); // token exists kre tab
            } else {
              return LoginScreen(); //agar no token ho to
            }
          },
        ),
      ),
    );
  }
}