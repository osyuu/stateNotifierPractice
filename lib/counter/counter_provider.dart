import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier_practice/counter/counter_state_notifier.dart';

//* Logic / StateNotifier
final counterProvider = NotifierProvider<CounterNotifier, int>(CounterNotifier.new);