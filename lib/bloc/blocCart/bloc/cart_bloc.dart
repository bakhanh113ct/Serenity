import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:serenity/bloc/blocCart/bloc/cart_repository.dart';
import 'package:serenity/model/category.dart';
import 'package:serenity/model/product.dart';

import '../../../model/customer.dart';
import '../../../model/product_cart.dart';
import '../../../model/voucher.dart';
import '../../../repository/report_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<LoadCart>((event, emit) async{
      emit(CartLoading());
      final List<Category> listCategory=await CartRepository().getCategory();
      final List<Product> listProduct=await CartRepository().getProduct(listCategory[0]);
      final List<Voucher> listVoucher=await CartRepository().getVoucher();
      emit(CartLoaded(listCategory,listProduct,[],listCategory[0],));
    });
    on<ChooseCategory>((event, emit) async{
      final state=this.state as CartLoaded;
      final List<Product> listProduct=await CartRepository().getProduct(event.newCategory);
      emit(CartLoaded(state.listCategory,listProduct,state.listProductCart,event.newCategory));
    });
    on<SearchProduct>((event, emit) async{
      final state=this.state as CartLoaded;
      final List<Product> temp=await CartRepository().getProduct(state.selectedCategory);
      final List<Product> listProduct=event.query!=""?temp.where((element) => element.name!.toLowerCase().contains(event.query.toLowerCase())).toList():temp;
      emit(CartLoaded(state.listCategory,listProduct,state.listProductCart,state.selectedCategory,));
    });
    on<AddProductCart>((event, emit){
      final state=this.state as CartLoaded;
      emit(CartLoading());
      final ProductCart tempProductCart=ProductCart(product: event.product, amount: 1);
      if(state.listProductCart.contains(tempProductCart)){
        List<ProductCart> listProductCart=List.from(state.listProductCart);
        ProductCart temp=listProductCart.where((element) => element.product==event.product).first;
        // int indexTemp=listProductCart.indexOf(temp);
        // listProductCart.replaceRange(indexTemp, indexTemp+1, [ProductCart(product: event.product, amount: temp.amount!+1)]);
        if(temp.amount!+1<=int.parse(temp.product!.amount.toString())){
          listProductCart[state.listProductCart.indexWhere((element) => element.product==event.product)].amount=temp.amount!+1;
          emit(CartLoaded(state.listCategory,state.listProduct,listProductCart,state.selectedCategory));
        }
        else{
          emit(CartLoaded(state.listCategory,state.listProduct,state.listProductCart,state.selectedCategory));
        }    
      }
      else{
        List<ProductCart> listProductCart=state.listProductCart..add(ProductCart(product: event.product, amount: 1));
        emit(CartLoaded(state.listCategory,state.listProduct,listProductCart,state.selectedCategory));
      }  
    });
    on<DecreaseProductCart>((event, emit){
      final state=this.state as CartLoaded;
      emit(CartLoading());
      List<ProductCart> listProductCart=List.from(state.listProductCart);
        ProductCart temp=listProductCart.where((element) => element.product==event.product).first;
        // int indexTemp=listProductCart.indexOf(temp);
        // listProductCart.replaceRange(indexTemp, indexTemp+1, [ProductCart(product: event.product, amount: temp.amount!+1)]);
        if(temp.amount!-1>0){
          listProductCart[state.listProductCart.indexWhere((element) => element.product==event.product)].amount=temp.amount!-1;
          emit(CartLoaded(state.listCategory,state.listProduct,listProductCart,state.selectedCategory));
        }
        else{
          emit(CartLoaded(state.listCategory,state.listProduct,state.listProductCart,state.selectedCategory));
        } 
    });
    on<RemoveProductCart>((event, emit){
      final state=this.state as CartLoaded;
      emit(CartLoading());
      List<ProductCart> listProductCart=List.from(state.listProductCart);
        ProductCart temp=listProductCart.where((element) => element.product==event.product).first;
        // int indexTemp=listProductCart.indexOf(temp);
        // listProductCart.replaceRange(indexTemp, indexTemp+1, [ProductCart(product: event.product, amount: temp.amount!+1)]);
        listProductCart.remove(temp);
        emit(CartLoaded(state.listCategory,state.listProduct,listProductCart,state.selectedCategory));
        // if(temp.amount!-1>0){
        //   listProductCart[state.listProductCart.indexWhere((element) => element.product==event.product)].amount=temp.amount!-1;
        //   emit(CartLoaded(state.listCategory,state.listProduct,state.listCustomer,listProductCart,state.selectedCategory));
        // }
        // else{
        //   emit(CartLoaded(state.listCategory,state.listProduct,state.listCustomer,state.listProductCart,state.selectedCategory));
        // } 
    });
  }
  
}
