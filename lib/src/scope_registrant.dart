import 'package:flutter/widgets.dart';
import '../scoper.dart';

class ScopeRegistrant extends InheritedWidget {
  final Map<Type, Scope> map = {};

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  ScopeRegistrant({
    required Widget child,
    List<Scope>? scopes,
    Key? key,
  }) : super(child: child, key: key) {
    scopes?.forEach((Scope scope) {
      map[scope.runtimeType] = scope;
    });
  }

  static ScopeRegistrant? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ScopeRegistrant>();

  static T get<T>(BuildContext context) {
    ScopeRegistrant? registrant = of(context);
    if (registrant != null) {
      dynamic instance = registrant.map[T];
      if (instance != null && instance != Null) {
        return instance as T;
      } else {
        throw Exception(
            "The Scope S you are trying to build with ScopeBuilder<S>() isn't registered with the ScopeRegistrant.");
      }
    } else {
      throw Exception(
          "There is no ScopeRegistrant above your ScopeBuilder<S> in the widget tree");
    }
  }
}
