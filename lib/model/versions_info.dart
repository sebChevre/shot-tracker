class VersionInfo {
  final String app_name;
  final String version;
  final String build_number;
  final String package_name;
  final String time;
  final String comitid;
  final String branch;

  const VersionInfo(this.app_name, this.version, this.build_number,
      this.package_name, this.comitid, this.branch, this.time);

  factory VersionInfo.fromJson(Map<String, dynamic> json) {
    return VersionInfo(
      json['app_name'] as String,
      json['version'] as String,
      json['build-number'] as String,
      json['package_name'] as String,
      json['comitid'] as String,
      json['branch'] as String,
      json['time'] as String,
    );
  }
}
