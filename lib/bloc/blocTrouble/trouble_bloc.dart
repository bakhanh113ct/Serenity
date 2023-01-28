import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:serenity/model/trouble.dart';

import 'trouble_repository.dart';

part 'trouble_event.dart';
part 'trouble_state.dart';

class TroubleBloc extends Bloc<TroubleEvent, TroubleState> {
  TroubleBloc() : super(TroubleInitial()) {
    on<GetTrouble>(((event, emit) async {
      emit(TroubleLoading());
      try {
        final allTroubles = await TroubleRepository().get();
        emit(TroubleLoaded(allTroubles));
      } catch (e) {
        throw Exception(e.toString());
      }
    }));

    on<GetTroublesByFilter>(((event, emit) async {
      try {
        final text = event.textSearch.toLowerCase();
        List<Trouble> allTroubles = await TroubleRepository().get();
        if (text.isEmpty) {
          allTroubles = await TroubleRepository().get();
          emit(TroubleLoaded(allTroubles));
          return;
        } else {
          allTroubles.retainWhere((data) {
            return (data.idTrouble!.toLowerCase().contains(text) ||
                data.description!.toLowerCase().contains(text) ||
                data.nameCustomer!.toLowerCase().contains(text) ||
                data.idCustomer!.toLowerCase().contains(text) ||
                DateFormat('dd-MM-yyyy hh:ss:mm aa')
                    .format(data.dateCreated!.toDate())
                    .contains(text) ||
                data.status!.toLowerCase().contains(text));
          });
          emit(TroubleLoaded(allTroubles));
        }
      } catch (e) {
        throw Exception(e.toString());
      }
    }));

    on<AddTrouble>((event, emit) async {
      var trouble = event.trouble;
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
