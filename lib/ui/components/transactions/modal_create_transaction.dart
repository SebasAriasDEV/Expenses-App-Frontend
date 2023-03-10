// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:i_budget_app/models/account_model.dart';
import 'package:i_budget_app/models/category_model.dart';
import 'package:i_budget_app/providers/accounts_providers.dart';
import 'package:i_budget_app/providers/categories_providers.dart';
import 'package:i_budget_app/providers/overall_provider.dart';
import 'package:i_budget_app/providers/transactions_provider.dart';
import 'package:i_budget_app/ui/components/custom_buttons.dart';
import 'package:i_budget_app/utils/text_themes.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../utils/colors.dart';

class ModalCreateTransaction extends StatefulWidget {
  const ModalCreateTransaction({
    super.key,
  });

  @override
  State<ModalCreateTransaction> createState() => _ModalCreateTransactionState();
}

class _ModalCreateTransactionState extends State<ModalCreateTransaction> {
  late final TransactionsProvider _transactionsProvider;

  late TCategory _selectedCategory;
  late Account _selectedAccount;

  late final List<TCategory> _categories;
  late final List<Account> _accounts;

  final TextEditingController _controllerAccountUid = TextEditingController();
  final TextEditingController _controllerCategoryUid = TextEditingController();
  final TextEditingController _controllerAmountField = TextEditingController();
  final TextEditingController _controllerDescriptionField =
      TextEditingController();
  final TextEditingController _controllerDatePicker = TextEditingController();

  List<bool> _toggleSelection = [false, false];
  bool _canSubmit = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _categories =
        Provider.of<CategoriesProvider>(context, listen: false).categories;
    _accounts = Provider.of<AccountsProvider>(context, listen: false).accounts;
    _transactionsProvider =
        Provider.of<TransactionsProvider>(context, listen: false);

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
    _controllerDescriptionField.dispose();
    _controllerDatePicker.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //** Variables  */

    /** Functions */
    // Checks if every field is filled so it can create the transaction
    void checkCompleteness() {
      if (_controllerAccountUid.text != '' &&
          _controllerCategoryUid.text != '' &&
          _controllerAmountField.text != '' &&
          _controllerDescriptionField.text != '' &&
          _controllerDatePicker.text != '' &&
          (_toggleSelection[0] != false || _toggleSelection[1] != false)) {
        _canSubmit = true;
      } else {
        _canSubmit = false;
      }
      setState(() {});
    }

    //Toggles the button
    void toggleSelected(int position) {
      _toggleSelection = [false, false];
      _toggleSelection[position] = true;
      checkCompleteness();
      setState(() {});
    }

    //Show date picker
    Future<void> pickDate() async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), //get today's date
        firstDate: DateTime(
            2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101),
      );
      if (pickedDate != null) {
        _controllerDatePicker.text =
            DateFormat('yyyy-MM-dd').format(pickedDate);
        setState(() {});
        checkCompleteness();
      }
    }

    //Post new transaction
    Future<void> createTransaction() async {
      //Set loading in button
      _isLoading = true;
      setState(() {});

      final OverallProvider _overallProvider =
          Provider.of<OverallProvider>(context, listen: false);

      final String response = await _transactionsProvider.createTransaction(
        _controllerCategoryUid.text,
        _controllerAccountUid.text,
        double.parse(_controllerAmountField.text),
        _toggleSelection[0] == true ? 'Income' : 'Expense',
        _controllerDescriptionField.text,
        _controllerDatePicker.text,
      );

      if (response == 'OK') {
        await _transactionsProvider.getTransactions(
            month: _overallProvider.currentMonth,
            year: _overallProvider.currentYear);
        Navigator.pop(context);
      } else {
        print('Algo salio mal!!!');
      }

      //Stop loading
      _isLoading = false;
      setState(() {});
    }

    /** Build widgets */
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
          child: SingleChildScrollView(
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
                    fillColor: _toggleSelection[0] == true
                        ? kSuccessColor
                        : kErrorColor,
                    borderRadius: BorderRadius.circular(10.0),
                    onPressed: (value) => toggleSelected(value),
                    children: const [
                      Text('Ingreso'),
                      Text('Gasto'),
                    ],
                  );
                }),
                const SizedBox(height: 15),
                TextField(
                  controller:
                      _controllerDatePicker, //editing controller of this TextField
                  decoration: const InputDecoration(
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        color: kPrimaryColor,
                      ), //icon of text field
                      hintText: "Fecha" //label text of field
                      ),
                  readOnly: true, // when true user cannot edit text
                  onTap: () => pickDate(),
                ),
                const SizedBox(height: 15),
                DropdownButtonFormField<Account>(
                  value: _selectedAccount,
                  dropdownColor: kWhiteColor,
                  items: [
                    ..._accounts
                        .map((c) =>
                            DropdownMenuItem(value: c, child: Text(c.name)))
                        .toList()
                  ],
                  onChanged: (selectedAccount) {
                    _controllerAccountUid.text = selectedAccount?.uid ?? '';
                    if (selectedAccount != null) {
                      _selectedAccount = selectedAccount;
                    }
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
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
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
                TextField(
                  controller: _controllerDescriptionField,
                  decoration: const InputDecoration().copyWith(
                    hintText: 'Descripcion..',
                  ),
                  onChanged: (_) => checkCompleteness(),
                ),
                const SizedBox(height: 15),
                PrimaryButton(
                  onTap: () => createTransaction(),
                  text: 'Agregar',
                  isActive: _canSubmit,
                  isLoading: _isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
