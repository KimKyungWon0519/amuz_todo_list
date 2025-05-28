import 'package:flutter/material.dart';

import 'local_widgets/custom_appbar.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppbar());
  }
}
