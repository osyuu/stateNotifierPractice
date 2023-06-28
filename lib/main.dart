import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier_practice/search/search_page.dart';

import 'counter/counter_page.dart';
import 'jokes/jokes_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: RiverpodSearchApp(),
    ),
  );
}

class RiverpodCounterApp extends StatelessWidget {
  const RiverpodCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RiverpodCounterApp Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CounterPage(),
    );
  }
}

class RiverpodJokesApp extends StatelessWidget {
  const RiverpodJokesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RiverpodJokesApp Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const JokesPage(),
    );
  }
}

class RiverpodSearchApp extends StatelessWidget {
  const RiverpodSearchApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RiverpodSearchApp Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SearchPage(),
    );
  }
}