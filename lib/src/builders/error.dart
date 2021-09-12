import 'package:fdl_server/src/interfaces/builder.dart';

class ErrorMessageBuilder implements IBuilder<String> {
  int? errorCode;
  String? errorStatus;
  String? errorMessage;

  ErrorMessageBuilder({
    this.errorCode,
    this.errorStatus,
    this.errorMessage,
  });

  @override
  String build() {
    return {
      'errorCode': errorCode!,
      'errorStatus': errorStatus!,
      'errorMessage': errorMessage!,
    }.toString();
  }
}
