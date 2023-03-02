import 'package:flutter/material.dart';
import 'package:i_budget_app/models/account_model.dart';
import 'package:i_budget_app/utils/text_themes.dart';
import 'package:i_budget_app/utils/themes.dart';

import '../components/account_cards_list.dart';
import '../components/home_summary_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyAccounts = Account.dummyAccounts;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: CustomThemes.horizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppBar(
                title: const Text(
                  'Tus Finanzas',
                  style: headline1,
                ),
              ),
              const SizedBox(height: 20),
              ListAccountCards(dummyAccounts: dummyAccounts),
              const SizedBox(height: 20),
              const HomeSummaryCard(),
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.red,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
