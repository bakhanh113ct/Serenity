import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:serenity/bloc/blocOrder/order_repository.dart';

import '../../model/order.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    List<MyOrder> listAllOrder=[];
    List<MyOrder> listCompletedOrder=[];
    List<MyOrder> listPendingOrder=[];
    List<MyOrder> listCancelledOrder=[];
    on<LoadOrder>((event, emit) async{
      emit(OrderLoading());
      listAllOrder=await OrderRepository().getOrder();
      listCompletedOrder=listAllOrder.where((element) => element.status=="Completed").toList();
      listPendingOrder=listAllOrder.where((element) => element.status=="Pending").toList();
      listCancelledOrder=listAllOrder.where((element) => element.status=="Cancelled").toList();
      emit(OrderLoaded(listAllOrder,listCompletedOrder,listPendingOrder,listCancelledOrder));
    });
    on<SearchAllOrder>((event, emit){
      final state=this.state as OrderLoaded;
      emit(OrderLoading());
      List<MyOrder> tempSearch;
      if(event.query==""){
        tempSearch=listAllOrder;
      }
      else{
        tempSearch=state.listAllOrder!.where((element) => element.nameCustomer!.toLowerCase().contains(event.query)).toList();
      }   
      emit(OrderLoaded(tempSearch,state.listCompletedOrder,state.listPendingOrder,state.listCancelledOrder));
    });
  }
}
