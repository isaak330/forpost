import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:forpost/src/Repos/memory.dart';
import 'package:unixtime/unixtime.dart';

class GetArchiveRepo {
  static Future GetArchive(int cameraId) async {
    final sessionID = await GetSessionID();
    // final currentTimeZone = await FlutterTimezone.getLocalTimezone();
    final archiveTime = DateTime.now().unixtime - 180;
    print(archiveTime);
    final response = await Dio().post('http://94.230.129.25/api/GetDownloadURL',
        data: ({
          'SessionID': sessionID,
          'CameraID': cameraId,
          'Duration': 3,
          'TS': archiveTime,
          'TZ': 5
        }),
        options: Options(contentType: Headers.formUrlEncodedContentType));
    final archiveLink = jsonDecode(response.data)['URL'] as String;
    return archiveLink;
  }
}
