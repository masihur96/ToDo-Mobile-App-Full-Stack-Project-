
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TODOTextFormField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final String? initalValue;
  final Function()? onTap;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final String? labelText;
  final String? helperText;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final IconData? iconData;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
  final Function()? suffixOnTap;
  final String? Function(String?)? validator;
  final Color? suffixIconColor;
  final TextInputType? keyboardType;
  final bool number;
  final bool isObscure;
  final bool isEnable;
  final int maxLines;

  const TODOTextFormField({
    Key? key,
    this.textEditingController,
    this.focusNode,
    this.initalValue,
    this.onChanged,
    this.onSaved,
    this.labelText,
    this.helperText,
    this.iconData,
    this.prefixIconData,
    this.suffixIconData,
    this.suffixOnTap,
    this.hintText,
    this.hintTextStyle,
    this.validator,
    this.suffixIconColor,
    this.keyboardType,
    this.isObscure = false,
    this.number = false,
    this.isEnable=true,
    this.onTap,
    this.onFieldSubmitted,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnable,
      maxLines: maxLines,
      initialValue: initalValue,
      controller: textEditingController,
      focusNode: focusNode,
      obscureText: isObscure,
      onChanged: onChanged,
      onSaved: onSaved,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: keyboardType,
      inputFormatters: number
          ? [
        FilteringTextInputFormatter.digitsOnly,
      ]
          : null,
      // style: AVLTextStyle.testFormLettering,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
        filled: true,
        fillColor: Color(0xFFE5E5E5),
        icon: iconData != null ? Icon(iconData) : null,
        labelText: labelText,
        // labelStyle: AVLTextStyle.levelFormLettering,
        isDense: true,
        helperText: helperText,
        hintText: hintText,
        // hintStyle: AVLTextStyle.levelFormLettering,
        prefixIcon: prefixIconData != null
            ? Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 10.0),
          child: Icon(
            prefixIconData,
            // color: AVLColors.primaryColor,
            size: 25,
          ),
        )
            : null,
        suffixIcon: suffixIconData != null
            ? GestureDetector(
          onTap: suffixOnTap,
          child: Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Icon(
              suffixIconData,
              color: suffixIconColor,
              size: 25,
            ),
          ),
        )
            : null,
      ),
      validator: validator,
    );
  }
}