class APIResponse<T> {
  bool? status;
  T? data;
  String? msg;
  int? code;

  APIResponse({this.status, this.data, this.msg, this.code});

  factory APIResponse.fromJson(Map<String, dynamic> json, Function? builder) {
    return APIResponse(
      status: json['status'] != null ? json['status'] as bool : false,
      data: (builder == null || json['data'] == null)
          ? json['data']
          : builder(json['data']),
      msg: json['msg'] != null ? json['msg'] as String : '',
      code: json['code'] != null ? json['code'] as int : 400,
    );
  }
}
