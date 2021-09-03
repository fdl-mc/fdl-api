import 'package:fdl_server/src/interfaces/builder.dart';

class TransactionBuilder implements IBuilder<Map<String, dynamic>> {
  String? payer;
  String? payee;
  int? amount;
  String? comment;
  DateTime? at;

  TransactionBuilder({
    this.payer,
    this.payee,
    this.amount,
    this.comment,
    this.at,
  });

  @override
  Map<String, dynamic> build() {
    return {
      'payer': payer!,
      'payee': payee!,
      'amount': amount!,
      'comment': comment,
      'at': at,
    };
  }
}
