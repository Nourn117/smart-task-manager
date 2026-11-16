import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_task_manager/presentation/settings/cubit/theme_cubit.dart';

import '../../../helpers/cubit_helpers.dart';

void main() {
  late ThemeCubit cubit;

  setUp(() => cubit = ThemeCubit());

  tearDown(() => cubit.close());

  test('follows the system theme by default', () {
    expect(cubit.state, ThemeMode.system);
  });

  test('switches to the selected theme', () async {
    expect(
      await collectStates(cubit, () => cubit.changeThemeMode(ThemeMode.dark)),
      [ThemeMode.dark],
    );
  });
}
