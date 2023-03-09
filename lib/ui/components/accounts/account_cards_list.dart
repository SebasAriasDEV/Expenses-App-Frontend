import 'package:flutter/material.dart';
import 'package:i_budget_app/ui/components/accounts/add_account_button.dart';

import '../../../models/account_model.dart';
import 'account_card.dart';

class ListAccountCards extends StatelessWidget {
  const ListAccountCards({
    super.key,
    required this.accounts,
  });

  final List<Account> accounts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          if (index >= accounts.length) {
            return const NewCardPlaceholder();
          } else {
            return AccountCard(account: accounts[index]);
          }
        },
        separatorBuilder: (_, index) => const SizedBox(width: 20),
        itemCount: accounts.length + 1,
      ),
    );
  }
}
