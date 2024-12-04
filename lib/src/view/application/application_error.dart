import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/extensions/extensions.dart';

class ApplicationError extends StatelessWidget {
  const ApplicationError({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Icon(
            CupertinoIcons.xmark_shield,
            size: 128,
            color: context.colorScheme.error,
          ),
        ),
      ),
    );
  }
}
