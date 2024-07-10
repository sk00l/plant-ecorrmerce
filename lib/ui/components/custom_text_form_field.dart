// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTextFormField extends StatefulWidget {
  final String? title;
  final String? helperText;
  final bool isSecure;
  final int maxLength;
  final String? hint;
  final TextInputType? inputType;
  final String? initValue;
  final Color? backColor;
  final Widget? suffix;
  final Widget? prefix;
  final TextEditingController? textEditingController;
  final String? Function(String? value)? validator;
  final Function(String)? onTextChanged;
  final Function(String)? onSaved;
  List<TextInputFormatter>? inputFormatters;

  static const int maxLENGTH = 500;
  CustomTextFormField({
    Key? key,
    this.title,
    this.helperText,
    this.isSecure = false,
    this.maxLength = maxLENGTH,
    this.hint,
    this.inputType,
    this.initValue = '',
    this.backColor,
    this.suffix,
    this.prefix,
    this.textEditingController,
    this.validator,
    this.onTextChanged,
    this.onSaved,
    this.inputFormatters,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _passwordVisibility;

  final FocusNode _focusNode = FocusNode();
  Color _borderColor = const Color.fromARGB(255, 23, 65, 42);
  Color redError = Colors.red;
  Color primary = const Color.fromARGB(255, 75, 142, 75);
  double _borderSize = 0.7;

  @override
  void initState() {
    super.initState();
    _passwordVisibility = !widget.isSecure;
    widget.textEditingController?.text = widget.initValue ?? "";

    _focusNode.addListener(() {
      setState(() {
        _borderSize = _focusNode.hasFocus ? 1.7 : 1.2;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 55,
          decoration: BoxDecoration(
            border: Border.all(color: _borderColor, width: _borderSize),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: TextFormField(
            
            focusNode: _focusNode,
            controller: widget.textEditingController,
            autocorrect: false,
            obscureText: !_passwordVisibility,
            keyboardType: widget.inputType,
            cursorColor: Colors.black,
            validator: (value) {
              String? f = widget.validator?.call(value);
              setState(() {
                _borderColor = f != null ? redError : primary;
              });
              return f;
            },
            style: const TextStyle(color: Color.fromARGB(255, 75, 142, 75)),
            maxLength: widget.maxLength,
            inputFormatters: widget.inputFormatters,
            maxLines: 1,
            onChanged: (text) {
              widget.onTextChanged?.call(text);
            },
            decoration: InputDecoration(
              counterText: "",
              hintStyle:
                  const TextStyle(color: Color.fromARGB(255, 75, 142, 75)),
              floatingLabelStyle: const TextStyle(
                  color: Color.fromARGB(255, 75, 142, 75),
                  fontWeight: FontWeight.w400),
              labelText: widget.title,
              labelStyle:
                  const TextStyle(color: Color.fromARGB(255, 75, 142, 75)),
              helperText: widget.helperText,
              suffixIcon: getSuffixIcon(),
              prefixIcon: widget.prefix,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }

  Widget? getSuffixIcon() {
    return widget.isSecure ? getPasswordSuffixIcon() : widget.suffix;
  }

  Widget? getPasswordSuffixIcon() {
    return IconButton(
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      padding: EdgeInsets.zero,
      icon: _passwordVisibility
          ? const FaIcon(FontAwesomeIcons.eye)
          : const FaIcon(FontAwesomeIcons.eyeSlash),
      color: Colors.black,
      onPressed: () {
        setState(() {
          _passwordVisibility = !_passwordVisibility;
        });
      },
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
