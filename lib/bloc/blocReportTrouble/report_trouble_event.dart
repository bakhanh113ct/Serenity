part of 'report_trouble_bloc.dart';

abstract class ReportTroubleEvent extends Equatable {
  const ReportTroubleEvent();

  @override
  List<Object> get props => [];
}
class AddReportTrouble extends ReportTroubleEvent {
  final ReportTrouble reportTrouble;
  const AddReportTrouble({
    required this.reportTrouble,
  });

  @override
  List<Object> get props => [reportTrouble];
}

class UpdateReportTrouble extends ReportTroubleEvent {
  final ReportTrouble reportTrouble;
  const UpdateReportTrouble({
    required this.reportTrouble,
  });

  @override
  List<Object> get props => [reportTrouble];
}

class DeleteReportTrouble extends ReportTroubleEvent {
  final ReportTrouble reportTrouble;
  const DeleteReportTrouble({
    required this.reportTrouble,
  });

  @override
  List<Object> get props => [reportTrouble];
}

class GetReportTrouble extends ReportTroubleEvent {
  const GetReportTrouble();
}

class GetReportTroublesByFilter extends ReportTroubleEvent {
  const GetReportTroublesByFilter({required this.textSearch});
  final String textSearch;
  @override
  List<Object> get props => [textSearch];
}
