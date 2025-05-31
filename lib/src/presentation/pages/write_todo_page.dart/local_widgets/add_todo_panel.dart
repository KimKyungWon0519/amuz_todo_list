import 'package:flutter/material.dart';

class AddTodoPanel extends StatelessWidget {
  const AddTodoPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          ExpansionPanelList(
            children: [
              ExpansionPanel(
                headerBuilder:
                    (context, isExpanded) => ListTile(title: Text('추가된 태그')),
                body: Wrap(),
              ),
            ],
          ),
          ExpansionPanelList(
            children: [
              ExpansionPanel(
                headerBuilder:
                    (context, isExpanded) => ListTile(title: Text('모든 태그')),
                body: Wrap(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
