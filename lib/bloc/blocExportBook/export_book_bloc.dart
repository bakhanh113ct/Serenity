import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:serenity/model/export_product.dart';
import 'export_book_repository.dart';

part 'export_book_event.dart';
part 'export_book_state.dart';

class ExportBookBloc extends Bloc<ExportBookEvent, ExportBookState> {
  ExportBookBloc() : super(ExportBookInitial()) {
    on<GetAllExportBooks>((event, emit) async {
      emit(ExportBookLoading());
      try {
        List<ExportProduct> allExportBooks = await ExportBookRepository().get();
        emit(ExportBookLoaded(allExportBooks));
      } catch (e) {
        throw Exception(e.toString());
      }
    });

    on<GetExportBooksByFilter>(((event, emit) async {
      try {
        final text = event.textSearch.toLowerCase();
        List<ExportProduct> allReceiptDocuments =
            await ExportBookRepository().get();
        if (text.isEmpty) {
          allReceiptDocuments = await ExportBookRepository().get();
          emit(ExportBookLoaded(allReceiptDocuments));
          return;
        } else {
          allReceiptDocuments.retainWhere((data) {
            return (data.idExportProduct!.toLowerCase().contains(text) ||
                data.name!.toLowerCase().contains(text) ||
                data.idOrder!.toLowerCase().contains(text) ||
                data.amount!.toLowerCase().contains(text) ||
                data.historicalCost!.toLowerCase().contains(text) ||
                data.price!.toLowerCase().contains(text) ||
                data.content
                    .toString()
                    .toLowerCase()
                    .contains(text) ||
                DateFormat('dd-MM-yyyy hh:ss:mm aa')
                    .format(data.dateExport!.toDate())
                    .contains(text));
          });
          emit(ExportBookLoaded(allReceiptDocuments));
        }
      } catch (e) {
        throw Exception(e.toString());
      }
    }));
  }
  
}
