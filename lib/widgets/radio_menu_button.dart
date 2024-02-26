import 'package:flutter/material.dart';

class RadioMenuButton extends StatelessWidget {
  final dynamic value;
  final dynamic groupValue;
  final void Function(dynamic)? onChanged;
  final Widget child;
  final ButtonStyle? style;

  const RadioMenuButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.child,
    this.onChanged,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Radio(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged == null ? null : (dynamic newValue) => onChanged!(newValue),
    );
  }
}
