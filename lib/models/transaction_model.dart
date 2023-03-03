class Transaction {
  static List<Transaction> get dummyTransactions => [
        Transaction(
          transactionType: 'INCOME',
          amount: 500000,
          date: DateTime.now(),
          description: 'Sueldo TUL',
          user: 'Sebas',
          account: 'Scotiabank',
          category: 'Sueldo',
          uid: 'GGGGG',
        ),
        Transaction(
          transactionType: 'EXPENSE',
          amount: 1000,
          date: DateTime.now(),
          description: 'Arriendo cuota Marzo',
          user: 'Sebas',
          account: 'Scotiabank',
          category: 'Sueldo',
          uid: 'GGGGG',
        ),
        Transaction(
          transactionType: 'INCOME',
          amount: 500000,
          date: DateTime.now(),
          description: 'Sueldo TUL',
          user: 'Sebas',
          account: 'Scotiabank',
          category: 'Sueldo',
          uid: 'GGGGG',
        ),
        Transaction(
          transactionType: 'INCOME',
          amount: 500000,
          date: DateTime.now(),
          description: 'Sueldo TUL',
          user: 'Sebas',
          account: 'Scotiabank',
          category: 'Sueldo',
          uid: 'GGGGG',
        ),
        Transaction(
          transactionType: 'INCOME',
          amount: 500000,
          date: DateTime.now(),
          description: 'Sueldo TUL',
          user: 'Sebas',
          account: 'Scotiabank',
          category: 'Sueldo',
          uid: 'GGGGG',
        ),
        Transaction(
          transactionType: 'INCOME',
          amount: 500000,
          date: DateTime.now(),
          description: 'Sueldo TUL',
          user: 'Sebas',
          account: 'Scotiabank',
          category: 'Sueldo',
          uid: 'GGGGG',
        ),
        Transaction(
          transactionType: 'INCOME',
          amount: 500000,
          date: DateTime.now(),
          description: 'Sueldo TUL',
          user: 'Sebas',
          account: 'Scotiabank',
          category: 'Sueldo',
          uid: 'GGGGG',
        ),
        Transaction(
          transactionType: 'INCOME',
          amount: 500000,
          date: DateTime.now(),
          description: 'Sueldo TUL',
          user: 'Sebas',
          account: 'Scotiabank',
          category: 'Sueldo',
          uid: 'GGGGG',
        ),
        Transaction(
          transactionType: 'INCOME',
          amount: 500000,
          date: DateTime.now(),
          description: 'Sueldo TUL',
          user: 'Sebas',
          account: 'Scotiabank',
          category: 'Sueldo',
          uid: 'GGGGG',
        ),
        Transaction(
          transactionType: 'INCOME',
          amount: 500000,
          date: DateTime.now(),
          description: 'Sueldo TUL',
          user: 'Sebas',
          account: 'Scotiabank',
          category: 'Sueldo',
          uid: 'GGGGG',
        ),
        Transaction(
          transactionType: 'INCOME',
          amount: 500000,
          date: DateTime.now(),
          description: 'Sueldo TUL',
          user: 'Sebas',
          account: 'Scotiabank',
          category: 'Sueldo',
          uid: 'GGGGG',
        ),
        Transaction(
          transactionType: 'INCOME',
          amount: 500000,
          date: DateTime.now(),
          description: 'Sueldo TUL',
          user: 'Sebas',
          account: 'Scotiabank',
          category: 'Sueldo',
          uid: 'GGGGG',
        ),
        Transaction(
          transactionType: 'INCOME',
          amount: 500000,
          date: DateTime.now(),
          description: 'Sueldo TUL',
          user: 'Sebas',
          account: 'Scotiabank',
          category: 'Sueldo',
          uid: 'GGGGG',
        ),
        Transaction(
          transactionType: 'INCOME',
          amount: 500000,
          date: DateTime.now(),
          description: 'Sueldo TUL',
          user: 'Sebas',
          account: 'Scotiabank',
          category: 'Sueldo',
          uid: 'GGGGG',
        ),
        Transaction(
          transactionType: 'INCOME',
          amount: 500000,
          date: DateTime.now(),
          description: 'Sueldo TUL',
          user: 'Sebas',
          account: 'Scotiabank',
          category: 'Sueldo',
          uid: 'GGGGG',
        ),
        Transaction(
          transactionType: 'INCOME',
          amount: 500000,
          date: DateTime.now(),
          description: 'Sueldo TUL',
          user: 'Sebas',
          account: 'Scotiabank',
          category: 'Sueldo',
          uid: 'GGGGG',
        ),
        Transaction(
          transactionType: 'INCOME',
          amount: 500000,
          date: DateTime.now(),
          description: 'Sueldo TUL',
          user: 'Sebas',
          account: 'Scotiabank',
          category: 'Sueldo',
          uid: 'GGGGG',
        ),
        Transaction(
          transactionType: 'INCOME',
          amount: 500000,
          date: DateTime.now(),
          description: 'Sueldo TUL',
          user: 'Sebas',
          account: 'Scotiabank',
          category: 'Sueldo',
          uid: 'GGGGG',
        ),
        Transaction(
          transactionType: 'INCOME',
          amount: 500000,
          date: DateTime.now(),
          description: 'Sueldo TUL',
          user: 'Sebas',
          account: 'Scotiabank',
          category: 'Sueldo',
          uid: 'GGGGG',
        ),
        Transaction(
          transactionType: 'INCOME',
          amount: 500000,
          date: DateTime.now(),
          description: 'Sueldo TUL',
          user: 'Sebas',
          account: 'Scotiabank',
          category: 'Sueldo',
          uid: 'GGGGG',
        ),
      ];

  Transaction({
    required this.transactionType,
    required this.amount,
    required this.date,
    required this.description,
    required this.user,
    required this.account,
    required this.category,
    required this.uid,
  });
  final String transactionType;
  final double amount;
  final DateTime date;
  final String description;
  final String user;
  final String account;
  final String category;
  final String uid;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        transactionType: json['transactionType'],
        amount: json['amount'],
        date: json['date'],
        description: json['description'],
        user: json['user'],
        account: json['account'],
        category: json['category'],
        uid: json['uid'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['transactionType'] = transactionType;
    data['amount'] = amount;
    data['date'] = date;
    data['description'] = description;
    data['user'] = user;
    data['account'] = account;
    data['category'] = category;
    data['uid'] = uid;
    return data;
  }
}
