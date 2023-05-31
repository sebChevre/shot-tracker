class VersionInfo {
  final String appName;
  final String version;
  final String buildNumber;
  final String packageName;
  final String time;
  final String comitId;
  final String branch;

  const VersionInfo(
      {required this.appName,
      required this.version,
      required this.buildNumber,
      required this.packageName,
      required this.comitId,
      required this.branch,
      required this.time});

  factory VersionInfo.fromJson(Map<String, dynamic> json) {
    return VersionInfo(
      appName: json['app_name'] as String,
      version: json['version'] as String,
      buildNumber: json['build-number'] as String,
      packageName: json['package_name'] as String,
      comitId: json['comitid'] as String,
      branch: json['branch'] as String,
      time: json['time'] as String,
    );
  }

  factory VersionInfo.noInfos() {
    return const VersionInfo(
      appName: "[app_name]",
      version: "[version]",
      buildNumber: "[build-number]",
      packageName: "[package_name]",
      comitId: "[comitid]",
      branch: "[branch]",
      time: "[time]",
    );
  }
}
