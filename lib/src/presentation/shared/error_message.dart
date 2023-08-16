import 'package:flutter/material.dart';

import '../../../core/core.dart';

class ErrorMessage extends StatelessWidget {
  final String errorMessage;
  const ErrorMessage({required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        kGapH12,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.centerLeft,
          child: Text(
            errorMessage,
            style: theme.textTheme.bodyText2?.copyWith(color: theme.colorScheme.error),
          ),
        ),
        kGapH12
      ],
    );
  }
}
