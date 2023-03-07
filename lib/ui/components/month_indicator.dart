// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_budget_app/helpers/custom_functions.dart';
import 'package:i_budget_app/providers/overall_provider.dart';
import 'package:i_budget_app/utils/colors.dart';
import 'package:i_budget_app/utils/text_themes.dart';
import 'package:provider/provider.dart';

class MonthIndicator extends StatelessWidget {
  const MonthIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _overallProvider = Provider.of<OverallProvider>(context);
    final _month =
        CustomFunctions.formatMonthNameFromNum(_overallProvider.currentMonth);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => _overallProvider.currentMonth--,
          icon: const FaIcon(FontAwesomeIcons.chevronLeft,
              color: kGreyColorShade1),
        ),
        Text(_month, style: headline6.copyWith(color: kPrimaryColorDark)),
        IconButton(
          onPressed: () => _overallProvider.currentMonth++,
          icon: const FaIcon(FontAwesomeIcons.chevronRight,
              color: kGreyColorShade1),
        ),
      ],
    );
  }
}
