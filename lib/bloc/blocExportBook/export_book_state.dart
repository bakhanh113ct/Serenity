part of 'export_book_bloc.dart';

abstract class ExportBookState extends Equatable {
  const ExportBookState();
  
  @override
  List<Object> get props => [];
}

class ExportBookInitial extends ExportBookState {}
class ExportBookLoading extends ExportBookState {}

class ExportBookLoaded extends ExportBookState {
  List<ExportProduct> myData;
  ExportBookLoaded(this.myData);
  @override
  List<Object> get props => [myData];
}
