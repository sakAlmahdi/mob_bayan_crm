import 'package:bayan/apiServeic/post_servies.dart';
import 'package:bayan/spner_model.dart';

class CityModel {
  List<SpinnerModels>cityList=[];
  List<SpinnerModels>areaList=[];
  int ?id;
  String ?name;
  int ?parentId;
  String ?languageCode;

  CityModel({this.id, this.name, this.parentId, this.languageCode});

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parentId'];
    languageCode = json['language_Code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['parentId'] = parentId;
    data['language_Code'] = languageCode;
    return data;
  }
  fetchCity({required Function(List<SpinnerModels> value) fullLstFun,required Function() emptyLstFun,}){
    if(cityList.isEmpty) {
      ApiService(url:"City/GetDropDownListByCountryId?CountryId=$id",dataSend: {"":""}).getData(
          onSuccess: (data)async{
            var _backData = data as List;
            if(_backData.isNotEmpty){
              data.forEach((element) {cityList.add(SpinnerModels(id: element["id"],arabicValue:element["name"],englishValue: element["name"]));});
              fullLstFun(cityList);
            }
            else {
              emptyLstFun();
            }
          },
          onError: (error)=>emptyLstFun(),
          onRunTime: (){
            fetchCity(fullLstFun: fullLstFun,emptyLstFun: emptyLstFun);
          });
    } else {
      fullLstFun(cityList);
    }
  }
  fetchArea({required Function(List<SpinnerModels> value) fullLstFun,required Function() emptyLstFun,}){
    if(cityList.isEmpty) {
      ApiService(url:"Area/GetDropDownListByCityId?CityId=$id",dataSend: {"":""}).getData(
          onSuccess: (data)async{
            var _backData = data as List;
            if(_backData.isNotEmpty){
              data.forEach((element) {cityList.add(SpinnerModels(id: element["id"],arabicValue:element["name"],englishValue: element["name"]));});
              fullLstFun(cityList);
            }
            else {
              emptyLstFun();
            }
          },
          onError: (error)=>emptyLstFun(),
          onRunTime: (){
            fetchCity(fullLstFun: fullLstFun,emptyLstFun: emptyLstFun);
          });
    } else {
      fullLstFun(cityList);
    }
  }

}