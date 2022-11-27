// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'customer_bloc.dart';

abstract class CustomerEvent extends Equatable {
  const CustomerEvent();

  @override
  List<Object> get props => [];
}

class AddCustomer extends CustomerEvent {
  final Customer customer;
  const AddCustomer({
    required this.customer,
  });

  @override
  List<Object> get props => [customer];
}

class UpdateCustomer extends CustomerEvent {
  final Customer customer;
  const UpdateCustomer({
    required this.customer,
  });

  @override
  List<Object> get props => [customer];
}

class DeleteCustomer extends CustomerEvent {
  final Customer customer;
  const DeleteCustomer({
    required this.customer,
  });

  @override
  List<Object> get props => [customer];
}

class GetAllCustomers extends CustomerEvent {
  const GetAllCustomers();

  @override
  List<Object> get props => [];
}

class GetCustomersByFilter extends CustomerEvent {
  const GetCustomersByFilter({required this.textSearch});
  final String textSearch;
  @override
  List<Object> get props => [textSearch];
}

