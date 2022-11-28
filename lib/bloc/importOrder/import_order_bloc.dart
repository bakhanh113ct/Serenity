import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:serenity/model/import_order.dart';

part 'import_order_event.dart';
part 'import_order_state.dart';

class ImportOrderBloc extends Bloc<ImportOrderEvent, ImportOrderState> {
  ImportOrderBloc() : super(ImportOrderLoading()) {
    on<ImportOrderEvent>((event, emit) async {
      List<ImportOrder> employees = [];
      CollectionReference importOrder =
          FirebaseFirestore.instance.collection('ImportOrder');
      await importOrder.get().then(
        (value) {
          value.docs.forEach((e) {
            employees.add(ImportOrder(
              nameA: e.get('nameA'),
              addressA: e.get('addressA'),
              phoneA: e.get('phoneA'),
              bankA: e.get('bankA'),
              atBankA: e.get('atBankA'),
              authorizedPersonA: e.get('authorizedPersonA'),
              positionA: e.get('positionA'),
              noAuthorizationA: e.get('noAuthorizationA'),
              dateAuthorizationA: e.get('dateAuthorizationA'),
              nameB: e.get('nameB'),
              addressB: e.get('addressB'),
              phoneB: e.get('phoneB'),
              bankB: e.get('bankB'),
              atBankB: e.get('atBankB'),
              authorizedPersonB: e.get('authorizedPersonB'),
              positionB: e.get('positionB'),
              noAuthorizationB: e.get('noAuthorizationB'),
              dateAuthorizationB: e.get('dateAuthorizationB'),
              pursuant: e.get('pursuant'),
              dateCreated: e.get('dateCreated'),
              atPlace: e.get('atPlace'),
              note: e.get('note'),
              totalPrice: e.get('totalPrice'),
              idImportOrder: e.get('idImportOrder'),
              status: e.get('status'),
              // listProduct: e.get('listProduct'),
            ));
          });
        },
      );

      emit(ImportOrderLoaded(listImportOrder: employees));
    });
  }
}
