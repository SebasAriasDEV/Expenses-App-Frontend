import 'package:flutter/material.dart';
import 'package:i_budget_app/providers/accounts_providers.dart';
import 'package:i_budget_app/ui/components/custom_buttons.dart';
import 'package:i_budget_app/utils/colors.dart';
import 'package:i_budget_app/utils/text_themes.dart';
import 'package:provider/provider.dart';

class DialogCreateAccount extends StatefulWidget {
  const DialogCreateAccount({
    super.key,
  });

  @override
  State<DialogCreateAccount> createState() => _DialogCreateAccountState();
}

class _DialogCreateAccountState extends State<DialogCreateAccount> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerType = TextEditingController();
  final TextEditingController _controllerCurrency = TextEditingController();
  final TextEditingController _controllerBalance = TextEditingController();

  late final AccountsProvider _accountsProvider;

  bool _canSubmit = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _accountsProvider = Provider.of<AccountsProvider>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    _controllerName.dispose();
    _controllerType.dispose();
    _controllerCurrency.dispose();
    _controllerBalance.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //** Functions */
    // Checks if every field is filled so it can create the transaction
    void checkCompleteness() {
      if (_controllerName.text != '' &&
          _controllerType.text != '' &&
          _controllerCurrency.text != '' &&
          _controllerBalance.text != '') {
        _canSubmit = true;
      } else {
        _canSubmit = false;
      }
      setState(() {});
    }

    //Post new transaction
    Future<void> createAccount() async {
      //Set loading in button
      _isLoading = true;
      setState(() {});

      final String response = await _accountsProvider.createAccount(
        _controllerName.text,
        _controllerType.text,
        _controllerCurrency.text,
        double.parse(_controllerBalance.text),
      );

      if (response == 'OK') {
        await _accountsProvider.getAccounts();
        Navigator.pop(context);
      } else {
        print('Algo salio mal!!!');
      }

      //Stop loading in button
      _isLoading = false;
      setState(() {});
    }

    //** Build Widgets */
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      backgroundColor: kGreyColorShade4,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Nueva cuenta', style: headline4),
              const SizedBox(height: 15),
              TextField(
                controller: _controllerName,
                decoration: const InputDecoration().copyWith(
                  hintText: 'Nombre de la cuenta',
                ),
                onChanged: (_) => checkCompleteness(),
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                dropdownColor: kWhiteColor,
                decoration: const InputDecoration().copyWith(
                  hintText: 'Tipo de cuenta',
                ),
                items: ['Debito', 'Credito']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (accountType) {
                  if (accountType != null) {
                    _controllerType.text = accountType;
                  }
                  checkCompleteness();
                },
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                dropdownColor: kWhiteColor,
                decoration: const InputDecoration().copyWith(
                  hintText: 'Moneda de la cuenta',
                ),
                items: ['COP', 'EUR']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (selectedCurrency) {
                  if (selectedCurrency != null) {
                    _controllerCurrency.text = selectedCurrency;
                  }
                  checkCompleteness();
                },
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _controllerBalance,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration().copyWith(
                  hintText: 'Balance inicial',
                ),
                onChanged: (_) => checkCompleteness(),
              ),
              const SizedBox(height: 15),
              PrimaryButton(
                onTap: () => createAccount(),
                text: 'Agregar cuenta',
                isActive: _canSubmit,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
