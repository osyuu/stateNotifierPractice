
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier_practice/data/repository/search_repository.dart';

final searchUseCaseProvider = Provider(
      (ref) => SearchUseCase(ref.watch(searchRepositoryProvider)),
);

class SearchUseCase {
  SearchUseCase(this.repository);

  final SearchRepository repository;

  Future<List<String>> call(String keyword) async {
    final result = await repository.fetch(keyword);
    return result.list;
  }
}