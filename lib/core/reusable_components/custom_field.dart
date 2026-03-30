import 'package:evently_c18/core/resources/AssetsManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomField extends StatefulWidget {
  String hint;
  String prefixPath;
  String? Function(String?) validation;
  bool isPassword;
  TextEditingController controller;
  bool isSearch;
  bool isEventAdd;
  int maxLines;
  CustomField({
    required this.controller,
    required this.hint,
    this.isSearch = false,
    this.isEventAdd = false,
    this.maxLines = 1,
    required this.prefixPath, required this.validation, this.isPassword = false});

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  late bool isVisible;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isVisible = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      controller:widget.controller,
      style: Theme
          .of(context)
          .textTheme
          .bodySmall,
      validator: widget.validation,
      obscureText: isVisible,
      decoration: InputDecoration(

          hintText: widget.hint,
          hintStyle: Theme
              .of(context)
              .textTheme
              .labelSmall,
          prefixIcon: widget.isSearch || widget.isEventAdd
              ?null
              :SvgPicture.asset(
            widget.prefixPath,
            height: 24,
            width: 24,
            colorFilter: ColorFilter.mode(Theme
                .of(context)
                .colorScheme
                .onSecondaryContainer, BlendMode.srcIn),
          ),
          prefixIconConstraints: BoxConstraints(
              maxWidth: 24,
              maxHeight: 24
          ),
          suffixIcon: widget.isEventAdd
              ?null
              :widget.isSearch
              ? IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {

            },
            icon: SvgPicture.asset(AssetsManager.search, height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(Theme
                    .of(context)
                    .colorScheme
                    .primary, BlendMode.srcIn)),
          )
              : widget.isPassword
              ? IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
            icon: SvgPicture.asset(isVisible
                ? AssetsManager.visibleOff
                : AssetsManager.visibleOn, height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(Theme
                    .of(context)
                    .colorScheme
                    .onSecondaryContainer, BlendMode.srcIn)),
          ) : null,
          suffixIconConstraints: BoxConstraints(
              maxWidth: 24,
              maxHeight: 24
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .outline,
                  width: 1
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .outline,
                  width: 1
              )
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                  color: Colors.red,
                  width: 1
              )
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                  color: Colors.red,
                  width: 1
              )
          ),
          fillColor: Theme
              .of(context)
              .colorScheme
              .onSecondary,
          filled: true
      ),
    );
  }
}
