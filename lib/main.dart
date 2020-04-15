import 'package:auto_hide_bottom_bar/scroll_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _scrollController;
  final _bottomBarHeight = 50.0;
  final ScrollProvider _scrollProvider = new ScrollProvider();

  @override
  void initState() {
    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      final currentDirection = _scrollController.position.userScrollDirection;
      if (currentDirection != _scrollProvider.scrollDirection) {
        _scrollProvider.scrollDirection = currentDirection;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _scrollProvider,
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Consumer<ScrollProvider>(
            builder: (_, value, child) {
              return Stack(
                children: <Widget>[
                  Positioned.fill(
//                    bottom: 50,
                    child: ListView.builder(
                      controller: _scrollController,
//                      padding: EdgeInsets.only(
//                          bottom:
//                              value.scrollDirection != ScrollDirection.reverse
//                                  ? _bottomBarHeight
//                                  : 0.0),
                      itemBuilder: (_, index) => ListTile(
                        title: Text('Item $index'),
                      ),
                      itemCount: 50,
                    ),
                  ),
                  AnimatedPositioned(
                      bottom: value.scrollDirection != ScrollDirection.reverse
                          ? 0.0
                          : -_bottomBarHeight,
                      left: 0,
                      right: 0,
                      curve: Curves.easeInOut,
                      duration: Duration(milliseconds: 200),
                      child: Container(
                        height: _bottomBarHeight,
                        color: Colors.red.withOpacity(0.5),
                        child: Center(
                          child: Text('bottom bar'),
                        ),
                      ))
                ],
              );
            },
          )),
    );
  }
}
