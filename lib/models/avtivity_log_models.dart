class ActivityLog {
  int id;
  String name;
  String region1;
  String region2;
  String vehicleNum;

  ActivityLog({this.id,this.name, this.region1, this.region2, this.vehicleNum});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'region1': region1,
      'region2': region2,
      'vehicleNum': vehicleNum,
    };
  }
}
