class DetailOrder {
  String? amount;
  String? idDetailOrder;
  String? idOrder;
  String? idProduct;
  String? name;
  String? price;

  DetailOrder(
      {this.amount,
      this.idDetailOrder,
      this.idOrder,
      this.idProduct,
      this.name,
      this.price});

  DetailOrder.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    idDetailOrder = json['idDetailOrder'];
    idOrder = json['idOrder'];
    idProduct = json['idProduct'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['idDetailOrder'] = this.idDetailOrder;
    data['idOrder'] = this.idOrder;
    data['idProduct'] = this.idProduct;
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }
}