
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier_practice/search/search_notifier.dart';

class SearchResultList extends ConsumerWidget {
  const SearchResultList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchNotifierProvider);

    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      data: (result) => result.isEmpty
          ? const Center(child: Text("No Result"))
          : _ListBody(results: result, isLoading: state.isLoading),
      error: (_, __) => const Text('Error Occured!'),
    );
  }
}

class _ListBody extends StatelessWidget {
  const _ListBody({
    required this.results,
    required this.isLoading,
  });

  final List<String> results;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final result = results[index];
                  return Card(
                    child: ListTile(
                      title: Text(result),
                    ),
                  );
                },
                childCount: results.length,
              ),
            ),
          ],
        ),
        Visibility(
          visible: isLoading,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}