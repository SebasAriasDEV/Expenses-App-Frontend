import 'package:flutter/material.dart';
import 'package:i_budget_app/providers/overall_provider.dart';
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
    final List<String> currencies = ['COP', 'EUR'];
    final List<String> subtitles = ['\$ - Peso Colombiano', '€ - Euro'];

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
                _overallProvider.overallCurrency = currencies[0];
                setState(() {});
              },
            ),
            CheckboxListTile(
              title: Text(currencies[1]),
              subtitle: Text(subtitles[1]),
              value: _selection[1],
              onChanged: (_) {
                _selection = [false, true];
                _overallProvider.overallCurrency = currencies[1];
                setState(() {});
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Tasa de cambio COP/EUR: 5.050',
              style: paragraph3.copyWith(color: kGreyColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
