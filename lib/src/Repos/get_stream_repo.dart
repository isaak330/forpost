import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:forpost/src/Repos/memory.dart';

class GetStreamRepo {
  static Future GetStream(int cameraID) async {
    final sessionID = await GetSessionID();
    final response = await Dio().post(
        'http://94.230.129.25/api/GetTranslationURL',
        data: ({
          'SessionID': sessionID,
          'CameraID': cameraID,
          'Format': 'RTSP'
        }),
        options: Options(contentType: Headers.formUrlEncodedContentType));
    final streamLink = jsonDecode(response.data)['URL'] as String;
    return streamLink;
  }
}
