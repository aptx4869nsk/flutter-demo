class UpgradeInfo {
  String? apkDownloadLink;
  String? iosDownloadLink;
  String? buildVersion;
  String? buildNumber;
  String? buildUpdateDescription;
  bool? forceUpdate;

  UpgradeInfo({
    this.apkDownloadLink,
    this.iosDownloadLink,
    this.buildVersion,
    this.buildNumber,
    this.buildUpdateDescription,
    this.forceUpdate,
  });

  UpgradeInfo.fromJson(Map<String, dynamic> json) {
    apkDownloadLink = json['apk_download_link'];
    iosDownloadLink = json['ios_download_link'];
    buildVersion = json['version'];
    buildNumber = json['build_number'];
    buildUpdateDescription = json['update_description'];
    forceUpdate = json['force_update'];
  }
}
