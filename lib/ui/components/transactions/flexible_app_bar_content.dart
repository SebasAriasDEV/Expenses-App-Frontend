import 'package:flutter/material.dart';

import '../../../helpers/custom_functions.dart';
import '../../../utils/colors.dart';
import '../../../utils/text_themes.dart';
import '../../../utils/themes.dart';

class FlexibleSpaceContent extends StatelessWidget {
  const FlexibleSpaceContent({
    super.key,
    required this.balance,
    required this.income,
    required this.outcome,
  });

  final double balance;
  final double income;
  final double outcome;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kPrimaryColor,
        gradient: LinearGradient(
          colors: [kPrimaryColorLight, kPrimaryColor, kPrimaryColorDark],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: CustomThemes.horizontalPadding,
            right: CustomThemes.horizontalPadding,
            bottom: 20,
            top: 60,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'COP',
                style: paragraph6.copyWith(color: kWhiteColor),
              ),
              Text(
                'A la fecha:',
                style: headline5.copyWith(color: kWhiteColor),
              ),
              Text(
                CustomFunctions.formatNumber(balance),
                style: headline2.copyWith(color: kWhiteColor),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '🟢 ${CustomFunctions.formatNumber(income)}',
                        style: headline4.copyWith(color: kWhiteColor),
                      ),
                      Text(
                        'Ingreso',
                        style: paragraph1.copyWith(color: kWhiteColor),
                      ),
                    ],
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: kWhiteColor,
                  ),
                  Column(
                    children: [
                      Text(
                        '🔴 ${CustomFunctions.formatNumber(outcome)}',
                        style: headline4.copyWith(color: kWhiteColor),
                      ),
                      Text(
                        'Egreso',
                        style: paragraph1.copyWith(color: kWhiteColor),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
