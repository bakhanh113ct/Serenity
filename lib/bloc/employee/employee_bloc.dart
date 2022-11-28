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

      employeeRepository
          .getEmployee()
          .listen((event) => add(UpdateListEmployee(listUser: event)));
    });

    on<AddEmployee>((event, emit) async {
      employeeRepository.addNewEmployee(event.user);
    });

    on<UpdateListEmployee>(
        (event, emit) => {emit(EmployeeLoaded(listEmployee: event.listUser))});
  }
}
