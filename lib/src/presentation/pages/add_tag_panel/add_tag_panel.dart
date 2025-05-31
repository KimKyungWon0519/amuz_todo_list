import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import 'local_widgets/all_tags.dart';
import 'local_widgets/selected_tags.dart';

class AddTodoPanel extends HookWidget {
  const AddTodoPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<List<bool>> isOpenState = useState([false, false]);

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: ExpansionPanelList(
            children: [
              _customExpansionPanel(
                '추가된 태그',
                SelectTag(),
                isOpenState.value[0],
              ),
              _customExpansionPanel('모든 태그', AllTag(), isOpenState.value[1]),
            ],
            expansionCallback:
                (panelIndex, isExpanded) =>
                    _updateExpandedState(panelIndex, isExpanded, isOpenState),
          ),
        ),
      ),
    );
  }

  ExpansionPanel _customExpansionPanel(
    String title,
    Widget body,
    bool isExpanded,
  ) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) => ListTile(title: Text(title)),
      body: Padding(padding: const EdgeInsets.all(16.0), child: body),
      isExpanded: isExpanded,
    );
  }

  void _updateExpandedState(
    int panelIndex,
    bool isExpanded,
    ValueNotifier<List<bool>> state,
  ) {
    List<bool> updateState = state.value.toList();

    updateState[panelIndex] = isExpanded;

    state.value = updateState;
  }
}
