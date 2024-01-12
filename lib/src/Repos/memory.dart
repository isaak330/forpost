import 'package:shared_preferences/shared_preferences.dart';

AddSessionID(String sessionID) async {
  SharedPreferences session = await SharedPreferences.getInstance();
  await session.setString('stringValue', sessionID);
}

Future<String> GetSessionID() async {
  SharedPreferences session = await SharedPreferences.getInstance();
  String? stringValue = session.getString('stringValue');
  return stringValue!;
}
