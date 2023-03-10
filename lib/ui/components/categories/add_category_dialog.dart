import 'package:flutter/material.dart';
import 'package:i_budget_app/ui/components/custom_buttons.dart';

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

  //** Variables */
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerBudget = TextEditingController();
  final TextEditingController _controllerDatePicker = TextEditingController();

  bool _canSubmit = false;
  bool _isLoading = false;

  //** Init State */
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controllerName.dispose();
    _controllerBudget.dispose();
    _controllerDatePicker.dispose();
  }

  //** Functions */
  void checkCompleteness() {
    if (_controllerName.text != '' &&
        _controllerName.text != '' &&
        _controllerBudget.text != '' &&
        _controllerDatePicker.text != '') {
      _canSubmit = true;
    } else {
      _canSubmit = false;
    }
    setState(() {});
  }

  //** Build widgets */
  @override
  Widget build(BuildContext context) {
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
              TextField(
                controller: _controllerBudget,
                decoration: const InputDecoration().copyWith(
                  hintText: 'Presupuesto mensual',
                ),
                onChanged: (_) => checkCompleteness(),
              ),
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
                  onTap: () {} // => pickDate(),
                  ),
              const SizedBox(height: 15),
              PrimaryButton(
                onTap: () {}, //=> createAccount(),
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
