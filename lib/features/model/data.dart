class Data {
  int id;
  String title;
  String image;
  String link;
  String description;
  String category;
  String actor;
  String director;
  String manufacturer;
  String duration;
  String year;
  String createdAt;
  String updatedAt;
  int views;
  String type;

  Data(
      {this.id,
      this.title,
      this.image,
      this.link,
      this.description,
      this.category,
      this.actor,
      this.director,
      this.manufacturer,
      this.duration,
      this.year,
      this.createdAt,
      this.updatedAt,
      this.views,
      this.type});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        link: json["link"],
        description: json["description"],
        category: json["category"],
        actor: json["actor"],
        director: json["director"],
        manufacturer: json["manufacturer"],
        duration: json["duration"],
        year: json["year"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        views: json["views"],
        type: json["type"],
      );
}
