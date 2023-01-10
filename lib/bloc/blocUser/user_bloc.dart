import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:serenity/bloc/blocUser/user_repository.dart';
import 'package:serenity/bloc/blocUser/user_state.dart';

import '../../model/User.dart';

part 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoadUser>((event, emit) async {
      emit(UserLoading());
      User user = await UserRepository().getUser();
      emit(UserLoaded(user));
    });

    on<UpdateUser>((event, emit) async {
      // emit(UserLoading());
      await UserRepository().updateUser(event.user);

      emit(UserLoaded(event.user));
    });

    on<UpdateAvatarUser>((event, emit) async {
      if (state is UserLoaded) {
        User newUser = event.user;
        newUser.image = await UserRepository().updateAvatar(event.file);
        await UserRepository().updateUser(newUser);
        emit(UserLoaded(newUser));
      }
    });

    on<ChangePasswordUser>((event, emit) async {
      // emit(UserLoading());
      await UserRepository().changePasswordUser(event.password, event.context);
      // emit(UserLoaded(user));
    });
  }
}
