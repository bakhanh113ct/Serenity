class Category {
  String? name;
  String? idCategory;

  Category({this.name, this.idCategory});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    idCategory = json['idCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['idCategory'] = this.idCategory;
    return data;
  }
}