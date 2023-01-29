import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:serenity/bloc/blocReceiptDocument/receipt_document_repository.dart';

import '../../model/receipt_document.dart';

part 'receipt_document_event.dart';
part 'receipt_document_state.dart';

class ReceiptDocumentBloc extends Bloc<ReceiptDocumentEvent, ReceiptDocumentState> {
  ReceiptDocumentBloc() : super(ReceiptDocumentInitial()) {
     on<GetAllReceiptDocuments>(((event, emit) async {
      emit(ReceiptDocumentLoading());
      try {
        final allRc = await ReceiptDocumentRepository().get();
        emit(ReceiptDocumentLoaded(allRc));
      } catch (e) {
        throw Exception(e.toString());
      }
    }));
    on<AddReceiptDocument>((event, emit) async {
      var rc = event.receiptDocument;
      try {
        await ReceiptDocumentRepository().addReceiptDocument(rc);
        final allRc = await ReceiptDocumentRepository().get();
        emit(ReceiptDocumentLoaded(allRc));
      } catch (e) {
        throw Exception(e.toString());
      }
    });

     on<GetReceiptDocumentsByFilter>(((event, emit) async {
      try {
        final text = event.textSearch.toLowerCase();
        List<ReceiptDocument> allReceiptDocuments =
            await ReceiptDocumentRepository().get();
        if (text.isEmpty) {
          allReceiptDocuments = await ReceiptDocumentRepository().get();
          emit(ReceiptDocumentLoaded(allReceiptDocuments));
          return;
        } else {
          allReceiptDocuments.retainWhere((data) {
            return (data.idImportOrder!.toLowerCase().contains(text) ||
                data.idReceiptDocument!.toLowerCase().contains(text) ||
                data.idStaff!.toLowerCase().contains(text) ||
                data.nameSupplier!.toLowerCase().contains(text) ||
                data.totalMoney!.toLowerCase().contains(text) ||
                data.listProducts!.length.toString().toLowerCase().contains(text) ||
                DateFormat('dd-MM-yyyy hh:ss:mm aa')
                    .format(data.dateCreated!.toDate())
                    .contains(text) );
          });
          emit(ReceiptDocumentLoaded(allReceiptDocuments));
        }
      } catch (e) {
        throw Exception(e.toString());
      }
    }));
  }
}
