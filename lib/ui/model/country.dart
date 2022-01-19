import 'package:bayan/apiServeic/post_servies.dart';
import 'package:bayan/spner_model.dart';

class CountryModel {
  List<SpinnerModels>countryList=[];
  int ?id;
  String ?name;
  int ?parentId;
  String ?languageCode;

  CountryModel({this.id, this.name, this.parentId, this.languageCode});

  CountryModel.fromJson(Map<String, dynamic> json) {
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
  fetchCountry({required Function(List<SpinnerModels> value) fullLstFun,required Function() emptyLstFun,}){
    if(countryList.isEmpty) {
      ApiService(url:"Country/GetDropDownList",dataSend: {"":""}).getData(
          onSuccess: (data)async{
            var _backData = data as List;
            if(_backData.isNotEmpty){
              data.forEach((element) {countryList.add(SpinnerModels(id: element["id"],arabicValue:element["name"],englishValue: element["name"]));});
              fullLstFun(countryList);
            }
            else {
              emptyLstFun();
            }
          },
          onError: (error)=>emptyLstFun(),
          onRunTime: (){
            fetchCountry(fullLstFun: fullLstFun,emptyLstFun: emptyLstFun);
          });
    } else {
      fullLstFun(countryList);
    }
  }

}
