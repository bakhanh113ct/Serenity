part of 'detail_order_bloc.dart';

abstract class DetailOrderEvent extends Equatable {
  const DetailOrderEvent();

  @override
  List<Object> get props => [];
}

class LoadDetailOrder extends DetailOrderEvent {
  const LoadDetailOrder(this.idOrder);
  final String idOrder;
  @override
  List<Object> get props => [idOrder];
}

class CancelDetailOrder extends DetailOrderEvent {
  const CancelDetailOrder();
  @override
  List<Object> get props => [];
}

class CompleteDetailOrder extends DetailOrderEvent {
  const CompleteDetailOrder();
  @override
  List<Object> get props => [];
}