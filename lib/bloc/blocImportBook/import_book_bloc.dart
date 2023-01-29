import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:serenity/bloc/blocImportBook/import_book_repository.dart';
import 'package:serenity/model/product.dart';

part 'import_book_event.dart';
part 'import_book_state.dart';

class ImportBookBloc extends Bloc<ImportBookEvent, ImportBookState> {
  ImportBookBloc() : super(ImportBookInitial()) {
    on<GetAllImportBooks>((event, emit) async {
      emit(ImportBookLoading());
    try {
      List<Product> allImportBooks = await ImportBookRepository().get();
      emit(ImportBookLoaded(allImportBooks));
    }
    catch (e) {
      throw Exception(e.toString());
    }
    });

    on<GetImportBooksByFilter>(((event, emit) async {
      try {
        final text = event.textSearch.toLowerCase();
        List<Product> allReceiptDocuments =
            await ImportBookRepository().get();
        if (text.isEmpty) {
          allReceiptDocuments = await ImportBookRepository().get();
          emit(ImportBookLoaded(allReceiptDocuments));
          return;
        } else {
          allReceiptDocuments.retainWhere((data) {
            return (data.idProduct!.toLowerCase().contains(text) ||
                 data.name!.toLowerCase().contains(text) ||
                data.amount!.toLowerCase().contains(text) ||
                data.category!.toLowerCase().contains(text) ||
                data.content!.toLowerCase().contains(text) ||
                data.historicalCost!.toLowerCase().contains(text) ||
                data.price!.toString().toLowerCase().contains(text));
          });
          emit(ImportBookLoaded(allReceiptDocuments));
        }
      } catch (e) {
        throw Exception(e.toString());
      }
    }));
  }
  
}
