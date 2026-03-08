import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constant.dart';

class ApiService {

  /// POST
  Future<dynamic> post(String endpoint, Map data, {String? token}) async {

    final res = await http.post(
      Uri.parse("${AppConstants.baseUrl}/$endpoint"),
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token"
      },
      body: jsonEncode(data),
    );

    return jsonDecode(res.body);
  }

  /// GET
  Future<dynamic> get(String endpoint,{String? token}) async {

    final res = await http.get(
        Uri.parse("${AppConstants.baseUrl}/$endpoint"),
        headers: {
          if(token != null) "Authorization": "Bearer $token"
        }
    );

    return jsonDecode(res.body);
  }

  /// DELETE
  Future delete(String endpoint,{String? token}) async {

    final res = await http.delete(
        Uri.parse("${AppConstants.baseUrl}/$endpoint"),
        headers: {
          if(token != null) "Authorization": "Bearer $token"
        }
    );

    return jsonDecode(res.body);
  }

}