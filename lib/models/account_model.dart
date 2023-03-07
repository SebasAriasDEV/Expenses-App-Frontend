class Account {
  String name;
  String type;
  String currency;
  String uid;
  double balance;

  static List<Account> get dummyAccounts => [
        Account(
          name: 'Scotiabank Nomina',
          type: 'Debito',
          currency: 'COP',
          uid: 'AAA',
          balance: 9000000,
        ),
        Account(
          name: 'Nequi',
          type: 'Debito',
          currency: 'COP',
          uid: 'AAA',
          balance: 500000,
        ),
        Account(
          name: 'Santander BCN',
          type: 'Debito',
          currency: 'EUR',
          uid: 'AAA',
          balance: 720,
        ),
      ];

  Account({
    required this.name,
    required this.type,
    required this.currency,
    required this.uid,
    required this.balance,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        name: json['name'],
        type: json['type'],
        currency: json['currency'],
        uid: json['uid'] ?? json['_id'],
        balance: json['balance'].toDouble(),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['type'] = type;
    data['currency'] = currency;
    data['uid'] = uid;
    data['balance'] = balance;
    return data;
  }
}
