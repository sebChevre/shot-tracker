import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/versions_info.dart';

class ShootTrackerService {
  static Future<VersionInfo> loadVersionInfo() async {
    http.Client client = http.Client();
    final response = await client.get(Uri.parse('/version.json'));

    return _parseVersionInfo(response.body);
  }

  static VersionInfo _parseVersionInfo(String responseBody) {
    dynamic json = jsonDecode(responseBody);

    VersionInfo versionInfo = VersionInfo.noInfos();

    try {
      versionInfo = VersionInfo.fromJson(json);
    } catch (e) {
      print("No version infos available, default will be returned");
    }
    return versionInfo;
  }
}
