import 'package:flutter/widgets.dart';
import '../scoper.dart';

typedef ScopeBuilderFunction<S> = Widget Function(
  BuildContext context,
  S scope,
);

class ScopeBuilder<S extends Scope> extends StatefulWidget {
  @override
  _ScopeBuilderState<S> createState() => _ScopeBuilderState<S>(builder);

  final ScopeBuilderFunction<S> builder;

  ScopeBuilder({
    required this.builder,
  });
}

class _ScopeBuilderState<S extends Scope> extends State<ScopeBuilder> {
  late S scope;
  ScopeBuilderFunction<S> builder;
  bool listening = false;

  _ScopeBuilderState(this.builder);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!listening) {
      scope = this.context.get<S>();
      scope.addListener(() {
        setState(() {});
      });
      setState(() {
        listening = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return this.builder(context, scope);
  }
}