class ErrorModel {
  String? message;

  ErrorModel({this.message});

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        message: json['error'] == null
            ? null
            : (json['error'] as Map<String, dynamic>)['message'] as String,
      );

  Map<String, dynamic> toJson() => {
        'message': message,
      };
}
