part of 'receipt_document_bloc.dart';

abstract class ReceiptDocumentEvent extends Equatable {
  const ReceiptDocumentEvent();

  @override
  List<Object> get props => [];
}

class AddReceiptDocument extends ReceiptDocumentEvent {
  final ReceiptDocument receiptDocument;
  const AddReceiptDocument({
    required this.receiptDocument,
  });

  @override
  List<Object> get props => [receiptDocument];
}

class UpdateReceiptDocument extends ReceiptDocumentEvent {
  final ReceiptDocument receiptDocument;
  const UpdateReceiptDocument({
    required this.receiptDocument,
  });

  @override
  List<Object> get props => [receiptDocument];
}

class DeleteReceiptDocument extends ReceiptDocumentEvent {
  final ReceiptDocument receiptDocument;
  const DeleteReceiptDocument({
    required this.receiptDocument,
  });

  @override
  List<Object> get props => [receiptDocument];
}

class GetAllReceiptDocuments extends ReceiptDocumentEvent {
  const GetAllReceiptDocuments();

  @override
  List<Object> get props => [];
}

class GetReceiptDocumentsByFilter extends ReceiptDocumentEvent {
  const GetReceiptDocumentsByFilter({required this.textSearch});
  final String textSearch;
  @override
  List<Object> get props => [textSearch];
}

