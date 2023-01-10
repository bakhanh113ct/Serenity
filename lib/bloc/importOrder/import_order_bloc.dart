import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:serenity/model/import_order.dart';
import 'package:serenity/repository/import_order_repository.dart';

part 'import_order_event.dart';
part 'import_order_state.dart';

class ImportOrderBloc extends Bloc<ImportOrderEvent, ImportOrderState> {
  ImportOrderRepository importOrderRepository = ImportOrderRepository();
  ImportOrderBloc() : super(ImportOrderLoading()) {
    on<LoadImportOrder>((event, emit) async {
      List<ImportOrder> employees = [];
      // final importOrder =
      //     await FirebaseFirestore.instance.collection('ImportOrder');
      // await importOrder.get().then(
      //   (value) {
      //     value.docs.forEach((e) {
      //       employees.add(ImportOrder.fromJson(e.data()));
      //     });
      //   },
      // );

      importOrderRepository.getImportOrder().listen(
            (event) => add(UpdateListImportOrder(listImportOrder: event)),
          );
    });

    on<UpdateListImportOrder>((event, emit) =>
        emit(ImportOrderLoaded(listImportOrder: event.listImportOrder)));
  }
}