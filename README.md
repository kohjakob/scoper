## Scoper

### A minimal state management solution for Flutter.
[Check it out on pub.dev](https://pub.dev/packages/scoper)

---

### How to use:

Create custom `ExampleScope` by extending `Scope`.
Use `notifiyBuilders()` to trigger rebuild of `ScopeBuilder<ExampleScope>`.
Use `notifiyExecutors()` to trigger execution of `ScopeExecutor<ExampleScope>`.

```
class CounterScope extends Scope {
  int _counter = 0;
  int _divider = 7;

  increment() {
    _counter++;
    notifiyBuilders();

    if(_counter % _divider == 0) {
      notifiyExecutors();
    }
  }

  get counter => _counter;
  get divider => _divider;
}
```

Register your scopes by passing them to a `ScopeRegistrant` at the root of the widget-tree.

```
ScopeRegistrant(
    scopes: [
        CounterScope(),
        ExampleScope(),
    ],
    child: Container(
      child: (...)
    ),
)
```

Use a `ScopeBuilder<ExampleScope>` to build widgets depending on the given scope.

```
ScopeBuilder<CounterScope>(
    builder: (context, scope) {
        return Text(scope.counter.toString());
    },
),
```

Use a `ScopeExecutor<ExampleScope>` to execute certain logic depending on the given scope.

```
ScopeExecutor<CounterScope>(
    executor: (context, scope) {
      final message = "This number is divisible by " + scope.divider.toString();
      final snackbar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    },
    child: Container(
      child: (...)
    ),
)
```

Use `get<ExampleScope>` to get a scope from `context` and call it's methods (for example in onPressed).

```
context.get<CounterScope>().increment(),
```

---

Open for contribution and feedback! 😄
