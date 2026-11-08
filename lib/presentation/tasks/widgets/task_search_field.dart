import 'package:flutter/material.dart';

class TaskSearchField extends StatefulWidget {
  const TaskSearchField({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  State<TaskSearchField> createState() => _TaskSearchFieldState();
}

class _TaskSearchFieldState extends State<TaskSearchField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    widget.onChanged('');
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: _controller,
      builder: (context, value, _) => TextField(
        controller: _controller,
        onChanged: widget.onChanged,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Search tasks by title',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: value.text.isEmpty
              ? null
              : IconButton(
                  tooltip: 'Clear search',
                  icon: const Icon(Icons.close),
                  onPressed: _clear,
                ),
        ),
      ),
    );
  }
}
