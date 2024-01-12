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
}

class Cameras {
  late String cameraID;
  late String name;
  Cameras(this.cameraID, this.name);
}
