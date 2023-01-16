import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:serenity/bloc/blocCustomer/customer_repository.dart';

import '../../model/Customer.dart';
import 'customer_event.dart';
import 'customer_state.dart';



class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerBloc() : super(CustomerInitial()) {
    on<AddCustomer>(_onAddCustomer);
    on<UpdateCustomer>(_onUpdateCustomer);
    on<DeleteCustomer>(_onDeleteCustomer);
    on<GetAllCustomers>(_onGetAllCustomers);
    on<GetCustomersByFilter>(_onGetCustomersByFilter);
  }

  void _onAddCustomer(AddCustomer event, Emitter<CustomerState> emit) async {
    var customer = event.customer;
    await Future.delayed(const Duration(seconds: 1));
    try {
      await CustomerRepository().addCustomer(customer);
      final allCustomers = await CustomerRepository().get();
      emit(CustomerLoaded(allCustomers));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void _onUpdateCustomer(
      UpdateCustomer event, Emitter<CustomerState> emit) async {
    final customer = event.customer;
   try {
      await CustomerRepository().updateCustomer(customer);
      final allCustomers = await CustomerRepository().get();
      emit(CustomerLoaded(allCustomers));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void _onDeleteCustomer(DeleteCustomer event, Emitter<CustomerState> emit) {}

  void _onGetAllCustomers(
      GetAllCustomers event, Emitter<CustomerState> emit) async {
    emit(CustomerLoading());
    await Future.delayed(const Duration(seconds: 1));
    try {
      List<Customer> allCustomers = await CustomerRepository().get();
      emit(CustomerLoaded(allCustomers));
    }
    catch (e) {
      throw Exception(e.toString());
    }
    
  }

  void _onGetCustomersByFilter(
      GetCustomersByFilter event, Emitter<CustomerState> emit) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      final text = event.textSearch;
      List<Customer> allCustomers = await CustomerRepository().get();
      if (text.isEmpty || text == '') {
        allCustomers = await CustomerRepository().get();
      } else {
        allCustomers.retainWhere((cus) {
          return (cus.idCustomer!.contains(text) ||
              cus.name!.contains(text) ||
              cus.address!.contains(text) ||
              cus.phone!.contains(text) ||
              cus.dateOfBirth!.toString().contains(text) ||
              cus.email!.contains(text));
        });
      }
      emit(CustomerLoaded(allCustomers));
    }
    catch (e) {
      throw Exception(e.toString());
    }
  }
}
