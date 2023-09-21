part of 'recog_bloc.dart';

sealed class RecogState extends Equatable {
  RecogState(this.allRecogs);

  List<Recog> allRecogs;

  @override
  List<Object> get props => [allRecogs];
}

class RecogInitial extends RecogState {
  RecogInitial(super.allRecogs);
}

class RecogLoading extends RecogState {
  RecogLoading(super.allRecogs);
}

class RecogFinish extends RecogState {
  RecogFinish(super.allRecogs);
}

class RecogError extends RecogState {
  RecogError(super.allRecogs);
}
