import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../di/di.dart';
import 'logs/logs_state.dart';
import 'settings/settings_state.dart';
import 'snack_messages/snack_messages_state.dart';

abstract class Providers {
  static List<SingleChildWidget> get providers {
    return [
      ChangeNotifierProvider<SettingsState>(create: (_) => locator()..init()),
      ChangeNotifierProvider<SnackMessagesState>(create: (_) => locator()),
      ChangeNotifierProvider<LogsState>(create: (_) => LogsState.instance),
    ];
  }
}
