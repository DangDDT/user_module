import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

class CircleAvatarWithErrorHandler extends StatefulWidget {
  const CircleAvatarWithErrorHandler({
    super.key,
    required this.avatarUrl,
    required this.fullName,
    this.radius = 12,
  }) : file = null;
  const CircleAvatarWithErrorHandler.file({
    super.key,
    required this.file,
    required this.fullName,
    this.radius = 12,
  }) : avatarUrl = null;

  final String? avatarUrl;
  final String? fullName;
  final double radius;
  final File? file;

  @override
  State<CircleAvatarWithErrorHandler> createState() =>
      _CircleAvatarWithErrorHandlerState();
}

class _CircleAvatarWithErrorHandlerState
    extends State<CircleAvatarWithErrorHandler> {
  bool isAvatarLoadError = false;

  @override
  Widget build(BuildContext context) {
    final imageProvider = widget.file != null
        ? BaseExtendedImageFile(file: widget.file!)
        : widget.avatarUrl != null
            ? BaseExtendedImageNetwork(imageUrl: widget.avatarUrl!)
            : null;
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.primary.withOpacity(.8);
    TextStyle? textStyle = kTheme.textTheme.bodyMedium?.copyWith(
      color: backgroundColor.textColor,
    );
    return CircleAvatar(
      radius: widget.radius,
      backgroundColor: backgroundColor,
      backgroundImage: imageProvider!.image,
      onBackgroundImageError: widget.avatarUrl != null
          ? (exception, stackTrace) {
              if (!isAvatarLoadError) {
                setState(() {
                  isAvatarLoadError = true;
                });
              }
            }
          : null,
      child: (widget.avatarUrl == null || isAvatarLoadError)
          ? Center(
              child: Text(
                widget.fullName!.initialWords.toUpperCase(),
                style: textStyle?.copyWith(
                  fontSize: widget.radius / 1.3,
                ),
              ),
            )
          : null,
    );
  }
}

class BaseExtendedImageNetwork extends ExtendedImage {
  BaseExtendedImageNetwork({
    super.key,
    required String imageUrl,
  }) : super.network(
          imageUrl,
          loadStateChanged: (state) {
            switch (state.extendedImageLoadState) {
              case LoadState.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case LoadState.completed:
                return null;
              case LoadState.failed:
                return const Center(
                  child: Icon(Icons.error),
                );
            }
          },
          cacheMaxAge: const Duration(minutes: 1),
          clearMemoryCacheWhenDispose: true,
          clearMemoryCacheIfFailed: true,
        );
}

class BaseExtendedImageFile extends ExtendedImage {
  BaseExtendedImageFile({
    super.key,
    required File file,
  }) : super.file(
          file,
          loadStateChanged: (state) {
            switch (state.extendedImageLoadState) {
              case LoadState.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case LoadState.completed:
                return null;
              case LoadState.failed:
                return const Center(
                  child: Icon(Icons.error),
                );
            }
          },
          fit: BoxFit.cover,
          clearMemoryCacheWhenDispose: true,
          clearMemoryCacheIfFailed: true,
        );
}
