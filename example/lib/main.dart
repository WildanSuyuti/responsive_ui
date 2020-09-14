import 'package:example/counter_service.dart';
import 'package:example/responsive_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
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
                  bodyText1: TextStyle(fontSize: responsive.fontSubtitle),
                  bodyText2: TextStyle(fontSize: responsive.fontNormal),
                  subtitle1: TextStyle(fontSize: responsive.fontSubtitle),
                  subtitle2: TextStyle(fontSize: responsive.fontNormal),
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
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<CounterService>(
        create: (BuildContext context) => CounterService(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(title: Text(widget.title)),
          body: Center(
            child: Consumer<CounterService>(
              builder: (_, value, __) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'You have pushed the button this many times',
                    style: _style(value.counter),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: responsive.size(8)),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _button(() => value.counter -= 1, text: "-"),
                          Text('${value.counter.toInt()}', style: _style(18)),
                          _button(() => value.counter += 1),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _button(VoidCallback onTap, {String text = "+"}) => FlatButton(
      onPressed: onTap,
      child: Padding(
        padding: EdgeInsets.all(responsive.size(16)),
        child: Text(
          text,
          style: TextStyle(fontSize: responsive.fontTitle),
        ),
      ));

  TextStyle _style(double size) => TextStyle(fontSize: responsive.size(size));
}
