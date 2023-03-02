import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:i_budget_app/models/account_model.dart';
import 'package:i_budget_app/models/category_model.dart';
import 'package:i_budget_app/ui/components/category_card.dart';
import 'package:i_budget_app/utils/text_themes.dart';
import 'package:i_budget_app/utils/themes.dart';

import '../components/account_cards_list.dart';
import '../components/home_summary_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyAccounts = Account.dummyAccounts;
    final dummyCategories = TCategory.dummyCategories;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tus Finanzas',
          style: headline2,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: CustomThemes.horizontalPadding),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                ListAccountCards(dummyAccounts: dummyAccounts),
                const SizedBox(height: 20),
                const HomeSummaryCard(),
                const SizedBox(height: 20),
                ...dummyCategories
                    .map((c) => CategoryCard(category: c))
                    .toList(),

                // Expanded(
                //   flex: 3,
                //   child: ListView.separated(
                //     itemBuilder: (_, index) =>
                //         CategoryCard(category: dummyCategories[index]),
                //     separatorBuilder: (_, index) => const SizedBox(height: 10),
                //     itemCount: dummyCategories.length,
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
