part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();
  
  @override
  List<Object> get props => [];
}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {
  const CheckoutLoaded(this.listCustomer, this.selectedCustomer, this.listVoucher, this.selectedVoucher, this.totalItem, this.discount, this.total);
  final List<Customer> listCustomer;
  final Customer? selectedCustomer;
  final List<Voucher> listVoucher;
  final Voucher? selectedVoucher;
  final double totalItem;
  final double discount;
  final double total;
  @override
  List<Object> get props => [discount,selectedCustomer!,selectedVoucher!];
}