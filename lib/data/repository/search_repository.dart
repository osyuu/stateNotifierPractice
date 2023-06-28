
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier_practice/data/model/search_result.dart';

//* Repository
final searchRepositoryProvider = Provider<SearchRepository>(
        (_) => SearchRepository(0)
);

class SearchRepository {
  SearchRepository(int seed) : _random = Random(seed);

  final Random _random;

  Future<SearchResult> fetch(String keyword) async {
    await Future<void>.delayed(const Duration(milliseconds: 1000));

    if (_random.nextDouble() < 0.2) {
      debugPrint("throw exception");
      throw Exception("test");
    }
    final size = max(_random.nextInt(20) - 5, 0);
    debugPrint("fetch success size: $size");
    return SearchResult(
      keyword: keyword,
      list: List.generate(size, (index) => "Result '$keyword'($index)"),
    );
  }

}