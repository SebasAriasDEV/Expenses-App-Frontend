import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_budget_app/utils/colors.dart';

import '../../models/account_model.dart';
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

class NewCardPlaceholder extends StatelessWidget {
  const NewCardPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //color: Colors.red,
      width: 100,
      child: Center(
        child: Container(
          width: 80,
          height: 80,
          decoration:
              BoxDecoration(color: kSuccessColor, shape: BoxShape.circle),
          child: Center(
            child: IconButton(
              onPressed: () {},
              icon: FaIcon(
                FontAwesomeIcons.plus,
                color: kWhiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
