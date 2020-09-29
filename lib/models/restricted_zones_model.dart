class RestrictedZonesModel {
  int v;
  String id;
  List<List> coordinates;
  String name;
  String type;

  RestrictedZonesModel(
      {this.v, this.id, this.coordinates, this.name, this.type});

  factory RestrictedZonesModel.fromJson(Map<String, dynamic> json) {
    return RestrictedZonesModel(
      v: json['__v'],
      id: json['_id'],
      coordinates: json['coordinates'],
      name: json['name'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__v'] = this.v;
    data['_id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates;
    }
    return data;
  }
}
