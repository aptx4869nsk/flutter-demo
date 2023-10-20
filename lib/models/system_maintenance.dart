class SystemMaintenance {
  int? status;
  String? description;

  SystemMaintenance({
    this.status,
    this.description,
  });

  SystemMaintenance.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    description = json['description'];
  }
}
