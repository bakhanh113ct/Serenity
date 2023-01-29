part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
  
  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  const CartLoaded(this.listCategory, this.listProduct, this.listProductCart, this.selectedCategory,);
  final List<Category> listCategory;
  final List<Product> listProduct;
  final List<ProductCart> listProductCart;
  final Category selectedCategory;
  @override
  List<Object> get props => [listCategory,selectedCategory,listProduct,listProductCart];
}
