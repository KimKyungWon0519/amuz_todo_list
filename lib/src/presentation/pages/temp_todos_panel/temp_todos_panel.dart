import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TempTodosPanel extends StatelessWidget {
  const TempTodosPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => context.pop(),
          ),
        ],
      ),
      body: SafeArea(child: Placeholder()),
    );
  }
}

Future<void> showTempTodosPanel(BuildContext context) async {
  showModalBottomSheet(
    constraints: BoxConstraints(
      maxHeight: MediaQuery.sizeOf(context).height * 0.9,
    ),
    context: context,
    builder: (context) => TempTodosPanel(),
    showDragHandle: true,
    isScrollControlled: true,
  );
}
