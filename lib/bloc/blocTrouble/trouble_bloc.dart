import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:serenity/model/trouble.dart';

import 'trouble_repository.dart';

part 'trouble_event.dart';
part 'trouble_state.dart';

class TroubleBloc extends Bloc<TroubleEvent, TroubleState> {
  TroubleBloc() : super(TroubleInitial()) {
    on<GetData>(((event, emit) async {
      emit(TroubleLoading());
      await Future.delayed(const Duration(seconds: 1));
      try {
        final allTroubles = await TroubleRepository().get();
        emit(TroubleLoaded(allTroubles));
      } catch (e) {
        throw Exception(e.toString());
      }
    }));

    on<GetTroublesByFilter>(((event, emit) async {
      await Future.delayed(const Duration(seconds: 1));
      try {
        final text = event.textSearch;
        List<Trouble> allTroubles = await TroubleRepository().get();
        if (text.isEmpty || text == '') {
          allTroubles = await TroubleRepository().get();
        } else {
          allTroubles.retainWhere((data) {
            return (data.idTrouble!.contains(text) ||
                data.description!.contains(text) ||
                data.nameCustomer!.contains(text) ||
                data.idCustomer!.contains(text) ||
                data.dateCreated!.toString().contains(text) ||
                data.status!.contains(text));
          });
          emit(TroubleLoaded(allTroubles));
        }
      } catch (e) {
        throw Exception(e.toString());
      }
    }));

    on<AddTrouble>((event, emit) async {
      var trouble = event.trouble;
      await Future.delayed(const Duration(seconds: 1));
      try {
        await TroubleRepository().addTrouble(trouble);
        final allTroubles = await TroubleRepository().get();
        emit(TroubleLoaded(allTroubles));
      } catch (e) {
        throw Exception(e.toString());
      }
    });

    on<UpdateTrouble>((event, emit) async {
      var trouble = event.trouble;
      await Future.delayed(const Duration(seconds: 1));
      try {
        await TroubleRepository().updateTrouble(trouble);
        final allTroubles = await TroubleRepository().get();
        emit(TroubleLoaded(allTroubles));
      } catch (e) {
        throw Exception(e.toString());
      }
    });
  }
}
