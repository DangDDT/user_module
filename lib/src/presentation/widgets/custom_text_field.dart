// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/core.dart';
import '../shared/animated_size_wrapper.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final IconData? prefixIcon;
  final Function(String)? onChanged;
  final String? errorText;
  final int? maxLength;
  final TextInputType keyboardType;
  final int countLength;
  final FloatingLabelBehavior floatingLabelBehavior;
  final EdgeInsets? paddingIcon;
  final bool isDense;
  final String? currentValue;
  final bool isShowHintText;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final bool readOnly;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;

  const CustomTextField({
    Key? key,
    required this.labelText,
    this.prefixIcon,
    this.onChanged,
    this.errorText,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.countLength = 0,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.paddingIcon,
    this.isDense = false,
    this.currentValue,
    this.isShowHintText = false,
    this.inputFormatters,
    this.maxLines = 1,
    this.readOnly = false,
    this.suffixIcon,
    this.controller,
    this.textInputAction,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSizeWrapper(
      child: Column(
        children: [
          TextFormField(
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            onChanged: widget.onChanged,
            maxLength: widget.maxLength,
            maxLines: widget.maxLines,
            controller: widget.controller,
            initialValue:
                widget.controller == null ? widget.currentValue : null,
            style: kTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            inputFormatters: widget.inputFormatters,
            readOnly: widget.readOnly,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: kTheme.colorScheme.primary.withOpacity(0.05),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: kTheme.colorScheme.primary.withOpacity(0.05),
                ),
              ),
              hintText: widget.isShowHintText ? widget.labelText : null,
              hintStyle: kTheme.textTheme.titleMedium?.copyWith(
                color: kTheme.colorScheme.onBackground.withOpacity(0.5),
              ),
              labelStyle: kTheme.textTheme.titleMedium?.copyWith(
                color: kTheme.colorScheme.onBackground.withOpacity(0.5),
              ),
              // filled: maxLines > 1,
              // fillColor: kTheme.colorScheme.primary.withOpacity(0.05),
              isDense: widget.isDense,
              prefixIcon: widget.prefixIcon != null && widget.maxLines == 1
                  ? Padding(
                      padding:
                          widget.paddingIcon ?? const EdgeInsets.only(top: 16),
                      child: Icon(
                        widget.prefixIcon,
                      ),
                    )
                  : null,
              prefixIconConstraints: const BoxConstraints(minWidth: 36),
              suffixIcon: widget.suffixIcon != null && widget.maxLines == 1
                  ? Padding(
                      padding:
                          widget.paddingIcon ?? const EdgeInsets.only(top: 16),
                      child: widget.suffixIcon,
                    )
                  : null,
              suffixIconConstraints: const BoxConstraints(minWidth: 36),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
            ),
          ),
          if (widget.errorText != null)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  widget.errorText!,
                  style: kTheme.textTheme.bodyMedium?.copyWith(
                    color: kTheme.colorScheme.error,
                  ),
                ),
              ),
            ),
          if (widget.maxLength != null) ...[
            kGapH8,
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "${widget.countLength}/${widget.maxLength} ký tự",
                style: kTheme.textTheme.bodyMedium?.copyWith(
                  color: kTheme.colorScheme.onBackground.withOpacity(0.5),
                ),
              ),
            )
          ]
        ],
      ),
    );
  }
}
