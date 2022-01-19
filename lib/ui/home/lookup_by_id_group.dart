import 'package:bayan/apiServeic/post_servies.dart';
import 'package:bayan/spner_model.dart';

class LookupByIdGrpModel {
  static List<SpinnerModels>customerActivityLst=[];
  static List<SpinnerModels>customerTypeLst=[];
 static List<SpinnerModels>customerStatusLst=[];
 static List<SpinnerModels>followTypeLst=[];
  int ?id;
  int ?groupId;
  String ?name;
  String ?fName;
  bool ?isActive;
  LookupByIdGrpModel(
      {this.id, this.groupId, this.name, this.fName, this.isActive});

  LookupByIdGrpModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['groupId'];
    name = json['name'];
    fName = json['fName'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['groupId'] = groupId;
    data['name'] = name;
    data['fName'] = fName;
    data['isActive'] = isActive;
    return data;
  }
  fetchCustomerActivity({required Function(List<SpinnerModels> value) fullLstFun,required Function() emptyLstFun,}){
    if(customerActivityLst.isEmpty) {
      ApiService(url:"Lookup/GetByGroupId?GroupId=12").getData(
        onSuccess: (data)async{
          var _backData = data as List;
          if(_backData.isNotEmpty){
            data.forEach((element) {
              customerActivityLst.add(SpinnerModels(id: element["id"],arabicValue:element["name"],englishValue: element["name"]));
            });
            fullLstFun(customerActivityLst);
          }
          else {
            emptyLstFun();
          }
        },
        onError: (error)=>print("erroooor\n"+error.toString()),
        onRunTime: (){
          fetchCustomerActivity(fullLstFun: fullLstFun,emptyLstFun: emptyLstFun);
        });
    } else {
      fullLstFun(customerActivityLst);
    }
  }
  fetchCustomerType({required Function(List<SpinnerModels> value) fullLstFun,required Function() emptyLstFun,}){
    if(customerTypeLst.isEmpty) {
      ApiService(url:"Lookup/GetByGroupId?GroupId=13",dataSend: {"":""}).getData(
        onSuccess: (data)async{
          var _backData = data as List;
          if(_backData.isNotEmpty){
            data.forEach((element) {
              customerTypeLst.add(SpinnerModels(id: element["id"],arabicValue:element["name"],englishValue: element["fName"]));
            });
            fullLstFun(customerTypeLst);
          }
          else {
            emptyLstFun();
          }
        },
        onError: (error)=>emptyLstFun(),
        onRunTime: (){
          fetchCustomerType(fullLstFun: fullLstFun,emptyLstFun: emptyLstFun);
        });
    } else {
      fullLstFun(customerTypeLst);
    }
  }
  fetchCustomerStatus({required Function(List<SpinnerModels> value) fullLstFun,required Function() emptyLstFun,}){
    if(customerStatusLst.isEmpty) {
      ApiService(url:"Lookup/GetByGroupId?GroupId=14",dataSend: {"":""}).getData(
        onSuccess: (data)async{
          var _backData = data as List;
          if(_backData.isNotEmpty){
            data.forEach((element) {
              customerStatusLst.add(SpinnerModels(id: element["id"],arabicValue:element["name"],englishValue: element["fName"]));
            });
            fullLstFun(customerStatusLst);
          }
          else {
            emptyLstFun();
          }
        },
        onError: (error)=>emptyLstFun(),
        onRunTime: (){
          fetchCustomerStatus(fullLstFun: fullLstFun,emptyLstFun: emptyLstFun);
        });
    } else  {
      fullLstFun(customerStatusLst);
    }
  }
}
