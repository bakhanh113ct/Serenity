part of 'detail_order_bloc.dart';

abstract class DetailOrderState extends Equatable {
  const DetailOrderState();
  
  @override
  List<Object> get props => [];
}

class DetailOrderInitial extends DetailOrderState {}

class DetailOrderLoading extends DetailOrderState {}

class DetailOrderLoaded extends DetailOrderState {
   
  DetailOrderLoaded(this.order, this.listDetailOrder);
  MyOrder? order;
  final List<DetailOrder> listDetailOrder; 
  @override
  List<Object> get props => [listDetailOrder,order!];
}