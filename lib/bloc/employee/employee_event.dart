part of 'employee_bloc.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object> get props => [];
}

class LoadEmployee extends EmployeeEvent {
  @override
  List<Object> get props => [];
}

class AddEmployee extends EmployeeEvent {
  final User user;
  final String password;
  const AddEmployee({
    required this.user,
    required this.password,
  });
  @override
  List<Object> get props => [user];
}

class UpdateListEmployee extends EmployeeEvent {
  final List<User> listUser;

  const UpdateListEmployee({required this.listUser});
  @override
  List<Object> get props => [listUser];
}

class UpdateEmployee extends EmployeeEvent {
  final User user;

  const UpdateEmployee({required this.user});
  @override
  List<Object> get props => [user];
}

class ResetPassword extends EmployeeEvent {
  final String email;

  const ResetPassword({required this.email});

  @override
  List<Object> get props => [email];
}
