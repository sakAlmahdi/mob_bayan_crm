import 'package:bayan/apiServeic/post_servies.dart';
class CounterModel {

  List<TopCounters>? topCounters;
  List<TopCounters>? buttomConter;
  CounterModel({this.topCounters, this.buttomConter});

  CounterModel.fromJson(Map<String, dynamic> json) {
    if (json['topCounters'] != null) {
      topCounters = <TopCounters>[];
      json['topCounters'].forEach((v) {
        topCounters!.add(TopCounters.fromJson(v));
      });
    }
    if (json['buttomConter'] != null) {
      buttomConter = <TopCounters>[];
      json['buttomConter'].forEach((v) {
        buttomConter!.add(TopCounters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (topCounters != null) {
      data['topCounters'] = topCounters!.map((v) => v.toJson()).toList();
    }
    if (buttomConter != null) {
      data['buttomConter'] = buttomConter!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  fetchCounter({required Function(CounterModel value) fullLstFun,required Function() emptyLstFun,required Function(dynamic errorData) errorFun,String ? txt,int ?page}){
    ApiService(url:'CRM_Customer/GetCounter',dataSend: {"":""}).getData(
        onSuccess: (data)async{
          if(data!=null) {
            fullLstFun(CounterModel.fromJson(data));
          }
          else {
            emptyLstFun();
          }
        },
        onError: (error){
          errorFun(error);},
        onRunTime: (){errorFun("runTime");});
  }

}

class TopCounters {
  String? text;
  int? value;

  TopCounters({this.text, this.value});

  TopCounters.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['value'] = value;
    return data;
  }
}
