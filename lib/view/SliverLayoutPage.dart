import 'package:flutter/material.dart';
import 'dart:ui';

class SliverLayoutPage extends StatefulWidget {
  @override
  _SliverLayoutPageState createState() => new _SliverLayoutPageState();
}

class _SliverLayoutPageState extends State<SliverLayoutPage> {
  @override
  final double _initialSliverAppBarHeight = 400.0;
  final double _initialHeaderImageHeight = 160.0;
  final double _initialProfileImageHeight = 80.0;
  final double _initialProfileImageLeftMargin = 16.0;

  ScrollController _scrollController;
  double _profileImageHeight = 80.0;
  double _headerImageHeight = 160.0;
  double _sliverAppBarHeight = 400.0;
  double _statusBarHeight = 20.0;  // 20.0
  double _toolbarHeight = 56.0;    // 56.0
  double _headerImageBottomMargin;
  double _profileImageLeftMargin = 16.0;
  double _imageBlur = 0.0;
  double _profileImageOpacity = 1.0;
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

    var hibm = _sliverAppBarHeight - _headerImageHeight;
    var scrollableHeight = _sliverAppBarHeight - _statusAndToolbarHeight;

    _scrollController.addListener(() {
      // ヘッダ画像の移動
      var scrollOffset = _scrollController.offset - _statusBarHeight;
      if (_scrollController.offset <= _headerImageHeight - _statusAndToolbarHeight) {
        hibm = _sliverAppBarHeight - _headerImageHeight + _statusBarHeight;
      } else if (_scrollController.offset > _headerImageHeight - _statusAndToolbarHeight && _scrollController.offset <= _sliverAppBarHeight){
        hibm = _sliverAppBarHeight - _scrollController.offset - _toolbarHeight;
      } else { hibm = 0.0; }
      if (hibm < 0.0) { hibm = 0.0;}

      // ヘッダ画像のぼやけ具合
      var blur = 0.0;
      if (scrollOffset <= 0.0) {
        blur = 0.0;
      } else if (scrollOffset <= 100.0) {
        blur = scrollOffset / 10.0;
      } else {
        blur = 10.0;
      }

      // マイナス方向に引っ張った時にヘッダを大きくする
      var biggerValue = 0.0;
      if (_scrollController.offset < 0.0) {
        biggerValue = _scrollController.offset * -1;
        if (biggerValue > _statusBarHeight) {
          blur = (biggerValue - _statusBarHeight) / 10.0;
          if (blur > 10.0) { blur = 10.0; }
        } else {
          blur = 0.0;
        }
      }

      // プロフィール画像の大きさ変更
      var profileImageHeight = _initialProfileImageHeight;
      if (_scrollController.offset > _statusBarHeight) {
        profileImageHeight = _initialProfileImageHeight - _scrollController.offset + _statusBarHeight;
        if (profileImageHeight < 16.0) {
          profileImageHeight = 16.0;
        }
      }
      var profileImageLeftMargin = _initialProfileImageLeftMargin + (_initialProfileImageHeight - profileImageHeight) / 2;

      var profileImageOpacity = 1.0;
      if (profileImageHeight > _initialProfileImageHeight / 2.0) {
        profileImageOpacity = 1.0;
      } else {
        var a = (_initialProfileImageHeight / 2.0) - profileImageHeight;
        if (a == 0.0) { profileImageOpacity = 0.0; }
        else { profileImageOpacity = 1 / a; }
      }
      if (profileImageOpacity < 0.0) { profileImageOpacity = 0.0;}
      if (profileImageOpacity > 1.0) { profileImageOpacity = 1.0;}

      // プロフィール画像のOpacityを変更

      setState(() {
        _sliverAppBarHeight = _initialSliverAppBarHeight + biggerValue;
        _headerImageHeight = _initialHeaderImageHeight + biggerValue;
        _headerImageBottomMargin = hibm;
        _imageBlur = blur;
        _profileImageHeight = profileImageHeight;
        _profileImageLeftMargin = profileImageLeftMargin;
        _profileImageOpacity = profileImageOpacity;
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
              Positioned(
                bottom: 0.0,
                left: 16.0,
                right: 16.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 32.0,
                      child: Text(
                        "Ryo Yamada",
                        style: TextStyle(
                          fontWeight:  FontWeight.bold, fontSize: 24.0, color: Colors.white
                        )
                      ),
                    ),
                    Container(
                      height: 24.0,
                      child: Text(
                        "@Miisan_Is_Neko",
                        style: TextStyle(
                          fontWeight:  FontWeight.normal, fontSize: 16.0, color: Colors.white70
                        )
                      ),
                    ),
                    Container(
                      height: 78.0,
                      child: Text(
                        "iOS app developer.Nya-n driven development. Others:Rails/docker/Angular/IoT/AWS/ML/Alexa/Flutter.",
                        style: TextStyle(
                          fontWeight:  FontWeight.normal, fontSize: 16.0, color: Colors.white
                        )
                      ),
                    ),
                    Container(
                      height: 24.0,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.tag_faces, color: Colors.white,),
                          Text(
                            "誕生日 2018年12月31日",
                            style: TextStyle(
                              fontWeight:  FontWeight.normal, fontSize: 16.0, color: Colors.white70
                            )
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 24.0,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.subject, color: Colors.white,),
                          Text(
                            "2018年4月から利用しています",
                            style: TextStyle(
                              fontWeight:  FontWeight.normal, fontSize: 16.0, color: Colors.white70
                            )
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 36.0,
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 4.0),
                            child: Text(
                              "256",
                              style: TextStyle(
                                fontWeight:  FontWeight.bold, fontSize: 16.0, color: Colors.white
                              )
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 24.0),
                            child: Text(
                              "フォロー中",
                              style: TextStyle(
                                fontWeight:  FontWeight.normal, fontSize: 16.0, color: Colors.white70
                              )
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 4.0),
                            child: Text(
                              "128",
                              style: TextStyle(
                                fontWeight:  FontWeight.bold, fontSize: 16.0, color: Colors.white
                              )
                            ),
                          ),
                          Text(
                            "フォロワー",
                            style: TextStyle(
                              fontWeight:  FontWeight.normal, fontSize: 16.0, color: Colors.white70
                            )
                          ),
                        ],
                      )
                    ),
                  ],
                )
              ),
              Positioned(
                bottom: _sliverAppBarHeight - _headerImageHeight - (_initialProfileImageHeight / 2) + _statusBarHeight,
                height: 32.0,
                right: 16.0,
                child: InkWell(
                  onTap: () => {},
                  child: new Container(
                    height: 30.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      border: Border.all(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(16.0)
                    ),
                    child: Center(
                      child: Text(
                        "変更",
                        style: TextStyle(
                          fontWeight:  FontWeight.normal, fontSize: 14.0, color: Colors.white
                        )
                      )
                    )
                  )
                )
              ),
              Positioned(
                height: _headerImageHeight,
                left: 0.0,
                right: 0.0,
                bottom: _headerImageBottomMargin,
                child: _blurHeaderImage('assets/neko1_600x400.jpg'),
              ),
              Positioned(
                bottom: _sliverAppBarHeight - _headerImageHeight - (_profileImageHeight / 2) + _statusBarHeight,
                height: _profileImageHeight,
                left: _profileImageLeftMargin,
                child: 
                  _buildProfileImage('assets/neko2_400x400.png')
              ),
            ],
            fit: StackFit.expand,
          );
        },
      ),
      title: null,
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

  Widget _buildProfileImage(imageName) {
    return Opacity(
      opacity: _profileImageOpacity,
      child: 
        Container(
          height: _profileImageHeight,
          width: _profileImageHeight,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.orange, width: 4.0),
            shape: BoxShape.circle,
            image: new DecorationImage(
              fit: BoxFit.fitWidth,
              alignment: FractionalOffset.bottomCenter,
              image: new ExactAssetImage(imageName)
            )
          ),
        )
      );
  }

  Widget _blurHeaderImage(imageName) {
    return new Container(
      decoration: BoxDecoration(
        image: new DecorationImage(
          fit: BoxFit.cover,
          alignment: FractionalOffset.bottomCenter,
          image: new ExactAssetImage(imageName)
        )
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: _imageBlur, sigmaY: _imageBlur),
        child: Container(
          decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
        ),
      ),
    );
  }
}
