import 'package:bayan/apiServeic/post_servies.dart';
import 'package:bayan/spner_model.dart';

class LookupModel {
  static List<SpinnerModels>followTypeLst=[];
  static List<SpinnerModels>followPurposeLst=[];
  static List<SpinnerModels>typeServiceRequireLst=[];

  int ?id;
  String ?code;
  String ?name;
  int ?deptId;
  int ?categoryID;
  int ?promotionId;
  bool ?isActive;
  String ?languageCode;

  LookupModel(
      {this.id,
        this.code,
        this.name,
        this.deptId,
        this.categoryID,
        this.promotionId,
        this.isActive,
        this.languageCode});

  LookupModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    deptId = json['deptId'];
    categoryID = json['categoryID'];
    promotionId = json['promotionId'];
    isActive = json['is_Active'];
    languageCode = json['language_Code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['deptId'] = deptId;
    data['categoryID'] = categoryID;
    data['promotionId'] = promotionId;
    data['is_Active'] = isActive;
    data['language_Code'] = languageCode;
    return data;
  }
  fetchFollowType({required Function(List<SpinnerModels> value) fullLstFun,required Function() emptyLstFun,}){
    if(followTypeLst.isEmpty) {
      print("78");
      ApiService(url:"Lookup/GetByGroupId?GroupId=15",dataSend: {"":""}).getData(
          onSuccess: (data)async{
            var _backData = data as List;
            if(_backData.isNotEmpty){
              // _leagueLst.clear();
              data.forEach((element) {
                followTypeLst.add(SpinnerModels(id: element["id"],arabicValue:element["name"],englishValue: element["name"]));
              });
              fullLstFun(followTypeLst);
            }
            else {
              emptyLstFun();
            }
          },
          onError: (error)=>emptyLstFun(),
          onRunTime: (){
            fetchFollowType(fullLstFun: fullLstFun,emptyLstFun: emptyLstFun);
          });
    } else {
      fullLstFun(followTypeLst);
    }
  }

  fetchPurposeFollow({required Function(List<SpinnerModels> value) fullLstFun,required Function() emptyLstFun,}){
    if(followTypeLst.isEmpty) {
      print("78");
      ApiService(url:"Lookup/GetByGroupId?GroupId=19",dataSend: {"":""}).getData(
          onSuccess: (data)async{
            var _backData = data as List;
            if(_backData.isNotEmpty){
              data.forEach((element) {
                followPurposeLst.add(SpinnerModels(id: element["id"],arabicValue:element["name"],englishValue: element["name"]));
              });
              fullLstFun(followPurposeLst);
            }
            else {
              emptyLstFun();
            }
          },
          onError: (error)=>emptyLstFun(),
          onRunTime: (){
            fetchPurposeFollow(fullLstFun: fullLstFun,emptyLstFun: emptyLstFun);
          });
    } else {
      fullLstFun(followPurposeLst);
    }
  }

  fetchTypeServiceRequire({required Function(List<SpinnerModels> value) fullLstFun,required Function() emptyLstFun,}){
      ApiService(url:"Lookup/GetByGroupId?GroupId=16",dataSend: {"":""}).getData(
          onSuccess: (data)async{
            typeServiceRequireLst.clear();
            var _backData = data as List;
            if(_backData.isNotEmpty){
              data.forEach((element) {
                typeServiceRequireLst.add(SpinnerModels(id: element["id"],arabicValue:element["name"],englishValue: element["name"]));
              });
              fullLstFun(typeServiceRequireLst);
            }
            else {
              emptyLstFun();
            }
          },
          onError: (error)=>emptyLstFun(),
          onRunTime: (){
            fetchPurposeFollow(fullLstFun: fullLstFun,emptyLstFun: emptyLstFun);
          });

  }

}
