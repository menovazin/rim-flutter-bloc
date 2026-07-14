import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_base_kit/flutter_base_kit.dart';

@immutable
abstract class RimBaseService {
  const RimBaseService();

  Future<T> errorParser<T>(Future<T> Function() callback) async {
    try {
      return await callback();
    } on DioException catch (exception) {
      throw _mapDioException(exception);
    } catch (exception, stackTrace) {
      loggerApp.e(
        exception.toString(),
        error: exception,
        stackTrace: stackTrace,
      );
      throw ApplicationException(exception.toString());
    }
  }

  ApiException _mapDioException(DioException exception) {
    return switch (exception.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.connectionError ||
      DioExceptionType.badCertificate =>
        ApiException(
          message: 'Internet Connection Error',
          errors: 'Internet Connection Error',
        ),
      DioExceptionType.badResponse => ApiException(
          message: 'Server error occurred',
          errors: 'Server error occurred',
          statusCode: exception.response?.statusCode,
        ),
      DioExceptionType.cancel || DioExceptionType.unknown => ApiException(
          message: 'Server error occurred',
          errors: 'Server error occurred',
        ),
      DioExceptionType.transformTimeout => ApiException(
          message: 'Server error occurred',
          errors: 'Server error occurred',
        ),
    };
  }
}