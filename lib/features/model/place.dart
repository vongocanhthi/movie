class Place {
  String description;
  String placeId;
  String reference;

  Place({this.description, this.placeId, this.reference});

  // Place.fromJson(Map<String, dynamic> json) {
  //   description = json['description'];
  //   placeId = json['place_id'];
  //   reference = json['reference'];
  // }

  factory Place.fromJson(Map<String, dynamic> json) => Place(
    description: json['description'],
    placeId: json['place_id'],
    reference: json['reference'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['place_id'] = this.placeId;
    data['reference'] = this.reference;
    return data;
  }
}
