part of 'report_bloc.dart';

abstract class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object> get props => [];
}

class LoadReport extends ReportEvent {
  const LoadReport();

  @override
  List<Object> get props => [];
}

