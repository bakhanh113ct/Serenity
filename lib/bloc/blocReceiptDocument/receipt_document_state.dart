part of 'receipt_document_bloc.dart';

abstract class ReceiptDocumentState extends Equatable {
  const ReceiptDocumentState();
  
  @override
  List<Object> get props => [];
}

class ReceiptDocumentInitial extends ReceiptDocumentState {}
class ReceiptDocumentLoading extends ReceiptDocumentState {}
class ReceiptDocumentLoaded extends ReceiptDocumentState {
  List<ReceiptDocument> myReceiptDocument;
  ReceiptDocumentLoaded(this.myReceiptDocument);
  @override
  List<Object> get props => [myReceiptDocument];
}
