import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:serenity/model/order.dart';
import 'package:serenity/repository/detail_order_repository.dart';

import '../../../model/detail_order.dart';

part 'detail_order_event.dart';
part 'detail_order_state.dart';

class DetailOrderBloc extends Bloc<DetailOrderEvent, DetailOrderState> {
  DetailOrderBloc() : super(DetailOrderInitial()) {
    on<LoadDetailOrder>((event, emit) async {
      emit(DetailOrderLoading());
      final List<DetailOrder> listDetailOrder=await DetailOrderRepository().getDetailOrder(event.idOrder);
      final MyOrder order=await DetailOrderRepository().getOrder(event.idOrder);     
      emit(DetailOrderLoaded(order, listDetailOrder));
    });
    on<CancelDetailOrder>((event, emit) async {
      final state=this.state as DetailOrderLoaded;
      await DetailOrderRepository().cancelDetailOrder(state.order!.idOrder!);
    });
  }
}
