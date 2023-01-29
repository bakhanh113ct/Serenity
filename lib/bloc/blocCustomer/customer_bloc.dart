import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
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
      final text = event.textSearch.toLowerCase();
      List<Customer> allCustomers = await CustomerRepository().get();
      if (text.isEmpty || text == '') {
        allCustomers = await CustomerRepository().get();
      } else {
        allCustomers.retainWhere((cus) {
          return (cus.idCustomer!.toLowerCase().contains(text) ||
              cus.name!.toLowerCase().contains(text) ||
              cus.address!.toLowerCase().contains(text) ||
              cus.phone!.toLowerCase().contains(text) ||
              DateFormat('dd-MM-yyyy hh:ss:mm aa')
                  .format(cus.dateOfBirth!.toDate())
                  .contains(text) ||
              cus.email!.toLowerCase().contains(text));
        });
      }
      emit(CustomerLoaded(allCustomers));
    }
    catch (e) {
      throw Exception(e.toString());
    }
  }
}
