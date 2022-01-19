import 'package:get/get.dart';
import 'arabic.dart';
import 'english.dart';

class Translation extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en':en,
    'ar':ar,
  };
}

abstract class TranslateText{
  static const unKnowError ='unKnowError';
  static const appName ='appName';
  static const userName ='userName';

}
abstract class DialogTxtTrns{
  static const ExitAppDialogTitle ='ExitAppDialogTitle';
  static const ExitAppDialogMsg ='ExitAppDialogMsg';
  static const NoEnterNetDialogTitle ='NoEnterNetDialogTitle';
  static const NoEnterNetDialogMsg ='NoEnterNetDialogMsg';
  static const CanNtCatchCloudDialogTitle ='CanNtCatchCloudDialogTitle';
  static const CanNtCatchCloudDialogMsg ='CanNtCatchCloudDialogMsg';
  static const TryAgainDialogTitle ='TryAgainDialogTitle';
  static const TryAgainDialogMsg ='TryAgainDialogMsg';
  static const ExitAccountApp ='ExitAccountApp';
}