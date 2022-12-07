import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:serenity/bloc/blocUser/user_repository.dart';
import 'package:serenity/bloc/blocUser/user_state.dart';

import '../../model/user.dart';

part 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoadUser>((event, emit) async {
      emit(UserLoading());
      User user=await UserRepository().getUser();
      emit(UserLoaded(user));
    });
  }
}
