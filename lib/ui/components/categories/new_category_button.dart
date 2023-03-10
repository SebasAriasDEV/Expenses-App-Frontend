import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_budget_app/ui/components/categories/add_category_dialog.dart';
import 'package:i_budget_app/utils/colors.dart';

class NewCategoryButton extends StatelessWidget {
  const NewCategoryButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => showDialog(
          context: context, builder: (_) => const NewCategoryDialog()),
      icon: const FaIcon(
        FontAwesomeIcons.plus,
        color: kPrimaryColorDark,
      ),
      label: const Text(
        'Crear presupuesto',
        style: TextStyle(color: kPrimaryColorDark),
      ),
    );
  }
}
