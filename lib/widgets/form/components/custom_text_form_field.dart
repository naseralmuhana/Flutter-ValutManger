import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_manager/widgets/clipBoard/clip_board.dart';

class CustomTextFormField extends StatefulWidget {
  final controller;
  final String label;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final List<String>? autofillHints;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final int? maxLines;
  final bool? obscureText;
  final bool? noSuffixIcon;

  CustomTextFormField({
    Key? key,
    this.controller,
    required this.label,
    this.validator,
    this.autofillHints,
    this.textInputType,
    this.maxLines,
    this.obscureText,
    this.onChanged,
    this.inputFormatters,
    this.focusNode,
    this.noSuffixIcon,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool? obscurePassword;

  @override
  void initState() {
    if (widget.obscureText == true) {
      obscurePassword = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      autofillHints: widget.autofillHints,
      keyboardType: widget.textInputType ?? TextInputType.text,
      obscureText: obscurePassword ?? false,
      maxLines: widget.maxLines ?? 1,
      onChanged: widget.onChanged,
      // style: TextStyle(fontFamily: 'Hahmlet'),
      // autofocus: true,
      focusNode: widget.focusNode,
      inputFormatters: widget.inputFormatters,
      validator: widget.validator ?? null,
      decoration: InputDecoration(
        labelText: widget.label,
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(),
        ),
        suffixIcon: widget.noSuffixIcon == true
            ? CustomClipBoard.buildControllerCopyClipboard(controller: widget.controller)
            : widget.maxLines == null
                ? buildRowClipboard(
                    controller: widget.controller,
                    obscureTextField: obscurePassword,
                  )
                : buildColumnClipboard(
                    controller: widget.controller,
                  ),
      ),
    );
  }

  Column buildColumnClipboard({controller}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomClipBoard.buildPasteClipboard(onPressedState: (val) {
          setState(() {
            controller.text += val;
          });
        }),
        CustomClipBoard.buildControllerCopyClipboard(controller: controller),
        CustomClipBoard.buildClearTextField(onPressed: () {
          setState(() {
            controller.clear();
          });
        }),
      ],
    );
  }

  Row buildRowClipboard({controller, obscureTextField}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        obscureTextField != null
            ? CustomClipBoard.buildPasswordVisibility(
                obscureText: obscurePassword,
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword!;
                  });
                },
              )
            : Container(),
        CustomClipBoard.buildPasteClipboard(onPressedState: (val) {
          setState(() {
            controller.text += val;
          });
        }),
        CustomClipBoard.buildControllerCopyClipboard(controller: controller),
        CustomClipBoard.buildClearTextField(onPressed: () {
          setState(() {
            controller.clear();
          });
        }),
      ],
    );
  }
}
