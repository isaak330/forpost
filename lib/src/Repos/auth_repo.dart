import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:forpost/src/Repos/memory.dart';

class AuthRepo {
  static Future<String> auth(String login, String password) async {
    final Response response;
    final String sessionID;
    try {
      response = await Dio().post('http://94.230.129.25//api/Login',
          data: ({'Login': login, 'Password': password}),
          options: Options(contentType: Headers.formUrlEncodedContentType));

      sessionID = jsonDecode(response.data)['SessionID'] as String;
      await AddSessionID(sessionID);
      return sessionID;
    } catch (e) {
      return 'error';
    }
  }
}
