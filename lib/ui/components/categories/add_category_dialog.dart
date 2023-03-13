// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:i_budget_app/providers/categories_providers.dart';
import 'package:i_budget_app/providers/overall_provider.dart';
import 'package:i_budget_app/ui/components/custom_buttons.dart';
import 'package:i_budget_app/ui/components/custom_snackbar.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';
import '../../../utils/text_themes.dart';

class NewCategoryDialog extends StatefulWidget {
  const NewCategoryDialog({
    super.key,
  });

  @override
  State<NewCategoryDialog> createState() => _NewCategoryDialogState();
}

class _NewCategoryDialogState extends State<NewCategoryDialog> {
  //** Providers */
  late final OverallProvider _overallProvider;

  //** Variables */
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerBudget = TextEditingController();

  late int _selectedMonth;
  late int _selectedYear;
  late String _selectedCurrency;

  bool _canSubmit = false;
  bool _isLoading = false;

  //** Init State */
  @override
  void initState() {
    super.initState();

    _overallProvider = Provider.of<OverallProvider>(context, listen: false);

    _selectedMonth = _overallProvider.currentMonth;
    _selectedYear = _overallProvider.currentYear;
    _selectedCurrency = _overallProvider.overallCurrency;
  }

  @override
  void dispose() {
    super.dispose();
    _controllerName.dispose();
    _controllerBudget.dispose();
  }

  //** Build widgets */
  @override
  Widget build(BuildContext context) {
    //** Build - Providers */
    final CategoriesProvider _categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);

    //** Build -  Variables */
    final List<int> _months = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
    final List<int> _years = [2023, 2024, 2025];
    final List<String> _currencies = ['COP', 'EUR'];

    //** Build - Functions */
    //Check completeness
    void checkCompleteness() {
      if (_controllerName.text != '' &&
          _controllerBudget.text != '' &&
          _selectedMonth != 0 &&
          _selectedYear != 0 &&
          _selectedCurrency != '') {
        _canSubmit = true;
      } else {
        _canSubmit = false;
      }
      setState(() {});
    }

    //Create a new category
    Future<void> createCategory() async {
      //Set loading to true
      _isLoading = true;
      setState(() {});

      final response = await _categoriesProvider.createCategory(
        _controllerName.text,
        double.parse(_controllerBudget.text),
        _selectedMonth,
        _selectedYear,
        _selectedCurrency,
      );

      if (response == 'OK') {
        await _categoriesProvider.getCategories(
            month: _overallProvider.currentMonth,
            year: _overallProvider.currentYear,
            displayCurrency: _overallProvider.overallCurrency);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(text: 'El presupuesto ha sido creado!'));
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
            text: 'Ups! No pudimos crear el presupuesto.', isError: true));
        print('Algo salio mal');
      }

      //Stops loading
      _isLoading = false;
      setState(() {});
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      backgroundColor: kGreyColorShade4,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Nuevo presupuesto', style: headline4),
              const SizedBox(height: 15),
              TextField(
                controller: _controllerName,
                decoration: const InputDecoration().copyWith(
                  hintText: 'Nombre del presupuesto',
                ),
                onChanged: (_) => checkCompleteness(),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(hintText: "Moneda"),
                      dropdownColor: kWhiteColor,
                      value: _selectedCurrency,
                      items: _currencies
                          .map(
                            (m) => DropdownMenuItem(
                              value: m,
                              child: Text(
                                m.toString(),
                              ),
                            ),
                          )
                          .toList(), // => pickDate(),
                      onChanged: (newCurrency) {
                        if (newCurrency != null) {
                          _selectedCurrency = newCurrency;
                        }
                        checkCompleteness();
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: _controllerBudget,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration().copyWith(
                        hintText: 'Presupuesto mensual',
                      ),
                      onChanged: (_) => checkCompleteness(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      decoration: const InputDecoration(hintText: "Mes"),
                      dropdownColor: kWhiteColor,
                      value: _selectedMonth,
                      items: _months
                          .map((m) => DropdownMenuItem(
                              value: m, child: Text(m.toString())))
                          .toList(), // => pickDate(),
                      onChanged: (newMonth) {
                        if (newMonth != null) {
                          _selectedMonth = newMonth;
                        }
                        checkCompleteness();
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      value: _selectedYear,
                      decoration: const InputDecoration(hintText: "Año"),
                      dropdownColor: kWhiteColor,
                      items: _years
                          .map((y) => DropdownMenuItem(
                              value: y, child: Text(y.toString())))
                          .toList(), // => pickDate(),
                      onChanged: (newYear) {
                        if (newYear != null) {
                          _selectedYear = newYear;
                        }
                        checkCompleteness();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              PrimaryButton(
                onTap: () => createCategory(), //=> createAccount(),
                text: 'Crear presupuesto',
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
