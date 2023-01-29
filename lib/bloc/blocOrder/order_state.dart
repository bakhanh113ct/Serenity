part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();
  
  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  const OrderLoaded(this.listAllOrder, this.listCompletedOrder, this.listPendingOrder, this.listCancelledOrder);
  final List<MyOrder>? listAllOrder;
  final List<MyOrder>? listCompletedOrder;
  final List<MyOrder>? listPendingOrder;
  final List<MyOrder>? listCancelledOrder;
  @override
  List<Object> get props => [listAllOrder!,listCompletedOrder!,listPendingOrder!,listCancelledOrder!];
}