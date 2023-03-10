// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:i_budget_app/providers/accounts_providers.dart';
import 'package:i_budget_app/providers/categories_providers.dart';
import 'package:i_budget_app/providers/overall_provider.dart';
import 'package:i_budget_app/providers/transactions_provider.dart';
import 'package:i_budget_app/ui/components/custom_buttons.dart';
import 'package:i_budget_app/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../utils/text_themes.dart';

class ChangeCurrencyDialog extends StatefulWidget {
  const ChangeCurrencyDialog({
    super.key,
  });

  @override
  State<ChangeCurrencyDialog> createState() => _ChangeCurrencyDialogState();
}

class _ChangeCurrencyDialogState extends State<ChangeCurrencyDialog> {
  //** Providers */
  late final OverallProvider _overallProvider;

  //** Variables */
  late List<bool> _selection;
  bool _canSubmit = false;
  bool _isLoading = false;

  //** Init State */
  @override
  void initState() {
    super.initState();
    _overallProvider = Provider.of(context, listen: false);

    _selection = [
      _overallProvider.overallCurrency == 'COP',
      _overallProvider.overallCurrency == 'EUR'
    ];
  }

  @override
  Widget build(BuildContext context) {
    //** Build - Variables */
    final List<String> currencies = ['COP', 'EUR'];
    final List<String> subtitles = ['\$ - Peso Colombiano', '€ - Euro'];

    //** Build - Functions */
    Future<void> changeCurrency(String currency) async {
      //Start loading
      _isLoading = true;
      setState(() {});

      final AccountsProvider _accountsProvider =
          Provider.of<AccountsProvider>(context, listen: false);
      final TransactionsProvider _transactionsProvider =
          Provider.of<TransactionsProvider>(context, listen: false);
      final CategoriesProvider _categoriesProvider =
          Provider.of<CategoriesProvider>(context, listen: false);

      //Change currency
      _overallProvider.overallCurrency = currency;
      //Get account balances based on new currency
      await _accountsProvider.getAccounts(_overallProvider.overallCurrency);
      await _transactionsProvider.getTransactions(
        month: _overallProvider.currentMonth,
        year: _overallProvider.currentYear,
        displayCurrency: _overallProvider.overallCurrency,
      );
      _categoriesProvider
          .changeCategoriesDisplayCurrency(_overallProvider.overallCurrency);

      Navigator.pop(context);

      //Stops loading
      _isLoading = false;
      setState(() {});
    }

    //** Build - Widgets */
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      backgroundColor: kGreyColorShade4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Selecciona la moneda', style: headline4),
            Text(
              'Todo la información se convertirá a la moneda que selecciones.',
              style: paragraph5.copyWith(color: kGreyColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            CheckboxListTile(
              title: Text(currencies[0]),
              subtitle: Text(subtitles[0]),
              value: _selection[0],
              onChanged: (_) {
                _selection = [true, false];
                _canSubmit = true;
                setState(() {});
              },
            ),
            CheckboxListTile(
              title: Text(currencies[1]),
              subtitle: Text(subtitles[1]),
              value: _selection[1],
              onChanged: (_) {
                _selection = [false, true];
                _canSubmit = true;
                setState(() {});
              },
            ),
            const SizedBox(height: 10),
            Text(
              'Tasa de cambio COP/EUR: 5.050',
              style: paragraph3.copyWith(color: kGreyColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            PrimaryButton(
              onTap: () => changeCurrency(_selection[0] ? 'COP' : 'EUR'),
              text: 'Cambiar moneda',
              isActive: _canSubmit,
              isLoading: _isLoading,
            )
          ],
        ),
      ),
    );
  }
}
