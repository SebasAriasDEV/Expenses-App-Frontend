import 'package:flutter/material.dart';
import 'package:i_budget_app/utils/colors.dart';

SnackBar customSnackBar({required String text, bool isError = false}) {
  return SnackBar(
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    behavior: SnackBarBehavior.floating,
    backgroundColor: isError ? kErrorColor : kSuccessColor,
    content: Text(text, selectionColor: kWhiteColor),
  );
}
