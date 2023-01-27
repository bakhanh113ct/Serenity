import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:serenity/bloc/blocCustomer/customer_repository.dart';

import '../../model/customer.dart';
import '../../model/report_trouble.dart';
import 'report_trouble_repository.dart';

part 'report_trouble_event.dart';
part 'report_trouble_state.dart';

class ReportTroubleBloc extends Bloc<ReportTroubleEvent, ReportTroubleState> {
  ReportTroubleBloc() : super(ReportTroubleInitial()) {
    on<GetReportTrouble>((event, emit) async {
      emit(ReportTroubleLoading());
      try {
        final allReportTroubles = await ReportTroubleRepository().get();
        final allListCustomers  = await CustomerRepository().get();
        emit(ReportTroubleLoaded(allReportTroubles, allListCustomers));
      } catch (e) {
        throw Exception(e.toString());
      }
    });

    on<AddReportTrouble>((event, emit) async {
        var reportTrouble = event.reportTrouble;
        try {
          await ReportTroubleRepository().addReportTrouble(reportTrouble);
          final allReportTroubles = await ReportTroubleRepository().get();
          final allListCustomers = await CustomerRepository().get();
          emit(ReportTroubleLoaded(allReportTroubles, allListCustomers));
        } catch (e) {
          throw Exception(e.toString());
        }
    },);
     on<UpdateReportTrouble>(
      (event, emit) async {
        emit(ReportTroubleLoading());
        var reportTrouble = event.reportTrouble;
        try {
          await ReportTroubleRepository().updateReportTrouble(reportTrouble);
          final allReportTroubles = await ReportTroubleRepository().get();
          final allListCustomers = await CustomerRepository().get();
          emit(ReportTroubleLoaded(allReportTroubles, allListCustomers));
        } catch (e) {
          throw Exception(e.toString());
        }
      },
    );
    on<GetReportTroublesByFilter>(((event, emit) async {
      try {
        final text = event.textSearch.toLowerCase();
        List<ReportTrouble> allReportTroubles = await ReportTroubleRepository().get();
        if (text.isEmpty) {
          allReportTroubles = await ReportTroubleRepository().get();
          final allListCustomers = await CustomerRepository().get();
          emit(ReportTroubleLoaded(allReportTroubles, allListCustomers));
          return;
        } else {
          allReportTroubles.retainWhere((data) {
            return (data.idTrouble!.toLowerCase().contains(text) ||
                data.idCustomer!.toLowerCase().contains(text) ||
                data.idStaff!.toLowerCase().contains(text) ||
                data.idCustomer!.toLowerCase().contains(text) ||
                data.idTrouble!.toLowerCase().contains(text) ||
                data.totalMoney!.toLowerCase().contains(text) ||
                data.dateSolved!.toLowerCase().contains(text) ||
                DateFormat('dd-MM-yyyy hh:ss:mm aa').format(data.dateCreated!.toDate()).contains(text) ||
                data.status!.toLowerCase().contains(text));
          });
          final allListCustomers = await CustomerRepository().get();
          emit(ReportTroubleLoaded(allReportTroubles, allListCustomers));
        }
      } catch (e) {
        throw Exception(e.toString());
      }
    }));
  }
}

