import 'package:flutter/material.dart';
import 'package:i_budget_app/utils/colors.dart';
import 'package:i_budget_app/utils/text_themes.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.text,
    this.isLoading = false,
    this.isActive = false,
  });

  final Function onTap;
  final String text;
  final bool isLoading;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        onPressed: isActive ? () => onTap() : null,
        color: kPrimaryColor,
        disabledColor: kGreyColor,
        height: 56,
        elevation: 0.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Text(text, style: headline6.copyWith(color: kWhiteColor)),
      ),
    );
  }
}
