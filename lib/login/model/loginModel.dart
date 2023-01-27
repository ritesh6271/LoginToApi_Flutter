class EmailModel {
  String? message;
  bool? error;
  int? code;
  Data? data;

  EmailModel({this.message, this.error, this.code, this.data});

  EmailModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? firstname;
  String? lastname;
  String? avatar;
  String? phone;
  String? email;
  String? role;
  int? roleId;
  String? token;

  Data(
      {this.id,
        this.firstname,
        this.lastname,
        this.avatar,
        this.phone,
        this.email,
        this.role,
        this.roleId,
        this.token});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    avatar = json['avatar'];
    phone = json['phone'];
    email = json['email'];
    role = json['role'];
    roleId = json['roleId'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['avatar'] = this.avatar;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['role'] = this.role;
    data['roleId'] = this.roleId;
    data['token'] = this.token;
    return data;
  }
}