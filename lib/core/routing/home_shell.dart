import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task_manager/core/di/injection.dart';
import 'package:smart_task_manager/domain/entities/task_query.dart';
import 'package:smart_task_manager/presentation/dashboard/dashboard_page.dart';
import 'package:smart_task_manager/presentation/settings/settings_page.dart';
import 'package:smart_task_manager/presentation/tasks/cubit/tasks_cubit.dart';
import 'package:smart_task_manager/presentation/tasks/tasks_page.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> with RestorationMixin {
  static const _tasksTabIndex = 1;

  final _selectedIndex = RestorableInt(0);

  @override
  String get restorationId => 'home_shell';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedIndex, 'selected_index');
  }

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }

  void _selectTab(int index) => setState(() => _selectedIndex.value = index);

  void _showTasks(BuildContext context, TaskStatusFilter status) {
    context.read<TasksCubit>().statusChanged(status);
    _selectTab(_tasksTabIndex);
  }

  @override
  Widget build(BuildContext context) {
    // Provided here, above the tabs, so the dashboard can open the Tasks tab
    // with a status filter already applied.
    return BlocProvider(
      create: (_) => getIt<TasksCubit>()..load(),
      child: Builder(
        builder: (context) => Scaffold(
          // IndexedStack keeps each tab's state (search, filters, scroll position).
          body: IndexedStack(
            index: _selectedIndex.value,
            children: [
              DashboardPage(
                onShowTasks: (status) => _showTasks(context, status),
              ),
              const TasksPage(),
              const SettingsPage(),
            ],
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _selectedIndex.value,
            onDestinationSelected: _selectTab,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              NavigationDestination(
                icon: Icon(Icons.checklist_outlined),
                selectedIcon: Icon(Icons.checklist),
                label: 'Tasks',
              ),
              NavigationDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
