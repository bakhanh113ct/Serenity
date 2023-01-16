// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'trouble_bloc.dart';

abstract class TroubleEvent extends Equatable {
  const TroubleEvent();

  @override
  List<Object> get props => [];
}

class AddTrouble extends TroubleEvent {
  final Trouble trouble;
  const AddTrouble({
    required this.trouble,
  });

  @override
  List<Object> get props => [trouble];
}

class UpdateTrouble extends TroubleEvent {
  final Trouble trouble;
  const UpdateTrouble({
    required this.trouble,
  });

  @override
  List<Object> get props => [trouble];
}

class DeleteTrouble extends TroubleEvent {
  final Trouble trouble;
  const DeleteTrouble({
    required this.trouble,
  });

  @override
  List<Object> get props => [trouble];
}

class GetTrouble extends TroubleEvent {
  const GetTrouble();
}

class GetTroublesByFilter extends TroubleEvent {
  const GetTroublesByFilter({required this.textSearch});
  final String textSearch;
  @override
  List<Object> get props => [textSearch];
}
