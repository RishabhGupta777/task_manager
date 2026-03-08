import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/login_screen.dart';
import 'api_services.dart';
class AuthService {
  final ApiService _api = ApiService();


  Future login(String email,String password) async {
    final data = await _api.post("user/login",{
      "email":email,
      "password":password
    });

    /// if login failed
    if(data["token"] == null){
      return data;
    }

    // save token
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token",data["token"]);
    await prefs.setString("userId", data["user"]["_id"]); // save userId

    return data;
  }

  ///Register the users
  Future register(String name,String email,String password) async {
    return await _api.post("user/register",{
      "name":name,
      "email":email,
      "password":password
    });
  }

   ///Logout
  Future logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    await prefs.remove("userId");
    Get.offAllNamed("/login");

  }



}
