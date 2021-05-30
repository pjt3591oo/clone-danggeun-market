import 'package:carrot_matket/pages/detail.dart';
import 'package:carrot_matket/repository/content_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carrot_matket/utils/common.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ContentsRepository _contentsRepository = ContentsRepository();
  String _currentLocation = 'paju';

  final Map<String, String> locationTypeToString = {
    'paju': '파주읍',
    'unjung': '운정동',
    'yadang': '야당동'
  };

  @override
  void initState() {
    super.initState();
  }

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
            1
          ),
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
          onPressed: (){print('[EVENT] search tap');}, 
          icon: Icon(Icons.search)
        ),
        IconButton(
          onPressed: (){print('[EVENT] tune tap');}, 
          icon: Icon(Icons.tune)
        ),
        IconButton(
          onPressed: (){print('[EVENT] notifications_active tap');}, 
          icon: SvgPicture.asset("assets/svg/bell.svg", width: 22),
        ),
      ],
    );
  }

  Future<List<Map<String, String>>> _loadContents() async {
    return _contentsRepository.loadContentsFromLocation(_currentLocation);
  }

  Widget _bodyWidget() {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  
        List<Map<String, String>> datas = snapshot.data;
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("데이터 로딩 중 문제가 발생했습니다"));
        }

        if (!snapshot.hasData) {
          return Center(child: Text("해당 지역(${locationTypeToString[_currentLocation]})에 데이터가 없습니다."));
        }

        return _makeDataItem(datas);
      },
      future: _loadContents(),
    );
  }

  Widget _makeDataItem(List<Map<String, String>> datas) {
    return ListView.separated(
      itemCount: datas.length,
      padding: EdgeInsets.symmetric(horizontal: 12), // 좌(left)/우(right)
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, 
              MaterialPageRoute(builder: (BuildContext context) {
                return DetailContentView(data: datas[index]);
              })
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10), // 위(top)/아래(bottom)
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Hero(
                    tag: datas[index]['cid'],
                    child: Image.asset(datas[index]['image'], width: 100, height: 100)
                  ),
                ),

                Expanded(
                  child: Container(
                    height: 100,
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(datas[index]['title'], style: TextStyle(fontSize: 15, ), overflow: TextOverflow.ellipsis),
                        SizedBox(height: 5),
                        Text(datas[index]['location'], style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.4))),
                        SizedBox(height: 5),
                        Text(calulatorStringToWon(datas[index]['price']), style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                        SizedBox(height: 5),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SvgPicture.asset("assets/svg/heart_off.svg", width: 13, height: 13),
                              SizedBox(width: 5),
                              Text(datas[index]["likes"])
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container( color: Colors.black.withOpacity(0.1), height: 1);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      body: _bodyWidget(),
    );
  }
}