// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:i_budget_app/models/account_model.dart';
import 'package:i_budget_app/models/category_model.dart';
import 'package:i_budget_app/providers/accounts_providers.dart';
import 'package:i_budget_app/providers/categories_providers.dart';
import 'package:i_budget_app/ui/components/custom_buttons.dart';
import 'package:i_budget_app/utils/text_themes.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';

class ModalCreateMovement extends StatefulWidget {
  const ModalCreateMovement({
    super.key,
  });

  @override
  State<ModalCreateMovement> createState() => _ModalCreateMovementState();
}

class _ModalCreateMovementState extends State<ModalCreateMovement> {
  late final TCategory _selectedCategory;
  late final Account _selectedAccount;

  late final List<TCategory> _categories;
  late final List<Account> _accounts;

  @override
  void initState() {
    super.initState();

    _categories =
        Provider.of<CategoriesProvider>(context, listen: false).categories;
    _accounts = Provider.of<AccountsProvider>(context, listen: false).accounts;

    _selectedCategory = _categories[0];
    _selectedAccount = _accounts[0];
  }

  @override
  Widget build(BuildContext context) {
    // final List<TCategory> _categories =
    //     Provider.of<CategoriesProvider>(context).categories;

    return Container(
      // height: MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.all(25.0),
      decoration: BoxDecoration(
        color: kGreyColorShade4,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Nueva transacción', style: headline4),
            const SizedBox(height: 15),
            ToggleButtons(
              isSelected: const [true, false],
              color: kGreyColor,
              selectedColor: kWhiteColor,
              fillColor: kPrimaryColor,
              borderRadius: BorderRadius.circular(10.0),
              onPressed: (value) {
                print(value);
              },
              children: const [
                Text('Ingreso'),
                Text('Gasto'),
              ],
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField(
              value: _selectedAccount.uid,
              dropdownColor: kWhiteColor,
              items: [
                ..._accounts
                    .map((c) =>
                        DropdownMenuItem(value: c.uid, child: Text(c.name)))
                    .toList()
              ],
              onChanged: (uidSelected) {
                print(uidSelected);
              },
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField(
              value: _selectedCategory.uid,
              dropdownColor: kWhiteColor,
              items: [
                ..._categories
                    .map((c) =>
                        DropdownMenuItem(value: c.uid, child: Text(c.name)))
                    .toList()
              ],
              onChanged: (uidSelected) {
                print(uidSelected);
              },
            ),
            const SizedBox(height: 15),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration().copyWith(
                hintText: 'Monto',
                prefix: Text(
                  '${_selectedAccount.currency}:  ',
                  style: paragraph7,
                ),
              ),
            ),
            const SizedBox(height: 15),
            PrimaryButton(onTap: () {}, text: 'Agregar'),
          ],
        ),
      ),
    );
  }
}
