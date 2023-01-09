part of 'customer_bloc.dart';

class CustomerState extends Equatable {
  const CustomerState();

  @override
  List<Object> get props => [];
}
class CustomerInitial extends CustomerState {}

class CustomerLoading extends CustomerState {}

class CustomerLoaded extends CustomerState {
  List<Customer> myData;
  CustomerLoaded(this.myData);
  @override
  List<Object> get props => [myData];
}
