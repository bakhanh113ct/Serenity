part of 'export_book_bloc.dart';

abstract class ExportBookEvent extends Equatable {
  const ExportBookEvent();

  @override
  List<Object> get props => [];
}
class GetAllExportBooks extends ExportBookEvent {
  const GetAllExportBooks();

  @override
  List<Object> get props => [];
}

class GetExportBooksByFilter extends ExportBookEvent {
  const GetExportBooksByFilter({required this.textSearch});
  final String textSearch;
  @override
  List<Object> get props => [textSearch];
}
