import 'package:flutter/foundation.dart';

abstract class Scope extends ChangeNotifier {
  update() => this.notifyListeners();
}
