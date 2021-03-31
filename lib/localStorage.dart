import 'package:shared_preferences/shared_preferences.dart';

class storage {
  Future<String> _getUserNameFromSharePref(String userid) async {
    final prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString(userid);
    if (userName == null) {
      print("Not exists.");
      return "";
    } else {
      print(userName);
    }
    return userName;
  }

  Future<bool> _putUserNameToSharePref(String username) async {
    print("put into prefs");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("2", username);
    return true;
  }
}
