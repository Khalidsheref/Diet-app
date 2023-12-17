class UserModel{
  String? fullName;
  String? email;
  String? token;

  UserModel({this.fullName,this.email,this.token});

  UserModel.fromJson(Map<String,dynamic> data){
    fullName = data['full_name'];
    email = data['email'];
  }

  toJson(){
    Map<String,dynamic> data = {};
    data['full_name'] = fullName;
    data['email'] = email;
    data['token'] = token;
    return data;
  }
}