part of 'import_book_bloc.dart';

abstract class ImportBookState extends Equatable {
  const ImportBookState();
  
  @override
  List<Object> get props => [];
}

class ImportBookInitial extends ImportBookState {}
class ImportBookLoading extends ImportBookState {}
class ImportBookLoaded extends ImportBookState {
  List<Product> myData;
  ImportBookLoaded(this.myData);
  @override
  List<Object> get props => [myData];
}
