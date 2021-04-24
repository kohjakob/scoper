import 'package:flutter/material.dart';
import 'package:scoper/scoper.dart';

void main() {
  runApp(MyApp());
}

class CounterScope extends Scope {
  int _counter = 0;
  int _divider = 7;

  increment() {
    _counter++;
    notifyBuilders();

    if (_counter % _divider == 0) {
      notifyExecutors();
    }
  }

  get counter => _counter;
  get divider => _divider;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopeRegistrant(
      scopes: [
        CounterScope(),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage('Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(this.title);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ScopeExecutor<CounterScope>(
        executor: (context, scope) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "This number is divisible by " + scope.divider.toString(),
              ),
              duration: Duration(milliseconds: 510),
            ),
          );
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              ScopeBuilder<CounterScope>(
                builder: (context, scope) {
                  return Text(
                    scope.counter.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.get<CounterScope>().increment(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
