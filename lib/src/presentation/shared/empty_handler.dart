import 'package:flutter/material.dart';

class EmptyErrorHandler extends StatelessWidget {
  const EmptyErrorHandler({
    required this.title,
    this.banner,
    this.description,
    required this.reloadCallback,
  });

  final Widget? banner;
  final String title;
  final String? description;
  final VoidCallback? reloadCallback;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (banner != null)
          IconTheme(
            data: IconThemeData(
              color: theme.disabledColor,
              size: 60,
            ),
            child: banner!,
          ),
        const SizedBox(height: 12),
        Text(
          title,
          style: theme.textTheme.subtitle2?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        if (description != null) const SizedBox(height: 8),
        if (description != null)
          SizedBox(
            width: 250,
            child: Text(
              description!,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyText2,
            ),
          ),
        if (reloadCallback != null) const SizedBox(height: 28),
      ],
    );
  }
}
