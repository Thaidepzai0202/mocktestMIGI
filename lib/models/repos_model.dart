
class ReposModel {
    String status;
    String? message;
    dynamic data;
    dynamic code;

    ReposModel({
        required this.status,
        required this.message,
        required this.data,
        required this.code,
    });

    factory ReposModel.fromJson(Map<String, dynamic> json) => ReposModel(
        status: json["status"],
        message: json["message"],
        data: json["data"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
        "code": code,
    };
}