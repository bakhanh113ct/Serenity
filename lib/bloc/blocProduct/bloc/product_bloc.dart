import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:serenity/repository/product_repository.dart';

import '../../../model/category.dart';
import '../../../model/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<LoadProduct>((event, emit) async {
      emit(ProductLoading());
      final List<Category> listCategory=await ProductRepository().getCategory();
      final List<Product> listProduct=await ProductRepository().getProduct(listCategory[0]);
      emit(ProductLoaded(listCategory, listProduct, listCategory[0]));
    });
    on<SearchProduct>((event, emit) async{
      final state=this.state as ProductLoaded;
      final List<Product> temp=await ProductRepository().getProduct(state.selectedCategory);
      final List<Product> listProduct=event.query!=""?temp.where((element) => element.name!.toLowerCase().contains(event.query.toLowerCase())).toList():temp;
      emit(ProductLoaded(state.listCategory,listProduct,state.selectedCategory,));
    });
    on<ChooseCategory>((event, emit) async{
      final state=this.state as ProductLoaded;
      final List<Product> listProduct=await ProductRepository().getProduct(event.newCategory);
      emit(ProductLoaded(state.listCategory,listProduct,event.newCategory));
    });
  }
}
