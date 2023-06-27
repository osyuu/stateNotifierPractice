

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'jokes_state_notifier.dart';

class JokesPage extends StatelessWidget {
  const JokesPage({super.key});

  ///JokesPage [routeName]
  static const routeName = 'JokesPage';

  ///Router for JokesPage
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const JokesPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riverpod Jokes'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _JokeConsumer(),
            const SizedBox(height: 50),
            _ButtonConsumer()
          ],
        ),
      ),
    );
  }

}

class _JokeConsumer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(jokesNotifierProvider);

    // return state.when(
    //   initial: () => const Text('Press the button to start'),
    //   loading: () => const Center(child: CircularProgressIndicator()),
    //   data: (joke) => Text('${joke.setup}\n${joke.delivery}'),
    //   error: (error) => const Text('Error Occured!'),
    // );

    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      data: (joke) => joke != null
          ? Text('${joke.setup}\n${joke.delivery}')
          : const Text('Press the button to start'),
      error: (_, __) => const Text('Error Occured!'),
    );
  }
}

class _ButtonConsumer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(jokesNotifierProvider);
    return ElevatedButton(
      onPressed: state.isLoading
          ? null
          : () {
        ref.read(jokesNotifierProvider.notifier).getJoke();
      },
      child: const Text('Press me to get a joke'),
    );
  }
}