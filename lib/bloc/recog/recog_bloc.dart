import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/recog.dart';
part 'recog_event.dart';
part 'recog_state.dart';

class RecogBloc extends Bloc<RecogEvent, RecogState> {
  RecogBloc() : super(RecogInitial([])) {
    on<RecogEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
