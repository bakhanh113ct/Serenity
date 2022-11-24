part of 'customer_bloc.dart';

class CustomerState extends Equatable {
  final List<Customer> allCustomers;
  const CustomerState({this.allCustomers = const <Customer>[]});

  @override
  List<Object> get props => [allCustomers];
}
