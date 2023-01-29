import 'package:equatable/equatable.dart';
import 'package:serenity/model/product.dart';

class ProductCart extends Equatable{
  Product? product;
  int? amount;

  ProductCart({required Product product,required int amount}){
    this.product=product;
    this.amount=amount;
  }
        @override
        List<Object?> get props => [product];

  
}