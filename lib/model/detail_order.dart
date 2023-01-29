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
  DetailOrder copyWith({
    String? idDetailOrder,
    String? idOrder,
    String? idProduct,
    String? amount,
    String? name,
    String? price,
  }) {
    return DetailOrder(
      idDetailOrder: idDetailOrder ?? this.idDetailOrder,
      idOrder: idOrder ?? this.idOrder,
      idProduct: idProduct ?? this.idProduct,
      amount: amount ?? this.amount,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }
}