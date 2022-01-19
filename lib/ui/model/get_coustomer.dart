import 'package:bayan/apiServeic/post_servies.dart';

class CoustomerModel {
  String? id;
  String? name;
  String? mobile;
  String? nextFollowType;
  String? contactName;
  String? requirments;
  String? createBy;
  String? createDate;

  CoustomerModel(
      {this.id,
        this.name,
        this.mobile,
        this.nextFollowType,
        this.contactName,
        this.requirments,
        this.createBy,
        this.createDate});

  CoustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    nextFollowType = json['nextFollowType'];
    contactName = json['contact_Name'];
    requirments = json['requirments'];
    createBy = json['createBy'];
    createDate = json['createDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['mobile'] = mobile;
    data['nextFollowType'] = nextFollowType;
    data['contact_Name'] = contactName;
    data['requirments'] = requirments;
    data['createBy'] = createBy;
    data['createDate'] = createDate;
    return data;
  }
  fetchNewCustomer({required Function(List<CoustomerModel> value) fullLstFun,required Function() emptyLstFun,required Function(dynamic errorData) errorFun,String ? txt,int ?page}){
    ApiService(url:'CRM_Customer/GetNewCustomers',dataSend: {"":""}).getData(
        onSuccess: (data)async{
          var _backData = data as List;
          if(_backData.isNotEmpty){
            fullLstFun(_backData.map((element) => CoustomerModel.fromJson(element)).toList());
          }
          else {
            emptyLstFun();
          }
        },
        onError: (error){
          errorFun(error);},
        onRunTime: (){errorFun("runTime");});
  }
  fetchCoustomer({required Function(List<CoustomerModel> value) fullLstFun,required Function() emptyLstFun,required Function(dynamic errorData) errorFun,String ? txt,required int page}){
    print("1212");
    ApiService(url:'CRM_Customer/Get?SearchText=${txt??""}&PageNumber=$page&PageSize=10',dataSend: {"":""}).getData(
        onSuccess: (data)async{
          var _backData = data as List;
          if(_backData.isNotEmpty){
            fullLstFun(_backData.map((element) => CoustomerModel.fromJson(element)).toList());
          }
          else {
            emptyLstFun();
          }
        },
        onError: (error){
          errorFun(error);},
        onRunTime: (){errorFun("runTime");});
  }
  fetchCoustomerFollow({required Function(List<CoustomerModel> value) fullLstFun,required Function() emptyLstFun,required Function(dynamic errorData) errorFun,required String date}){
    // ApiService(url:'CRM_Customer/GetByDate?FollowupDate=2022-01-15&SearchText=&PageNumber=1&PageSize=10').getData(
    ApiService(url:'CRM_Customer/GetByDate?FollowupDate=$date&SearchText=''&PageNumber=1&PageSize=20').getData(
        onSuccess: (data)async{
          var _backData = data as List;
          if(_backData.isNotEmpty){
            await  fullLstFun(_backData.map((element) => CoustomerModel.fromJson(element)).toList());
          }
          else {
            emptyLstFun();
          }
        },
        onError: (error){
          errorFun(error);},
        onRunTime: (){errorFun("runTime");});
  }
// fetchCoustomerList({required Function(List<SpinnerModels> value) fullLstFun,required Function() emptyLstFun,}){
//   if(costomerLst.isEmpty) {
//     ApiService(url:"CRM_Customer/Get?SearchText=""&PageNumber=1&PageSize=10",dataSend: {"":""}).getData(
//         onSuccess: (data)async{
//           var _backData = data as List;
//           if(_backData.isNotEmpty){
//             data.forEach((element) {costomerLst.add(SpinnerModels(id:int.parse(element["mobile"].toString()),arabicValue:element["name"],englishValue: element["name"]));});
//             fullLstFun(costomerLst);
//           }
//           else {
//             emptyLstFun();
//           }
//         },
//         onError: (error)=>emptyLstFun(),
//         onRunTime: (){
//           fetchCoustomerList(fullLstFun: fullLstFun,emptyLstFun: emptyLstFun);
//         });
//   } else {
//     fullLstFun(costomerLst);
//   }
// }

}