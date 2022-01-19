import 'package:bayan/apiServeic/post_servies.dart';

class FollowsModel {
  String? typeName;
  String? targetName;
  String? followDate;
  String? followTime;
  int? interactionRange;
  String? goal;
  String? result;
  String? nextFollowDate;
  String? nextFollowTime;
  String? nextFollowType;
  String? createBy;

  FollowsModel(
      {this.typeName,
        this.targetName,
        this.followDate,
        this.followTime,
        this.interactionRange,
        this.goal,
        this.result,
        this.nextFollowDate,
        this.nextFollowTime,
        this.nextFollowType,
        this.createBy});

  FollowsModel.fromJson(Map<String, dynamic> json) {
    typeName = json['typeName'];
    targetName = json['targetName'];
    followDate = json['followDate'];
    followTime = json['followTime'];
    interactionRange = json['interaction_Range'];
    goal = json['goal'];
    result = json['result'];
    nextFollowDate = json['nextFollowDate'];
    nextFollowTime = json['nextFollowTime'];
    nextFollowType = json['nextFollowType'];
    createBy = json['createBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeName'] = this.typeName;
    data['targetName'] = this.targetName;
    data['followDate'] = this.followDate;
    data['followTime'] = this.followTime;
    data['interaction_Range'] = this.interactionRange;
    data['goal'] = this.goal;
    data['result'] = this.result;
    data['nextFollowDate'] = this.nextFollowDate;
    data['nextFollowTime'] = this.nextFollowTime;
    data['nextFollowType'] = this.nextFollowType;
    data['createBy'] = this.createBy;
    return data;
  }
  fetchFollows({required Function(List<FollowsModel> value) fullLstFun,required Function() emptyLstFun,required Function(dynamic errorData) errorFun,required String id}){
    ApiService(url:'CRM_FollowUpHistory/Get?CustomerId=$id&SearchText=&PageNumber=1&PageSize=10').getData(
        onSuccess: (data)async{
          var _backData = data as List;
          if(_backData.isNotEmpty){
            await  fullLstFun(_backData.map((element) => FollowsModel.fromJson(element)).toList());
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