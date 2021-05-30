
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carrot_matket/components/manor_temerature.dart';
import 'package:carrot_matket/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

final MAIN_COLOR = 0xfff08f4f;

class DetailContentView extends StatefulWidget {
  Map<String, dynamic> data;
  DetailContentView({Key key, this.data}) : super(key: key);
  
  @override
  _DetailContentViewState createState() => _DetailContentViewState();
}

class _DetailContentViewState extends State<DetailContentView> with SingleTickerProviderStateMixin{
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Size size;

  List<Map<String, String>> imgList =[];
  int _currentImgSlideIndex = 0;
  double scrollPositionToAlpha = 0;
  ScrollController _controller = ScrollController();
  AnimationController _animationController ;
  Animation _colorTween ;

  bool isMyFavoriteContent = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this);
    _colorTween = ColorTween(begin: Colors.white, end: Colors.black).animate(_animationController);

    _controller.addListener(() {
      _controller.offset;
      setState(() {
        if (_controller.offset <= 0) { 
          scrollPositionToAlpha = 0;  
        } else if (_controller.offset > 0 && _controller.offset <= 255) {
          scrollPositionToAlpha = _controller.offset;
        } else {
          scrollPositionToAlpha = 255;
        }
        _animationController.value = scrollPositionToAlpha / 255;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
    imgList = [
      {"id": "0", "url": widget.data['image']},
      {"id": "1", "url": widget.data['image']},
      {"id": "2", "url": widget.data['image']},
      {"id": "3", "url": widget.data['image']},
      {"id": "4", "url": widget.data['image']},
    ];
  }

  Widget _makeIcon(IconData icon) {
    return AnimatedBuilder(
      animation: _colorTween,
      builder:(context, child) => Icon(icon, color: _colorTween.value)
    );
  }

  Widget _appBarWidget() {
    return AppBar(
      backgroundColor: Colors.white.withAlpha(scrollPositionToAlpha.toInt()),
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        }, 
        icon: _makeIcon(Icons.arrow_back), 
      ),
      actions: [
        IconButton(onPressed: () {}, icon: _makeIcon(Icons.share)),
        IconButton(onPressed: () {}, icon: _makeIcon(Icons.more_vert)),
      ]
    );
  }

  Widget _makeSliderImageWidget() {
    return Container(
      child: Stack(
        children: [
          Hero(
            tag: widget.data['cid'],
            child: CarouselSlider(
              items: imgList.map((imgPath) {
                return Image.asset(
                  widget.data['image'], 
                  width: size.width,
                  fit:BoxFit.fill,
                );
              }).toList(),
              options: CarouselOptions(
                height: size.width,
                initialPage: 0,
                enableInfiniteScroll: false,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentImgSlideIndex = index;
                  });
                }
              ),
            ),
          ),
          Positioned(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.map((url) {
                // int index = url['id'];
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentImgSlideIndex.toString() == url['id']
                      ? Colors.white
                      : Colors.white.withOpacity(0.3),
                  ),
                );
              }).toList(),
            ),
            bottom: 0,
            left: 0,
            right: 0,
          ),
        ],
      ),
    );
  }

  Widget _sellerSimpleInfo() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(50),
          //   child: Container(width: 50, height: 50, child: Image.asset("assets/images/user.png"))
          // )
          CircleAvatar(radius: 25, backgroundImage: Image.asset("assets/images/user.png").image,),
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("멍개", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text("경기도 파주시"),
            ],
          ),
          ManorTemperature(manorTemp: double.parse(widget.data['temporature'])),
        ],
      ),
    );
  }

  Widget _line() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      height: 1, 
      color: Colors.grey.withOpacity(0.3)
    );
  }

  Widget _contentDetail() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20),
          Text(widget.data['title'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          SizedBox(height: 3),
          Text('Categoty 1, 22시간 전', style: TextStyle(color: Colors.grey, fontSize: 12)),
          SizedBox(height: 15),
          Text('선물받은 새상품이고\n삼품 꺼내보기만 했습니다.\n거래는 직거래만 합니다.', style: TextStyle(fontSize: 14)),
          SizedBox(height: 15),
          Text('채팅: 3 관심: 17 조회 295', style: TextStyle(color: Colors.grey, fontSize: 12)),
          SizedBox(height: 15),
        ],
      )
    ) ;
  }
  
  Widget _otherCellContents() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Other Product By 멍개님", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          Text("모두보기", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    )  ;
  }

  Widget _bodyWidget() {
    // return SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       _makeSliderImageWidget(),
    //       _sellerSimpleInfo(),
    //       _line(),
    //       _contentDetail(),
    //       _line(),
    //       _otherCellContents(),
    //     ],
    //   ),
    // );
    return CustomScrollView(
      controller: _controller,
      slivers: [
        SliverList(delegate: SliverChildListDelegate([
           _makeSliderImageWidget(),
          _sellerSimpleInfo(),
          _line(),
          _contentDetail(),
          _line(),
          _otherCellContents(),
        ])),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
            delegate: SliverChildListDelegate(List.generate(20, (index) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    ClipRRect(borderRadius: BorderRadius.circular(10), child: Container(color: Colors.grey, height: 120)),
                    SizedBox(height: 8),
                    Text("상품 제목", style: TextStyle(fontSize: 14)),
                    SizedBox(height: 2),
                    Text("19,000원", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  ]
                )
              );
            }
          )),)
        )
      ],
      
    );
  }

  Widget _bottomNavigationBarWidget() {
    return Container(
      width: size.width,
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isMyFavoriteContent = !isMyFavoriteContent;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(milliseconds: 1000),
                    content: Text(isMyFavoriteContent? "관심목록에 추가되었습니다." : "관심목록에서 제거되었습니다.")
                  ),
                );
              });
            },
            child: SvgPicture.asset(
              isMyFavoriteContent? "assets/svg/heart_on.svg": "assets/svg/heart_off.svg", 
              width: 25, height: 25,
              color: Color(MAIN_COLOR),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 10),
            width: 1, height: 40, color: Colors.grey.withOpacity(0.5)
          ),
          Padding(
            padding: EdgeInsets.only(top: 6),
            child: Column(
              children: [
                Text(calulatorStringToWon(widget.data['price']), style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                Text("가격제안불가", style: TextStyle(fontSize: 14, color: Colors.red.withAlpha(150))),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                  decoration: BoxDecoration( borderRadius: BorderRadius.circular(5), color: Color(MAIN_COLOR)),
                  child: Text("채팅으로 거래하기", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: _appBarWidget(),
      body: _bodyWidget(),
      bottomNavigationBar: _bottomNavigationBarWidget(),
    );
  }
}