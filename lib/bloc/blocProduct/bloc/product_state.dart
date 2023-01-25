part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  const ProductLoaded(this.listCategory, this.listProduct, this.selectedCategory);
  final List<Category> listCategory;
  final List<Product> listProduct;
  final Category selectedCategory;
  @override
  List<Object> get props => [listCategory,listProduct,selectedCategory];
}
