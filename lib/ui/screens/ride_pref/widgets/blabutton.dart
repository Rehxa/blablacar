import 'package:blabla/ui/theme/theme.dart';
import 'package:flutter/material.dart';

enum ButtonType {
  primary(buttonColor: BlaColors.primary, labelColor: BlaColors.white),
  secondary(buttonColor: BlaColors.white, labelColor: BlaColors.primary);

  final Color buttonColor;
  final Color labelColor;

  const ButtonType({required this.buttonColor, required this.labelColor});
}

class BlaButton extends StatelessWidget {
  const BlaButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.buttonType,
    required this.iconData,
  });

  final VoidCallback onPressed;
  final String label;
  final IconData iconData;
  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      label: Text(label, style: TextStyle(color: buttonType.labelColor)),
      icon: Icon(iconData, color: buttonType.labelColor),
      style: OutlinedButton.styleFrom(
        backgroundColor: buttonType.buttonColor,
        side: BorderSide(color: BlaColors.backgroundAccent),
      ),
    );
  }
}
