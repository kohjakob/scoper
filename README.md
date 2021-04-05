## Scoper

### A minimal state management solution for Flutter.

---

### How to use:

Create scope class by extending `Scope`.
Use `update()` to trigger a rebuild of `ScopeBuilder<ExampleScope>`.

```
class CounterScope extends Scope {
  int _counter = 0;

  increment() {
    _counter++;
    update();
  }

  get counter => _counter;
}
```

Register scope-instances by passing them to a `ScopeRegistrant` at the root of the widget-tree.

```
ScopeRegistrant(
    scopes: [
        CounterScope(),
        ExampleScope(),
    ],
    child: Container(),
)
```

Use a `ScopeBuilder<ExampleScope>` to build widgets depending on a given scope.

```
ScopeBuilder<CounterScope>(
    builder: (context, scope) {
        return Text(scope.counter.toString());
    },
),
```

Use `get<ExampleScope>` to get a scope from `context` and call it's methods (for example in onPressed).

```
context.get<CounterScope>().increment(),
```

---

Open for contribution and feedback! 😄
