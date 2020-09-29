class EntryExitPointModel {
  int v;
  String id;
  String entryPointLat;
  String entryPointLng;
  String entryPointName;
  String exitPointLat;
  String exitPointLng;
  String exitPointName;

  EntryExitPointModel(
      {this.v,
      this.id,
      this.entryPointLat,
      this.entryPointLng,
      this.entryPointName,
      this.exitPointLat,
      this.exitPointLng,
      this.exitPointName});

  factory EntryExitPointModel.fromJson(Map<String, dynamic> json) {
    return EntryExitPointModel(
      v: json['__v'],
      id: json['_id'],
      entryPointLat: json['entryPointLat'],
      entryPointLng: json['entryPointLng'],
      entryPointName: json['entryPointName'],
      exitPointLat: json['exitPointLat'],
      exitPointLng: json['exitPointLng'],
      exitPointName: json['exitPointName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__v'] = this.v;
    data['_id'] = this.id;
    data['entryPointLat'] = this.entryPointLat;
    data['entryPointLng'] = this.entryPointLng;
    data['entryPointName'] = this.entryPointName;
    data['exitPointLat'] = this.exitPointLat;
    data['exitPointLng'] = this.exitPointLng;
    data['exitPointName'] = this.exitPointName;
    return data;
  }
}
