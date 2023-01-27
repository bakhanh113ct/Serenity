part of 'delivery_receipt_bloc.dart';

abstract class DeliveryReceiptEvent extends Equatable {
  const DeliveryReceiptEvent();

  @override
  List<Object> get props => [];
}

class AddDeliveryReceipt extends DeliveryReceiptEvent {
  final DeliveryReceipt deliveryReceipt;
  const AddDeliveryReceipt({
    required this.deliveryReceipt,
  });

  @override
  List<Object> get props => [deliveryReceipt];
}

class UpdateDeliveryReceipt extends DeliveryReceiptEvent {
  final DeliveryReceipt deliveryReceipt;
  const UpdateDeliveryReceipt({
    required this.deliveryReceipt,
  });

  @override
  List<Object> get props => [deliveryReceipt];
}

class DeleteDeliveryReceipt extends DeliveryReceiptEvent {
  final DeliveryReceipt deliveryReceipt;
  const DeleteDeliveryReceipt({
    required this.deliveryReceipt,
  });

  @override
  List<Object> get props => [deliveryReceipt];
}

class GetAllDeliveryReceipts extends DeliveryReceiptEvent {
  const GetAllDeliveryReceipts();

  @override
  List<Object> get props => [];
}

class GetDeliveryReceiptsByFilter extends DeliveryReceiptEvent {
  const GetDeliveryReceiptsByFilter({required this.textSearch});
  final String textSearch;
  @override
  List<Object> get props => [textSearch];
}
