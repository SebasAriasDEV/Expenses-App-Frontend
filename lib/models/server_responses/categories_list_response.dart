import 'package:i_budget_app/models/category_model.dart';

class CategoriesListResponse {
  late int total;
  late List<TCategory> categories;

  CategoriesListResponse({required this.total, required this.categories});

  CategoriesListResponse.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories.add(TCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;

    data['categories'] = categories.map((v) => v.toJson()).toList();

    return data;
  }
}
