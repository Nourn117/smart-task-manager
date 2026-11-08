import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task_manager/core/di/injection.dart';
import 'package:smart_task_manager/core/routing/app_router.dart';
import 'package:smart_task_manager/core/theme/app_theme.dart';
import 'package:smart_task_manager/presentation/settings/cubit/theme_cubit.dart';

class SmartTaskManagerApp extends StatelessWidget {
  const SmartTaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) => MaterialApp(
          title: 'Smart Task Manager',
          debugShowCheckedModeBanner: false,
          restorationScopeId: 'app',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeMode,
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
