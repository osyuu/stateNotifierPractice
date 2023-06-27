
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier_practice/counter/counter_provider.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Counter'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _CountConsumer(),
            const SizedBox(height: 50),
            _ButtonConsumer()
          ],
        ),
      ),
    );
  }
}

class _CountConsumer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(counterProvider);
    return Center(
      child: Text(state.toString()),
    );
  }
}

class _ButtonConsumer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => ref.read(counterProvider.notifier).decrement(),
          icon: const Icon(Icons.exposure_minus_1),
        ),
        IconButton(
          onPressed: () => ref.read(counterProvider.notifier).increment(),
          icon: const Icon(Icons.plus_one),
        ),
      ],
    );
  }
}