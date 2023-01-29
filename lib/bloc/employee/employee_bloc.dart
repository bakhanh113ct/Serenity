import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:serenity/repository/employee_repository.dart';

import '../../model/User.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeRepository employeeRepository = EmployeeRepository();
  EmployeeBloc() : super(EmployeeLoading()) {
    on<LoadEmployee>((event, emit) async {
      emit(EmployeeLoading());

      // final listEmployee = await employeeRepository.getEmployee();

      // emit(EmployeeLoaded(listEmployee: listEmployee));

      employeeRepository.getEmployee().listen(
          (event) => add(UpdateListEmployee(searchText: '', listUser: event)));
    });

    on<UpdateListEmployee>((event, emit) {
      final employees = event.listUser
          .where(
            (e) => e.fullName!.contains(event.searchText),
          )
          .toList();
      emit(EmployeeLoaded(listEmployee: employees));
    });

    on<AddEmployee>((event, emit) async {
      employeeRepository.addNewEmployee(event.user, event.password);
    });

    on<UpdateEmployee>(
        (event, emit) => employeeRepository.updateEmployee(event.user));

    on<ResetPassword>(
        (event, emit) => employeeRepository.resetPassword(event.email));
  }
}
