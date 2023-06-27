import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_notifier_practice/models/joke_model.dart';

part 'jokes_state.freezed.dart';

extension JokesGetters on JokesState {
  bool get isLoading => this is _Loading;
}

@freezed
abstract class JokesState with _$JokesState {
  const factory JokesState.initial() = _Initial;
  const factory JokesState.loading() = _Loading;
  const factory JokesState.data({required JokeModel joke}) = _Data;
  const factory JokesState.error([String? error]) = _Error;
}