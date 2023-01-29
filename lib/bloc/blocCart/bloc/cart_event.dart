part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {
  const LoadCart();

  @override
  List<Object> get props => [];
}

class ChooseCategory extends CartEvent {
  const ChooseCategory(this.newCategory);
  final Category newCategory;
  @override
  List<Object> get props => [newCategory];
}

class SearchProduct extends CartEvent {
  const SearchProduct(this.query);
  final String query;
  @override
  List<Object> get props => [query];
}

class AddProductCart extends CartEvent {
  const AddProductCart(this.product);
  final Product product;
  @override
  List<Object> get props => [product];
}

class DecreaseProductCart extends CartEvent {
  const DecreaseProductCart(this.product);
  final Product product;
  @override
  List<Object> get props => [product];
}

class RemoveProductCart extends CartEvent {
  const RemoveProductCart(this.product);
  final Product product;
  @override
  List<Object> get props => [product];
}
