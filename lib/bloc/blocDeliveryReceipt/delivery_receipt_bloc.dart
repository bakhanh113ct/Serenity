import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:serenity/model/delivery_receipt.dart';

import 'delivery_receipt_repository.dart';

part 'delivery_receipt_event.dart';
part 'delivery_receipt_state.dart';

class DeliveryReceiptBloc extends Bloc<DeliveryReceiptEvent, DeliveryReceiptState> {
  DeliveryReceiptBloc() : super(DeliveryReceiptInitial()) {

    on<GetAllDeliveryReceipts>((event, emit) async {
      emit(DeliveryReceiptLoading());
      try {
        List<DeliveryReceipt> allExportBooks = await DeliveryReceiptRepository().get();
        emit(DeliveryReceiptLoaded(allExportBooks));
      } catch (e) {
        throw Exception(e.toString());
      }
    });
    on<AddDeliveryReceipt>((event, emit) async {
      var rc = event.deliveryReceipt;
      try {
        await DeliveryReceiptRepository().addDeliveryReceipt(rc);
        final allDl = await DeliveryReceiptRepository().get();
        emit(DeliveryReceiptLoaded(allDl));
      } catch (e) {
        throw Exception(e.toString());
      }
    });
    on<GetDeliveryReceiptsByFilter>(((event, emit) async {
      try {
        final text = event.textSearch.toLowerCase();
        List<DeliveryReceipt> allReceiptDocuments =
            await DeliveryReceiptRepository().get();
        if (text.isEmpty) {
          allReceiptDocuments = await DeliveryReceiptRepository().get();
          emit(DeliveryReceiptLoaded(allReceiptDocuments));
          return;
        } else {
          allReceiptDocuments.retainWhere((data) {
            return (data.idDeliveryReceipt!.toLowerCase().contains(text) ||
                data.idOrder!.toLowerCase().contains(text) ||
                data.idStaff!.toLowerCase().contains(text) ||
                data.nameCustomer!.toLowerCase().contains(text) ||
                data.totalMoney!.toLowerCase().contains(text) ||
                data.listProducts!.length
                    .toString()
                    .toLowerCase()
                    .contains(text) ||
                DateFormat('dd-MM-yyyy hh:ss:mm aa')
                    .format(data.dateCreated!.toDate())
                    .contains(text));
          });
          emit(DeliveryReceiptLoaded(allReceiptDocuments));
        }
      } catch (e) {
        throw Exception(e.toString());
      }
    }));
  }
}
