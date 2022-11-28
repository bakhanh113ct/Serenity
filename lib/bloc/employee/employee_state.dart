part of 'employee_bloc.dart';

abstract class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object> get props => [];
}

class EmployeeLoading extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {
  final List<User> listEmployee;

  const EmployeeLoaded({required this.listEmployee});

  @override
  List<Object> get props => [listEmployee];
}

class EmployeeError extends EmployeeState {}
