import 'package:carousel_slider/carousel_slider.dart';
import 'package:carrot_matket/repository/location_life_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LocationLife extends StatefulWidget {
  LocationLife({Key key}) : super(key: key);

  @override
  _LocationLifeState createState() => _LocationLifeState();
}

class _LocationLifeState extends State<LocationLife> {
  LocationLifeContentsRepository _contentsRepository =
      LocationLifeContentsRepository();
  ScrollController _controller = ScrollController();

  String _currentLocation = 'paju';

  final Map<String, String> locationTypeToString = {
    'paju': '파주읍',
    'unjung': '운정동',
    'yadang': '야당동'
  };

  Widget _appBarWidget() {
    return AppBar(
      title: GestureDetector(
        child: PopupMenuButton<String>(
          offset: Offset(0, 48),
          onSelected: (String where) {
            setState(() {
              _currentLocation = where;
            });
          },
          shape: ShapeBorder.lerp(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              1),
          initialValue: _currentLocation,
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(value: "paju", child: Text("파주읍")),
              PopupMenuItem(value: "unjung", child: Text("운정동")),
              PopupMenuItem(value: "yadang", child: Text("야당동")),
            ];
          },
          child: Row(
            children: [
              Text(locationTypeToString[_currentLocation]),
              Icon(Icons.arrow_drop_down)
            ],
          ),
        ),
      ),
      elevation: 1,
      actions: [
        IconButton(
            onPressed: () {
              print('[EVENT] search tap');
            },
            icon: Icon(Icons.search)),
        IconButton(
            onPressed: () {
              print('[EVENT] tune tap');
            },
            icon: Icon(Icons.account_box)),
        IconButton(
          onPressed: () {
            print('[EVENT] notifications_active tap');
          },
          icon: SvgPicture.asset("assets/svg/bell.svg", width: 22),
        ),
      ],
    );
  }

  Widget _bodyWidget() {
    return FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          List<Map<String, String>> datas = snapshot.data;

          if (!snapshot.hasData) {
            return Center(
                child: Text(
                    "해당 지역(${locationTypeToString[_currentLocation]})에 데이터가 없습니다."));
          }

          return _makeDataItem(datas);
        },
        future: _loadContents());
  }

  Future<List<Map<String, String>>> _loadContents() async {
    return _contentsRepository.loadLocationLifeContents();
  }

  Widget _listWidget(List<Map<String, dynamic>> datas) {
    return ListView.separated(
        itemCount: datas.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(datas[index]["categoty"],
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Color(0xff949494),
                            fontSize: 14,
                            backgroundColor: Color(0xfff2f2f2),
                          )),
                      SizedBox(height: 6),
                      Text(datas[index]["content"]),
                      SizedBox(height: 12),
                      Image.network(datas[index]['imgPath']),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              '${datas[index]["author"]}/${datas[index]["location"]}',
                              style: TextStyle(color: Color(0xffa7a7a7))),
                          Text('${datas[index]["createdAt"]}',
                              style: TextStyle(color: Color(0xffa7a7a7)))
                        ],
                      ),
                    ]),
              ),
              SizedBox(
                  height: 2,
                  width: MediaQuery.of(context).size.width,
                  child: const DecoratedBox(
                    decoration:
                        const BoxDecoration(color: const Color(0xffE0E0E0)),
                  )),
              Container(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(Icons.check_box_rounded, color: Color(0xffa7a7a7)),
                    Text("궁금해요", style: TextStyle(color: Color(0xffa7a7a7))),
                    SizedBox(width: 12),
                    Icon(Icons.chat_bubble, color: Color(0xffa7a7a7)),
                    Text("댓글: ${datas[index]['commentCnt']}",
                        style:
                            TextStyle(color: Color(0xffa7a7a7), fontSize: 14)),
                  ],
                ),
              )
            ],
          ));
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(color: Colors.black.withOpacity(0.1), height: 10);
        });
  }

  Widget _filterWidget() {
    return Container(
      padding: EdgeInsets.all(10),
      child: CarouselSlider(
        items: [
          "같이해요",
          "우리동네질문",
          "해주세요",
          "동네맛집",
          "동네소식",
          "일상",
          "분실/실종센터",
          "분실/실종센터"
        ].map((text) {
          return Text(text,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xff535353),
                fontSize: 16,
                backgroundColor: Color(0xffffffff),
              ));
        }).toList(),
        options: CarouselOptions(
            height: 30,
            initialPage: 0,
            enableInfiniteScroll: false,
            viewportFraction: 0.3,
            onPageChanged: (index, reason) {
              setState(() {
                // _currentImgSlideIndex = index;
              });
            }),
      ),
    );
  }

  Widget _makeDataItem(List<Map<String, String>> datas) {
    return CustomScrollView(
      controller: _controller,
      slivers: [
        SliverList(
            delegate: SliverChildListDelegate([
          _filterWidget(),
        ])),
        SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(datas[index]["categoty"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xff949494),
                                    fontSize: 14,
                                    backgroundColor: Color(0xfff2f2f2),
                                  )),
                              SizedBox(height: 6),
                              Text(datas[index]["content"]),
                              SizedBox(height: 12),
                              Image.network(datas[index]['imgPath']),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      '${datas[index]["author"]}/${datas[index]["location"]}',
                                      style:
                                          TextStyle(color: Color(0xffa7a7a7))),
                                  Text('${datas[index]["createdAt"]}',
                                      style:
                                          TextStyle(color: Color(0xffa7a7a7)))
                                ],
                              ),
                            ]),
                      ),
                      SizedBox(
                          height: 2,
                          width: MediaQuery.of(context).size.width,
                          child: const DecoratedBox(
                            decoration: const BoxDecoration(
                                color: const Color(0xffE0E0E0)),
                          )),
                      Container(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Icon(Icons.check_box_rounded,
                                color: Color(0xffa7a7a7)),
                            Text("궁금해요",
                                style: TextStyle(color: Color(0xffa7a7a7))),
                            SizedBox(width: 12),
                            Icon(Icons.chat_bubble, color: Color(0xffa7a7a7)),
                            Text("댓글: ${datas[index]['commentCnt']}",
                                style: TextStyle(
                                    color: Color(0xffa7a7a7), fontSize: 14)),
                          ],
                        ),
                      )
                    ],
                  )),
              childCount: datas.length),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBarWidget(), body: _bodyWidget());
  }
}
