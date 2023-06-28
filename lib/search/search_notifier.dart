
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:state_notifier_practice/search/search_usecase.dart';

//* Logic / StateNotifier
final searchNotifierProvider = AsyncNotifierProvider.autoDispose<SearchNotifier, List<String>>(
      () => SearchNotifier(),
);

class SearchNotifier extends AutoDisposeAsyncNotifier<List<String>> {
  SearchUseCase get searchWord => ref.read(searchUseCaseProvider);

  @override
  FutureOr<List<String>> build() async {
    return await searchWord("keyword");
  }

  Future<void> search(String keyword) async {
    final current = state;

    // 検索中はスキップ
    if (state.isLoading) return;
    // 検索中の状態
    // 直前の状態に表示できるデータがあれば表示し続ける
    state = const AsyncLoading<List<String>>().copyWithPrevious(current);

    // 検索実行
    final result = await AsyncValue.guard(() => searchWord(keyword));
    // Error発生の直前に表示できるデータがあれば表示し続ける
    state = result.copyWithPrevious(current);
  }
}