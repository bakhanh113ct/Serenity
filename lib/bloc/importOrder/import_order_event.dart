part of 'import_order_bloc.dart';

abstract class ImportOrderEvent extends Equatable {
  const ImportOrderEvent();

  @override
  List<Object> get props => [];
}

class LoadImportOrder extends ImportOrderEvent {
  @override
  List<Object> get props => [];
}

class UpdateListImportOrder extends ImportOrderEvent {
  final List<ImportOrder> listImportOrder;

  const UpdateListImportOrder({required this.listImportOrder});
  @override
  List<Object> get props => [listImportOrder];
}

class UpdateStateImportOrder extends ImportOrderEvent {
  final String idImportOrder;
  final String state;
  final List<bool> listCheck;

  const UpdateStateImportOrder({
    required this.idImportOrder,
    required this.state,
    required this.listCheck,
  });
  @override
  List<Object> get props => [idImportOrder, state];
}
