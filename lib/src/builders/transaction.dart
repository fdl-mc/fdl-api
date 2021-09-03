import 'package:fdl_server/src/interfaces/builder.dart';
import 'package:mongo_dart/mongo_dart.dart';

class TransactionBuilder implements IBuilder<Map<String, dynamic>> {
  String? payer;
  String? payee;
  int? amount;
  String? comment;
  Timestamp? at;

  TransactionBuilder(
      {this.payer, this.payee, this.amount, this.comment, this.at});

  @override
  Map<String, dynamic> build() {
    return {
      'payer': payer!,
      'payee': payee!,
      'amount': amount!,
      if (comment != null) 'comment': comment,
      'at': at,
    };
  }
}
