part of 'import_book_bloc.dart';

abstract class ImportBookEvent extends Equatable {
  const ImportBookEvent();

  @override
  List<Object> get props => [];
}

class GetAllImportBooks extends ImportBookEvent {
  const GetAllImportBooks();

  @override
  List<Object> get props => [];
}

class GetImportBooksByFilter extends ImportBookEvent {
  const GetImportBooksByFilter({required this.textSearch});
  final String textSearch;
  @override
  List<Object> get props => [textSearch];
}
