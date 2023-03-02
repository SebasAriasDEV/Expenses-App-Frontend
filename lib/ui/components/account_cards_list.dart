import 'package:flutter/material.dart';

import '../../models/account_model.dart';
import 'account_card.dart';

class ListAccountCards extends StatelessWidget {
  const ListAccountCards({
    super.key,
    required this.dummyAccounts,
  });

  final List<Account> dummyAccounts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => AccountCard(account: dummyAccounts[index]),
        separatorBuilder: (_, index) => const SizedBox(width: 20),
        itemCount: dummyAccounts.length,
      ),
    );
  }
}
