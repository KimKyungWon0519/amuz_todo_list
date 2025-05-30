import 'package:flutter/material.dart';

import 'local_widgets/custom_appbar.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.account_circle,
              size: MediaQuery.sizeOf(context).width / 3,
            ),
            Text('이름', style: TextTheme.of(context).titleLarge),
          ],
        ),
      ),
    );
  }
}
