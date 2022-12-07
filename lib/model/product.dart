import 'package:equatable/equatable.dart';

class Product extends Equatable{
  String? amount;
  String? category;
  String? content;
  String? idProduct;
  String? image;
  String? name;
  String? price;
  String? historicalCost;

  Product(
      {this.amount,
      this.category,
      this.content,
      this.idProduct,
      this.image,
      this.name,
      this.price,
      this.historicalCost});

  Product.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    category = json['category'];
    content = json['content'];
    idProduct = json['idProduct'];
    image = json['image'];
    name = json['name'];
    price = json['price'];
    historicalCost = json['historicalCost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['category'] = this.category;
    data['content'] = this.content;
    data['idProduct'] = this.idProduct;
    data['image'] = this.image;
    data['name'] = this.name;
    data['price'] = this.price;
    data['historicalCost'] = this.historicalCost;
    return data;
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [name,price,idProduct];
}