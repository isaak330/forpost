import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:forpost/src/Repos/memory.dart';

class GetCamerasListRepo {
  static Future<List<Cameras>> GetCamerasList() async {
    var sessionID = await GetSessionID();
    List<Cameras> sumResponse = [];
    var response = await Dio().post('http://94.230.129.25/api/GetCameras',
        data: ({
          'SessionID': sessionID,
        }),
        options: Options(contentType: Headers.formUrlEncodedContentType));
    var sass = jsonDecode(response.data)[0]['Name'];
    var length = jsonDecode(response.data).length;
    for (var i = 0; i < length; i++) {
      sumResponse.add(Cameras(
          jsonDecode(response.data)[i]['CameraID'].toString(),
          jsonDecode(response.data)[i]['Name']));
    }
    return sumResponse;
  }

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

class Cameras {
  late String cameraID;
  late String name;
  Cameras(this.cameraID, this.name);
}
