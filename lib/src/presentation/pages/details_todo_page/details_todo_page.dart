import 'package:flutter/material.dart';

import 'local_widgets/todo_title.dart';
import 'local_widgets/custom_appbar.dart';
import 'local_widgets/date_text.dart';
import 'local_widgets/image_panel.dart';

class DetailsTodoPage extends StatelessWidget {
  const DetailsTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TodoTitle(),
                  Spacer(),
                  Checkbox(value: false, onChanged: null),
                ],
              ),
              SizedBox(height: 8),
              CreateAt(),
              UpdateAt(),
              Spacer(),
              ImagePanel(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
