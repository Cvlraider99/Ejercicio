import 'package:shared_preferences/shared_preferences.dart';

guardarSesion (String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}