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

class _ScopeBuilderState<S extends Scope> extends State<ScopeBuilder<S>> {
  S? scope;
  ScopeBuilderFunction<S> builder;
  bool listening = false;

  _ScopeBuilderState(this.builder);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!listening) {
      scope?.dispose();
      scope = this.context.get<S>();
      if (scope != null) {
        scope!.addListener(() {
          setState(() {});
        });
        setState(() {
          this.listening = true;
        });
      }
    }
  }

  @override
  void didUpdateWidget(covariant ScopeBuilder<S> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.builder != widget.builder) {
      setState(() {
        this.builder = this.widget.builder;
        this.listening = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return this.builder(context, scope!);
  }
}
