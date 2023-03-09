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

class ModalCreateTransaction extends StatefulWidget {
  const ModalCreateTransaction({
    super.key,
  });

  @override
  State<ModalCreateTransaction> createState() => _ModalCreateTransactionState();
}

class _ModalCreateTransactionState extends State<ModalCreateTransaction> {
  late final TCategory _selectedCategory;
  late final Account _selectedAccount;

  late final List<TCategory> _categories;
  late final List<Account> _accounts;

  final TextEditingController _controllerAccountUid = TextEditingController();
  final TextEditingController _controllerCategoryUid = TextEditingController();
  final TextEditingController _controllerAmountField = TextEditingController();

  List<bool> _toggleSelection = [false, false];
  bool _canSubmit = false;

  @override
  void initState() {
    super.initState();

    _categories =
        Provider.of<CategoriesProvider>(context, listen: false).categories;
    _accounts = Provider.of<AccountsProvider>(context, listen: false).accounts;

    _selectedCategory = _categories[0];
    _selectedAccount = _accounts[0];

    _controllerAccountUid.text = _selectedAccount.uid;
    _controllerCategoryUid.text = _selectedCategory.uid;
  }

  @override
  void dispose() {
    super.dispose();
    _controllerAccountUid.dispose();
    _controllerCategoryUid.dispose();
    _controllerAmountField.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void checkCompleteness() {
      if (_controllerAccountUid.text != '' &&
          _controllerCategoryUid.text != '' &&
          _controllerAmountField.text != '' &&
          (_toggleSelection[0] != false || _toggleSelection[1] != false)) {
        _canSubmit = true;
      } else {
        _canSubmit = false;
      }
      setState(() {});
    }

    void toggleSelected(int position) {
      _toggleSelection = [false, false];
      _toggleSelection[position] = true;
      checkCompleteness();
      setState(() {});
    }

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: kGreyColorShade4,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Nueva transacción', style: headline4),
              const SizedBox(height: 15),
              LayoutBuilder(builder: (context, constraints) {
                return ToggleButtons(
                  constraints: BoxConstraints.expand(
                      width: (constraints.maxWidth - 5) / 2),
                  isSelected: _toggleSelection,
                  color: kGreyColor,
                  selectedColor: kWhiteColor,
                  fillColor:
                      _toggleSelection[0] == true ? kSuccessColor : kErrorColor,
                  borderRadius: BorderRadius.circular(10.0),
                  onPressed: (value) => toggleSelected(value),
                  children: const [
                    Text('Ingreso'),
                    Text('Gasto'),
                  ],
                );
              }),
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
                  _controllerAccountUid.text = uidSelected ?? '';
                  checkCompleteness();
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
                  _controllerCategoryUid.text = uidSelected ?? '';
                  checkCompleteness();
                },
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _controllerAmountField,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration().copyWith(
                  hintText: 'Monto',
                  prefix: Text(
                    '${_selectedAccount.currency}:  ',
                    style: paragraph7,
                  ),
                ),
                onChanged: (_) => checkCompleteness(),
              ),
              const SizedBox(height: 15),
              PrimaryButton(
                onTap: () => {},
                text: 'Agregar',
                isActive: _canSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
