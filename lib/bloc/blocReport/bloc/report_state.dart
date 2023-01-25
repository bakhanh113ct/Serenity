part of 'report_bloc.dart';

abstract class ReportState extends Equatable {
  const ReportState();
  
  @override
  List<Object> get props => [];
}

class ReportInitial extends ReportState {}
class ReportLoading extends ReportState {}
class ReportLoaded extends ReportState {
  const ReportLoaded(this.dataColumn,this.dataPie, this.orders, this.customer, this.revenue, this.profit);
  final List<ChartSampleData> dataColumn;
  final List<ChartSampleData1> dataPie;
  final String orders;
  final String customer;
  final String revenue;
  final String profit;
  @override
  List<Object> get props => [dataColumn,dataPie,orders,customer,revenue,profit];
}
