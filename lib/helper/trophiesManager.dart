// import 'package:shared_preferences/shared_preferences.dart';

// class TrophiesManager {
//   static const String _trophiesKey = 'trophies';

//   // استرجاع عدد الكؤوس من SharedPreferences
//   static Future<int> getTrophies() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getInt(_trophiesKey) ?? 0;
//   }

//   // حفظ عدد الكؤوس في SharedPreferences
//   static Future<void> setTrophies(int trophies) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setInt(_trophiesKey, trophies);
//   }

//   // زيادة عدد الكؤوس وحفظها
//   static Future<void> incrementTrophies() async {
//     int currentTrophies = await getTrophies();
//     await setTrophies(currentTrophies + 1);
//   }
// }
