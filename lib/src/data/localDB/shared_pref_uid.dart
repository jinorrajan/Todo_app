import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManger{

  //save uid
  static Future<void> saveUid(uid) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("uid", uid);
  }

  //get uid
  static Future<String> getUid() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("uid") ?? "";
  }
}