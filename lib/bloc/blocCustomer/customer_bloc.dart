import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:serenity/bloc/blocCustomer/customer_repository.dart';

import '../../../model/Customer.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerBloc() : super(const CustomerState()) {
    on<AddCustomer>(_onAddCustomer);
    on<UpdateCustomer>(_onUpdateCustomer);
    on<DeleteCustomer>(_onDeleteCustomer);
    on<GetAllCustomers>(_onGetAllCustomers);
    on<GetCustomersByFilter>(_onGetCustomersByFilter);
  }

  void _onAddCustomer(AddCustomer event, Emitter<CustomerState> emit) async {
    final state = this.state;
    final customer = event.customer;

    // add customer to firestore
    final ref = await FirebaseFirestore.instance.collection('Customers').add({
      'name': customer.name,
      'address': customer.address,
      'purchased': customer.purchased,
      'phone': customer.phone,
      'email': customer.email,
      'imageUrl': customer.imageUrl,
      'dateOfBirth': customer.dateOfBirth,
    });
    List<Customer> allCustomers = List.from(state.allCustomers)
      ..add(customer.copyWith(id: ref.id));
    allCustomers.sort((a, b) => a.id.compareTo(b.id));
    emit(CustomerState(allCustomers: allCustomers));
  }

  void _onUpdateCustomer(
      UpdateCustomer event, Emitter<CustomerState> emit) async {
    final state = this.state;
    final customer = event.customer;
    await FirebaseFirestore.instance
        .collection('Customers')
        .doc(customer.id)
        .update({
      'name': customer.name,
      'address': customer.address,
      'purchased': customer.purchased,
      'phone': customer.phone,
      'email': customer.email,
      'imageUrl': customer.imageUrl,
      'dateOfBirth': customer.dateOfBirth,
    });
    final int index =
        state.allCustomers.indexWhere((element) => element.id == customer.id);
    List<Customer> allCustomers = List.from(state.allCustomers)
      ..remove(state.allCustomers[index]);
    allCustomers.insert(index, customer);
    emit(CustomerState(allCustomers: allCustomers));
  }

  void _onDeleteCustomer(DeleteCustomer event, Emitter<CustomerState> emit) {}

  void _onGetAllCustomers(
      GetAllCustomers event, Emitter<CustomerState> emit) async {
    List<Customer> allCustomers = await CustomerRepository().getListCustomers();
    emit(CustomerState(allCustomers: allCustomers));
  }

  void _onGetCustomersByFilter(
      GetCustomersByFilter event, Emitter<CustomerState> emit) async {
    final text = event.textSearch;
    List<Customer> allCustomers = await CustomerRepository().getListCustomers();
    if (text.isEmpty || text == '') {
      allCustomers = await CustomerRepository().getListCustomers();
    } else {
       allCustomers.retainWhere((cus) {
          return (cus.id.contains(text) ||
              cus.name.contains(text) ||
              cus.address.contains(text) ||
              cus.phone.contains(text) ||
              cus.dateOfBirth.contains(text) ||
              cus.email.contains(text));
        });
    }
    print(allCustomers.length);
    emit(CustomerState(allCustomers: allCustomers));
  }
}
