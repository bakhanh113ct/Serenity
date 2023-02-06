import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:serenity/bloc/blocCart/bloc/cart_repository.dart';
import 'package:serenity/bloc/blocOrder/order_repository.dart';
import 'package:serenity/model/product_cart.dart';
import 'package:serenity/repository/payment.dart';

import '../../../model/Customer.dart';
import '../../../model/voucher.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutInitial()) {
    on<LoadCheckout>((event, emit)async {
      emit(CheckoutLoading());
      double totalItem=0;
      event.listProductCart.forEach((element) {
        totalItem+=double.parse(element.product!.price!)*element.amount!;
       });
       List<Customer> listCustomer=await CartRepository().getCustomer();
       List<Voucher> listVoucher=await CartRepository().getVoucher();
       emit(CheckoutLoaded(listCustomer,null,listVoucher,null,totalItem,0,totalItem));
    });
    on<ChooseCustomer>((event, emit){
       final state=this.state as CheckoutLoaded;
       emit(CheckoutLoading());
       emit(CheckoutLoaded(state.listCustomer,event.customer,state.listVoucher,state.selectedVoucher,state.totalItem,state.discount,state.totalItem));
    });
    on<ChooseVoucher>((event, emit){
       final state=this.state as CheckoutLoaded;
       emit(CheckoutLoading());
       double discount=state.totalItem*double.parse(event.voucher.percent!);
       if(discount>double.parse(event.voucher.max!)){
        discount=double.parse(event.voucher.max!);
       }
       double total=state.totalItem-discount;
       emit(CheckoutLoaded(state.listCustomer,state.selectedCustomer,state.listVoucher,event.voucher,state.totalItem,discount,total));
    });
    on<Payment>((event, emit)async{
       final state=this.state as CheckoutLoaded;
       await OrderRepository().createOrder(state.selectedCustomer!, state.selectedVoucher, event.listProductCart, state.total,state.discount,state.totalItem,event.methodpayment);
       emit(CheckoutLoaded(state.listCustomer,state.selectedCustomer,state.listVoucher,state.selectedVoucher,state.totalItem,state.discount,state.total));
    });
  }
}
