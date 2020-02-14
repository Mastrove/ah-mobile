import 'package:ah_mobile/models/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthFormInput extends StatefulWidget {
  final AuthFormField field;
  final String label;
  final void Function(String val) onSaved;
  final void Function(String val) onFieldSubmitted;
  final void Function(String val) onChanged;
  final void Function() onBlur;
  final EdgeInsetsGeometry padding;
  final bool obscureText;
  final FocusNode focusNode;
  final bool autofocus;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final bool multiline;
  final int maxLines;
  final int minLines;
  final Widget prefixIcon;
  final Widget suffixIcon;

  const AuthFormInput({
    Key key,
    @required this.field,
    @required this.label,
    this.onSaved,
    @required this.textInputAction,
    @required this.onChanged,
    this.onFieldSubmitted,
    this.padding = const EdgeInsets.fromLTRB(5, 10, 5, 10),
    this.obscureText = false,
    this.focusNode,
    this.autofocus = false,
    this.keyboardType = TextInputType.text,
    this.multiline = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.onBlur,
  }) : super(key: key);

  @override
  _AuthFormInputState createState() => _AuthFormInputState();
}

class _AuthFormInputState extends State<AuthFormInput> {
  bool _hasHadFocus = false;

  @override
  void dispose() {
    super.dispose();
    widget.focusNode.removeListener(blurHandler);
  }

  blurHandler () {
     if (widget.focusNode.hasFocus && !_hasHadFocus) {
        _hasHadFocus = true;
        return;
      } else if (!widget.focusNode.hasFocus && (widget.onBlur != null) && !widget.field.isTouched) {
        Future.delayed(Duration(milliseconds: 200), widget.onBlur);
      }
  }

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(blurHandler);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: TextFormField(
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLines,
        initialValue: widget.field.value,
        textInputAction: widget.textInputAction,
        autovalidate: widget.field.isTouched,
        focusNode: widget.focusNode,
        obscureText: widget.obscureText,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 15),
          alignLabelWithHint: true,
          labelText: widget.label,
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          errorStyle: TextStyle(color: Colors.red),
        ),
        validator: (val) => widget.field.validationError,
      ),
    );
  }
}

class FormInputIcon extends StatelessWidget {
  const FormInputIcon({
    Key key,
    @required this.field,
    @required this.icon,
    this.height,
  }) : super(key: key);

  final AuthFormField field;
  final IconData icon;
  final double height;

  @override
  Widget build(BuildContext context) {
    var color = IconTheme.of(context).color;
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color: field.isValid || !field.isTouched ? color : Colors.red,
            ),
          ),
        ),
        child: Icon(
          icon,
          color: field.isValid || !field.isTouched ? null : Colors.red,
        ),
      ),
    );
  }
}
