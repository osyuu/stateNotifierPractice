
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier_practice/search/search_notifier.dart';

class SearchTextField extends ConsumerWidget {
  const SearchTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController(text: "keyword");

    onSubmit() {
      final keyword = controller.value.text;
      final viewModel = ref.read(searchNotifierProvider.notifier);
      viewModel.search(keyword);
    }

    return IntrinsicHeight(
      // TextFieldとButtonの高さ揃える
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            // Buttonの横幅確保して残りの幅いっぱいまで広げる
            child: TextField(
              controller: controller,
              obscureText: false,
              maxLines: 1,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Put keyword",
              ),
              // キーボードのEnterでも検索できるようにする
              textInputAction: TextInputAction.go,
              onSubmitted: (_) => onSubmit(),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: onSubmit,
            child: const Text("Search"),
          ),
        ],
      ),
    );
  }
}