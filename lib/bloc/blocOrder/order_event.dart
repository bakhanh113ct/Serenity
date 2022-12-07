part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class LoadOrder extends OrderEvent {
  const LoadOrder();

  @override
  List<Object> get props => [];
}

class SearchAllOrder extends OrderEvent {
  const SearchAllOrder(this.query);
  final String query;
  @override
  List<Object> get props => [];
}