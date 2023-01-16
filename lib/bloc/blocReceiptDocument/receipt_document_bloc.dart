import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:serenity/bloc/blocReceiptDocument/receipt_document_repository.dart';

import '../../model/receipt_document.dart';

part 'receipt_document_event.dart';
part 'receipt_document_state.dart';

class ReceiptDocumentBloc extends Bloc<ReceiptDocumentEvent, ReceiptDocumentState> {
  ReceiptDocumentBloc() : super(ReceiptDocumentInitial()) {
     on<GetAllReceiptDocuments>(((event, emit) async {
      emit(ReceiptDocumentLoading());
      await Future.delayed(const Duration(seconds: 1));
      try {
        final allRc = await ReceiptDocumentRepository().get();
        emit(ReceiptDocumentLoaded(allRc));
      } catch (e) {
        throw Exception(e.toString());
      }
    }));
    on<AddReceiptDocument>((event, emit) async {
      var rc = event.receiptDocument;
      await Future.delayed(const Duration(seconds: 1));
      try {
        await ReceiptDocumentRepository().addReceiptDocument(rc);
        final allRc = await ReceiptDocumentRepository().get();
        emit(ReceiptDocumentLoaded(allRc));
      } catch (e) {
        throw Exception(e.toString());
      }
    });
  }
}
