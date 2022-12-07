part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class LoadCheckout extends CheckoutEvent {
  const LoadCheckout(this.listProductCart);
  final List<ProductCart> listProductCart;
  @override
  List<Object> get props => [];
}

class ChooseCustomer extends CheckoutEvent {
  const ChooseCustomer(this.customer);
  final Customer customer;
  @override
  List<Object> get props => [];
}

class ChooseVoucher extends CheckoutEvent {
  const ChooseVoucher(this.voucher);
  final Voucher voucher;
  @override
  List<Object> get props => [];
}

class Payment extends CheckoutEvent {
  const Payment(this.listProductCart);
  final List<ProductCart> listProductCart;
  @override
  List<Object> get props => [];
}
