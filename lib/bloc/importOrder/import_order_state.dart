part of 'import_order_bloc.dart';

abstract class ImportOrderState extends Equatable {
  const ImportOrderState();

  @override
  List<Object> get props => [];
}

class ImportOrderLoading extends ImportOrderState {}

class ImportOrderLoaded extends ImportOrderState {
  final List<ImportOrder> listImportOrder;

  ImportOrderLoaded({required this.listImportOrder});

  @override
  List<Object> get props => [listImportOrder];
}

class ImportOrderError extends ImportOrderState {}
