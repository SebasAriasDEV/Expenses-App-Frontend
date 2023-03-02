import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_budget_app/utils/colors.dart';
import 'package:i_budget_app/utils/text_themes.dart';

import '../../models/category_model.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});

  final TCategory category;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: CategoryCardContent(category: category),
    );
  }
}

class CategoryCardContent extends StatelessWidget {
  const CategoryCardContent({super.key, required this.category});

  final TCategory category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          const CategoryIconBox(),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(category.name, style: headline6),
                    const Text("US 900", style: headline6),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("20 Movimientos", style: paragraph6),
                    Text("de 980", style: paragraph6),
                  ],
                ),
                const SizedBox(height: 8),
                const LinearProgressIndicator(
                  value: 0.8,
                  backgroundColor: kPurpleColorLight,
                  color: kPurpleColor,
                  minHeight: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryIconBox extends StatelessWidget {
  const CategoryIconBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: kPurpleColorLight,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SvgPicture.asset(
        'assets/Apple.svg',
        height: 20,
        width: 20,
        color: kPurpleColor,
      ),
    );
  }
}
