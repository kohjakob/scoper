import 'package:flutter/widgets.dart';
import '../scoper.dart';

typedef ScopeExecutorFunction<S> = void Function(
  BuildContext context,
  S scope,
);

class ScopeExecutor<S extends Scope> extends StatefulWidget {
  @override
  _ScopeExecutorState<S> createState() =>
      _ScopeExecutorState<S>(executor, child);

  final ScopeExecutorFunction<S> executor;
  final Widget child;

  ScopeExecutor({
    required this.executor,
    required this.child,
  });
}

class _ScopeExecutorState<S extends Scope> extends State<ScopeExecutor<S>> {
  late S scope;
  ScopeExecutorFunction<S> executor;
  Widget child;
  bool listening = false;

  _ScopeExecutorState(this.executor, this.child);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!listening) {
      final scope = this.context.get<S>();
      scope.executorNotifier.addListener(() {
        this.executor.call(context, scope);
      });
      setState(() {
        this.listening = true;
        this.scope = scope;
      });
    }
  }

  @override
  void didUpdateWidget(covariant ScopeExecutor<S> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.executor != widget.executor) {
      setState(() {
        this.executor = this.widget.executor;
        this.listening = false;
        this.child = this.widget.child;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return this.child;
  }
}
