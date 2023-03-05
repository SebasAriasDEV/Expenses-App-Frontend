import '../account_model.dart';

class AccountsListReponse {
  AccountsListReponse({
    required this.total,
    required this.accounts,
  });
  late final int total;
  late final List<Account> accounts;

  AccountsListReponse.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    accounts =
        List.from(json['accounts']).map((e) => Account.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['total'] = total;
    _data['accounts'] = accounts.map((e) => e.toJson()).toList();
    return _data;
  }
}
