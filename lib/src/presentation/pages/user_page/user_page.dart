import 'dart:io';

import 'package:amuz_todo_list/src/presentation/riverpods/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
        child: Consumer(
          builder: (context, ref, child) {
            final UserState userState = ref.watch(userNotifierProvider);

            return Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (userState.imageUrl != null)
                  CircleAvatar(
                    radius: MediaQuery.sizeOf(context).width / 6,
                    backgroundImage: FileImage(File(userState.imageUrl!)),
                  )
                else
                  Icon(
                    Icons.account_circle,
                    size: MediaQuery.sizeOf(context).width / 3,
                  ),
                Text(
                  userState.userName ?? '이름 없음',
                  style: TextTheme.of(context).titleLarge,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
