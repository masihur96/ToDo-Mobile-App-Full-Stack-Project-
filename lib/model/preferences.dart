
import 'package:shared_preferences/shared_preferences.dart';


class SharedPref {

  Future<bool> setToken({required String token}) async {
    final prefs = await SharedPreferences.getInstance();
    bool status = await prefs.setString(
        'token',token);
    return status;
  }
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? prefToken = prefs.getString('token');
    return prefToken!;
  }
    Future<bool> removeToken() async {
      final prefs = await SharedPreferences.getInstance();
      bool status = await prefs.remove('token');
      return status;
    }

  Future<bool> setUserId({required String id}) async {
    final prefs = await SharedPreferences.getInstance();
    bool status = await prefs.setString(
        'userId',id);
    return status;
  }
    Future<String> getUserId() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('userId')!;
    }


}