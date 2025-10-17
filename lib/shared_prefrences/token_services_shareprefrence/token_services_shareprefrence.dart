import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/auth_model.dart';

class TokenServicesShareprefrence {
  // SharedPreferences key
  static const String _key = "userToken";

  /// Save token to local storage
  static Future<void> saveToken(TokenModel tokenModel) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(tokenModel.toJson());
    await prefs.setString(_key, jsonString);
  }

  /// Get token from local storage
  static Future<TokenModel?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString != null) {
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);
      return TokenModel.fromJson(jsonData);
    }
    return null;
  }

  /// Clear token from local storage (logout)
  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
