import 'package:flutter/material.dart';

import 'local_widgets/image_preview.dart';
import 'local_widgets/tag_listview.dart';
import 'local_widgets/title_field.dart';
import 'local_widgets/add_image_buttons_row.dart';
import 'local_widgets/custom_appbar.dart';

class WriteTodoPage extends StatelessWidget {
  const WriteTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            TitleField(),
            Divider(),
            SizedBox(height: 50, child: TagListview()),
            Divider(),
            ImagePreview(),
            AddImageButtonsRow(),
          ],
        ),
      ),
    );
  }
}
