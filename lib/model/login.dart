class Login {
  int? code;
  bool? status;
  String? token;
  int? userId;
  String? userNama;
  String? userEmail;

  Login({
    this.code,
    this.status,
    this.token,
    this.userId,
    this.userNama,
    this.userEmail,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    if (json['code'] == 200) {
      return Login(
        code: json['code'],
        status: json['status'],
        token: json['data']['token'],
        userId: int.parse(json['data']['user']['id'].toString()),
        userNama: json['data']['user']['nama'],
        userEmail: json['data']['user']['email'],
      );
    } else {
      return Login(
        code: json['code'],
        status: json['status'],
      );
    }
  }
}