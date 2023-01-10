part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUser extends UserEvent {}

class UpdateUser extends UserEvent {
  final User user;
  const UpdateUser(this.user);
  @override
  List<Object> get props => [user];
}

class UpdateAvatarUser extends UserEvent {
  final File file;
  final User user;
  const UpdateAvatarUser(this.file, this.user);
  @override
  List<Object> get props => [file, user];
}

class ChangePasswordUser extends UserEvent {
  final String password;
  final BuildContext context;

  const ChangePasswordUser({required this.context, required this.password});
  @override
  List<Object> get props => [password];
}
