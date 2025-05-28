import 'package:amuz_todo_list/src/presentation/pages/details_todo_page/local_widgets/date_text.dart';
import 'package:flutter/material.dart';

import 'local_widgets/todo_title.dart';

class DetailsTodoPage extends StatelessWidget {
  const DetailsTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TodoTitle(),
              SizedBox(height: 8),
              CreateAt(),
              UpdateAt(),
            ],
          ),
        ),
      ),
    );
  }
}
