import 'package:flutter_base_kit/flutter_base_kit.dart';

import '../../l10n/generated/app_localizations.dart';

enum AppErrorKind {
  network,
  server,
  unknown,
}

AppErrorKind appErrorKindFrom(Object error) {
  if (error is ApiException) {
    if (error.message == 'Internet Connection Error') {
      return AppErrorKind.network;
    }
    if (error.message == 'Server error occurred') {
      return AppErrorKind.server;
    }
  }

  return AppErrorKind.unknown;
}

extension AppErrorKindL10n on AppErrorKind {
  String localizedMessage(AppLocalizations strings) {
    return switch (this) {
      AppErrorKind.network => strings.errorNetwork,
      AppErrorKind.server => strings.errorServer,
      AppErrorKind.unknown => strings.errorUnknown,
    };
  }
}