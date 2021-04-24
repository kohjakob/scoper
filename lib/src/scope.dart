import 'package:flutter/foundation.dart';

abstract class Scope extends ChangeNotifier {
  final ChangeNotifier builderNotifier = ChangeNotifier();
  final ChangeNotifier executorNotifier = ChangeNotifier();

  notifyBuilders() => this.builderNotifier.notifyListeners();
  notifyExecutors() => this.executorNotifier.notifyListeners();
}
