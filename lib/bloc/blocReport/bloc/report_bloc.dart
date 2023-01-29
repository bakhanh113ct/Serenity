import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../repository/report_repository.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc() : super(ReportLoading()) {
    on<LoadReport>((event, emit) async{
      emit(ReportLoading());
      final dataColumn=await ReportRepository().dataColumnChart();
      final dataPie=await ReportRepository().dataPieChart();
      final orders=await ReportRepository().quantityOrderInMonth();
      final customers=await ReportRepository().quantityCustomerInMonth();
      final revenue=await ReportRepository().totalOrderInMonth();
      final profit=await ReportRepository().profitOrderInMonth();
      emit(ReportLoaded(dataColumn,dataPie,orders,customers,revenue,profit));
    });
  }
}
