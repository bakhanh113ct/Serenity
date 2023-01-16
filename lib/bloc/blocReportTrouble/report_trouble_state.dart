// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'report_trouble_bloc.dart';

abstract class ReportTroubleState extends Equatable {
  const ReportTroubleState();

  @override
  List<Object> get props => [];
}

class ReportTroubleInitial extends ReportTroubleState {}

class ReportTroubleLoading extends ReportTroubleState {}

class ReportTroubleLoaded extends ReportTroubleState {
  List<ReportTrouble> myData;
  List<Customer> myCustomers;
  ReportTroubleLoaded(this.myData, this.myCustomers);
  @override
  List<Object> get props => [myData, myCustomers];
}
