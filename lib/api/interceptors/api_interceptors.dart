import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../services/storage/token/token_service.dart';
import '../request_tracker/request_tracker.dart';

/// Attaches Bearer token when present.
///
/// See [docs/adr/0002-fake-login-token-scope.md]: token is a client-side
/// session gate only; backend may ignore JWT. No 401 → logout flow yet.
@lazySingleton
class ApiInterceptor extends Interceptor {
  final TokenService _tokenService;
  final RequestTracker _requestTracker;

  ApiInterceptor(
    this._tokenService,
    this._requestTracker,
  );

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenService.getToken();
    options.headers
      ..putIfAbsent('accept', () => '*/*')
      ..putIfAbsent('Content-Type', () => 'application/json');
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    if (_isLog) _logRequest(options);
    _requestTracker.start();
    return super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    _requestTracker.done();
    return super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    _requestTracker.done();
    return super.onError(err, handler);
  }

  void _logRequest(RequestOptions options) {
    final data = options.data;
    final query = options.queryParameters;
    final headers = Map<String, dynamic>.from(options.headers);
    if (headers.containsKey('Authorization')) {
      headers['Authorization'] = 'Bearer ***';
    }

    if (data is FormData) {
      for (final field in data.fields) {
        log('Field: ${field.key}: ${field.value}');
      }
      for (final file in data.files) {
        log('File: ${file.key}: ${file.value.filename}');
      }
    } else if (data != null && data.toString().length > 2) {
      log(jsonEncode(data));
    }

    if (query.isNotEmpty && query.toString().length > 2) {
      log(jsonEncode(query));
    }
    log(jsonEncode(headers));
  }
}

bool get _isLog => kDebugMode;
