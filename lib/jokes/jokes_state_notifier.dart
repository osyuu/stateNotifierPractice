
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:state_notifier_practice/data/repository/jokes_repository.dart';
import 'package:state_notifier_practice/data/model/joke_model.dart';

//* Logic / StateNotifier
final jokesNotifierProvider = AsyncNotifierProvider.autoDispose<JokesNotifier, JokeModel?>(
      () => JokesNotifier(),
);

class JokesNotifier extends AutoDisposeAsyncNotifier<JokeModel?> {
  JokesNotifier()
      : super();

  @override
  FutureOr<JokeModel?> build() async {
    return null;
  }

  Future<void> getJoke() async {
    final jokesRepository = ref.read(jokesRepositoryProvider);
    state = const AsyncLoading();

    state = await AsyncValue.guard(jokesRepository.getJoke);
  }
}