import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

/// Returns the states [cubit] emits while [act] runs.
Future<List<S>> collectStates<S>(
  BlocBase<S> cubit,
  FutureOr<void> Function() act, {
  Duration wait = Duration.zero,
}) async {
  final states = <S>[];
  final subscription = cubit.stream.listen(states.add);
  await act();
  await Future<void>.delayed(wait);
  await subscription.cancel();
  return states;
}
