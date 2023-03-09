import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_budget_app/ui/components/accounts/add_account_dialog.dart';
import 'package:i_budget_app/utils/colors.dart';

class NewCardPlaceholder extends StatelessWidget {
  const NewCardPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => const DialogCreateAccount(),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: kSuccessColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1000.0)),
        ),
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }
}
