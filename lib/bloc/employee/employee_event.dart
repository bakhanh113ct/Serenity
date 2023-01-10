// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final String searchText;
  final List<User> listUser;

  const UpdateListEmployee({
    required this.searchText,
    required this.listUser,
  });
  @override
  List<Object> get props => [listUser, searchText];
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
