class TCategory {
  String name;
  double monthlyBudget;
  String uid;

  static List<TCategory> dummyCategories = [
    TCategory(name: 'Arriendo', monthlyBudget: 650, uid: 'AAAA'),
    TCategory(name: 'Mercado', monthlyBudget: 120, uid: 'BBBB'),
    TCategory(name: 'Ahorro Familia', monthlyBudget: 120, uid: 'BBBB'),
    TCategory(name: 'Deporte', monthlyBudget: 120, uid: 'BBBB'),
    TCategory(name: 'Celular', monthlyBudget: 120, uid: 'BBBB'),
  ];

  TCategory({
    required this.name,
    required this.monthlyBudget,
    required this.uid,
  });

  factory TCategory.fromJson(Map<String, dynamic> json) => TCategory(
        name: json['name'],
        monthlyBudget: json['monthlyBudget'].toDouble(),
        uid: json['uid'] ?? json['_id'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['monthlyBudget'] = monthlyBudget;
    data['uid'] = uid;
    return data;
  }
}
