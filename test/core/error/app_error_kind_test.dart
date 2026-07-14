import 'package:flutter_base_kit/flutter_base_kit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:init/core/error/app_error_kind.dart';

void main() {
  group('appErrorKindFrom', () {
    test('maps internet ApiException to network', () {
      expect(
        appErrorKindFrom(
          ApiException(
            message: 'Internet Connection Error',
            errors: 'Internet Connection Error',
          ),
        ),
        AppErrorKind.network,
      );
    });

    test('maps server ApiException to server', () {
      expect(
        appErrorKindFrom(
          ApiException(
            message: 'Server error occurred',
            errors: 'Server error occurred',
          ),
        ),
        AppErrorKind.server,
      );
    });

    test('maps generic exception to unknown', () {
      expect(
        appErrorKindFrom(Exception('fail')),
        AppErrorKind.unknown,
      );
    });
  });
}