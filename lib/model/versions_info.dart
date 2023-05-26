class VersionInfo {
  final String app_name;
  final String version;
  final String build_number;
  final String package_name;

  const VersionInfo(
      this.app_name, this.version, this.build_number, this.package_name);

  factory VersionInfo.fromJson(Map<String, dynamic> json) {
    return VersionInfo(
      json['app_name'] as String,
      json['version'] as String,
      json['build_number'] as String,
      json['package_name'] as String,
    );
  }
}
