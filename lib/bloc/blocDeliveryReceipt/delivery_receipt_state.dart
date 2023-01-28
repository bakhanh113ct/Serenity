part of 'delivery_receipt_bloc.dart';

abstract class DeliveryReceiptState extends Equatable {
  const DeliveryReceiptState();
  
  @override
  List<Object> get props => [];
}

class DeliveryReceiptInitial extends DeliveryReceiptState {}
class DeliveryReceiptLoading extends DeliveryReceiptState {}
class DeliveryReceiptLoaded extends DeliveryReceiptState {
  List<DeliveryReceipt> myData;
  DeliveryReceiptLoaded(this.myData);
  @override
  List<Object> get props => [myData];

}
