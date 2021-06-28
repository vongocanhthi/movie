class Paging {
  int totalItem;
  int perPage;
  int currentPage;
  int totalPages;

  Paging({this.totalItem, this.perPage, this.currentPage, this.totalPages});

  factory Paging.fromJson(Map<String, dynamic> json) => Paging(
    totalItem: json["totalItem"],
    perPage: json["perPage"],
    currentPage: json["currentPage"],
    totalPages: json["totalPages"],
  );
}
