import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:responsive_ui/screen_percentage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            ResponsiveUI.init(constraints, orientation)
                .percentage(ScreenPercentage(phoneSmall: 0.2));
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                textTheme: TextTheme(
                  bodyText1:
                      TextStyle(fontSize: ResponsiveUI.instance.size(16)),
                  bodyText2:
                      TextStyle(fontSize: ResponsiveUI.instance.size(14)),
                  subtitle1:
                      TextStyle(fontSize: ResponsiveUI.instance.size(16)),
                  subtitle2:
                      TextStyle(fontSize: ResponsiveUI.instance.size(14)),
                ),
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: MyHomePage(title: 'Flutter Demo Home Page'),
            );
          },
        ),
      );
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() => setState(() => _counter++);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
