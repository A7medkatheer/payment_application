import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_application/core/errors/errors/errors.dart';

class ServerException implements Exception {
  final ErrorModel errModel;

  ServerException({required this.errModel});
}

void handleDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.sendTimeout:
      throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.receiveTimeout:
      throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.badCertificate:
      throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.cancel:
      throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.connectionError:
      throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.unknown:
      throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400: // Bad request
          throw ServerException(
              errModel: ErrorModel.fromJson(e.response!.data));
        case 401: //unauthorized
          throw ServerException(
              errModel: ErrorModel.fromJson(e.response!.data));
        case 403: //forbidden
          throw ServerException(
              errModel: ErrorModel.fromJson(e.response!.data));
        case 404: //not found
          throw ServerException(
              errModel: ErrorModel.fromJson(e.response!.data));
        case 409: //cofficient
          throw ServerException(
              errModel: ErrorModel.fromJson(e.response!.data));
        case 422: //  Unprocessable Entity
          throw ServerException(
              errModel: ErrorModel.fromJson(e.response!.data));
        case 429: //  Unprocessable Entity
          throw ServerException(
              errModel: ErrorModel.fromJson(e.response!.data));
        case 504: // Server exception
          throw ServerException(
              errModel: ErrorModel.fromJson(e.response!.data));
        case 500: // Server exception
          throw ServerException(
              errModel: ErrorModel.fromJson(e.response!.data));
      }
  }
}

void handleStripeException(StripeException e) {
  String? localizedMessage = e.error.localizedMessage;
  debugPrint("Stripe Exception: $localizedMessage");
  // You can also show this message to the user using a dialog or a snackbar
}
