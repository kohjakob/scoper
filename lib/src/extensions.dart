import 'package:flutter/widgets.dart';

import '../scoper.dart';

extension ExtendedContext on BuildContext {
  T get<T>() {
    return ScopeRegistrant.get<T>(this);
  }
}
