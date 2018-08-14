import 'package:flutter/material.dart';
import 'dart:ui';

class SliverLayoutPage extends StatefulWidget {
  @override
  _SliverLayoutPageState createState() => new _SliverLayoutPageState();
}

class _SliverLayoutPageState extends State<SliverLayoutPage> {
  @override
  final double _sliverAppBarHeight = 400.0;
  final double _headerImageHeight = 160.0;
  final double _profileImageHeight = 80.0;

  ScrollController _scrollController;
  double _statusBarHeight = 20.0;  // 20.0
  double _toolbarHeight = 56.0;    // 56.0
  double _headerImageBottomMargin;
  ThemeData _theme;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _headerImageBottomMargin = _sliverAppBarHeight - _headerImageHeight;
  }

  double get _statusAndToolbarHeight { 
    return _statusBarHeight + _toolbarHeight; 
  }

  Widget build(BuildContext context) {
    _statusBarHeight = MediaQuery.of(context).padding.top;
    _theme = Theme.of(context);

    var hibm = _headerImageHeight;
    var scrollableHeight = _sliverAppBarHeight - _statusAndToolbarHeight;

    _scrollController.addListener(() {
      var scrollOffset = _scrollController.offset - _statusBarHeight;
      if (scrollOffset < _statusAndToolbarHeight) {
        hibm = _sliverAppBarHeight - _headerImageHeight;
      } else if (scrollOffset > _statusAndToolbarHeight && scrollOffset <= scrollableHeight){
        hibm = scrollableHeight - scrollOffset;
      } else {
        hibm = 0.0;
      }
      setState(() {
        _headerImageBottomMargin = hibm;
      });
    });

    // ツールバーの高さを計測する
    _toolbarHeight = AppBar(
      title: Text('Demo'),
    ).preferredSize.height;

    return Scaffold(
        // appBar: AppBar(title: Text("hoge"),),
        body: _customScrollView()
    );

  }

  Widget _customScrollView() {
    return new CustomScrollView(
      controller: this._scrollController,
      slivers: [
        _buildSliverAppBar(context),
        _buildSliverList()
      ]
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return new SliverAppBar(
      pinned: true,
      expandedHeight: _sliverAppBarHeight,
      flexibleSpace: new LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return new Stack(
            children: <Widget>[
              Container(color: Colors.orange),
              Container(
                height: _headerImageHeight,
                margin: EdgeInsets.only(bottom: _headerImageBottomMargin),
                child: _blurHeaderImage('assets/neko1_600x400.jpg'),
              ),

              Positioned(
                bottom: _sliverAppBarHeight - _headerImageHeight - (_profileImageHeight / 2),
                height: _profileImageHeight,
                left: 16.0,
                  // Container(
                  //   height: 80.0,
                  //   width: 80.0,
                  //   color: Colors.red,
                  // ),
                child: Container(
                  height: _profileImageHeight,
                  width: _profileImageHeight,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fitWidth,
                      alignment: FractionalOffset.bottomCenter,
                      image: new ExactAssetImage('assets/neko2_400x400.png')
                    )
                  ),
                )
              ),
              Align(
                alignment: new Alignment(0.25, 0.75),
                child: Text("align"),
              ),
            ],
          );
        },
      ),
      title: Text("Sliver Layout"),
    );
  }

  Widget _buildSliverList() {
    return new SliverFixedExtentList(
      itemExtent: 50.0,
      delegate: new SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return new Container(
            alignment: Alignment.center,
            color: Colors.lightBlue[100 * (index % 9)],
            child: new Text('list item $index'),
          );
        },
      ),
    );
  }

  Widget _blurHeaderImage(imageName) {
    return new Container(
      decoration: BoxDecoration(
        image: new DecorationImage(
          fit: BoxFit.fitWidth,
          alignment: FractionalOffset.bottomCenter,
          image: new ExactAssetImage(imageName)
        )
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
        child: Container(
          decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
        ),
      ),
    );
  }
}
