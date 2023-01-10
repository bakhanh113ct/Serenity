part of 'trouble_bloc.dart';

abstract class TroubleState extends Equatable {
  const TroubleState();
  @override
  List<Object> get props => [];
}
class TroubleInitial extends TroubleState {}
class TroubleLoading extends TroubleState{}

class TroubleLoaded extends TroubleState{
  List<Trouble> myData;
  TroubleLoaded(this.myData);
  @override
  List<Object> get props => [myData];
}


