part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProduct extends ProductEvent {
  const LoadProduct();

  @override
  List<Object> get props => [];
}

class SearchProduct extends ProductEvent {
  const SearchProduct(this.query);
  final String query;
  @override
  List<Object> get props => [query];
}

class ChooseCategory extends ProductEvent {
  const ChooseCategory(this.newCategory);
  final Category newCategory;
  @override
  List<Object> get props => [newCategory];
}