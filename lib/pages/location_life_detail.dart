import 'package:carrot_matket/repository/comment_repository.dart';
import 'package:carrot_matket/widgets/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LocationLifeDetail extends StatefulWidget {
  Map<String, dynamic> data;

  LocationLifeDetail({Key key, this.data}) : super(key: key);

  @override
  _LocationLifeDetailState createState() => _LocationLifeDetailState();
}

class _LocationLifeDetailState extends State<LocationLifeDetail> {
  ScrollController _controller = ScrollController();
  CommentRepository _commentRepository = CommentRepository();

  Widget _appBar() {
    return AppBar(
      elevation: 1,
      actions: [
        IconButton(
          onPressed: () {
            print('[EVENT] search tap');
          },
          icon: Icon(Icons.notifications_none_outlined)),
        IconButton(
          onPressed: () {
            print('[EVENT] tune tap');
          },
          icon: Icon(Icons.share_outlined)),
        IconButton(
          onPressed: () {
            print('[EVENT] notifications_active tap');
          },
          icon: Icon(Icons.more_vert),
        ),
      ],
    );
  }

  Future<List<MainComment>> _loadContents() async {
    return _commentRepository.loadComments();
  }

  Widget _bodyWidget() {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)  {
        List<MainComment> datas = snapshot.data;
        if (!snapshot.hasData) {
          return Center(
              child: Text(
                  "해당 지역에 데이터가 없습니다."));
        }
        return CustomScrollView(
          controller: _controller,
          slivers: [
            SliverList(delegate: SliverChildListDelegate([
              Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _categoryWidget(),
                    SizedBox(height: 12),
                    _userInfoWidget(),
                    SizedBox(height: 12),
                    SizedBox(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        child: const DecoratedBox(
                          decoration: const BoxDecoration(
                            color: const Color(0xffE0E0E0)
                          ),
                        )),
                    _contentWidget(),
                    SizedBox(height: 5),
                    Text("부적절한 게시글이라면 당근마켓에 알려주세요", style: TextStyle(color: const Color(0xffc0c0c0))),
                    SizedBox(height: 12),
                  ],
                ),
              )
            ])),

            SliverList(delegate: SliverChildListDelegate([
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      child: const DecoratedBox(
                        decoration: const BoxDecoration(
                          color: const Color(0xffE0E0E0)
                        ),
                      )
                    ),
                    SizedBox(height: 12),

                    Container(
                      child: Row(
                        children: [
                          SizedBox(width: 12),
                          Icon(Icons.mood),
                          SizedBox(width: 6),
                          Text("공감하기"),
                          SizedBox(width: 30),
                          Icon(Icons.chat),
                          SizedBox(width: 6),
                          Text(widget.data['commentCnt']),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),

                    SizedBox(
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      child: const DecoratedBox(
                        decoration: const BoxDecoration(
                          color: const Color(0xffE0E0E0)
                        ),
                      )
                    ),
                  ],
                )
              
              )
            ])),
          
            SliverList(
              delegate: SliverChildBuilderDelegate( (context, index) => Container(
                padding: EdgeInsets.all(12),
                child: CommentWidget(comment: datas[index],),
              ), 
              childCount: datas.length
              ),
            ),
            SliverList(delegate: SliverChildListDelegate([
              _bottomNavigationBarWidget(MediaQuery.of(context).size)
            ])),
          ],
        );
      },
      future: _loadContents()
    );
  }

  Widget _categoryWidget() {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        // border: Border.all(color: Color(0xffDCDCDC)),
        borderRadius: BorderRadius.circular(5),
        color: Color(0xffF2f3f6),
      ),
      child: Text(widget.data["categoty"], style: TextStyle(
        fontWeight: FontWeight.w600,
        color: Color(0xff9496a2),
        fontSize: 12,
        // backgroundColor: Color(0xfff2f2f2),
      )),
    );
  }

  Widget _userInfoWidget() {
    return Container(
      child: Row(
        children: [
          CircleAvatar(radius: 18, backgroundImage: Image.asset("assets/images/user.png").image,),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.data['author'], style: TextStyle(fontWeight: FontWeight.w900)),
              Text("${widget.data['author']} ${widget.data['createdAt']}", style: TextStyle(color: Color(0xff9496a2))),
            ],
          )
        ],
      )
    );
  }

  Widget _contentWidget() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Text(widget.data['content']),
    );
  }

  Widget _bottomNavigationBarWidget(Size size) {
    return Container(
      width: size.width,
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Icon(Icons.room_outlined),
          SizedBox(width: 10),
          Icon(Icons.photo_outlined),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              decoration: BoxDecoration(
                color: Color(0xffF2F3F7),
                borderRadius: BorderRadius.circular(36),
                border: Border.all(
                  color: Color(0xffF2F3F7),
                )
              ),
              
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffF2F3F7))
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffF2F3F7))
                  ),
                  enabledBorder: OutlineInputBorder(
                    // borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Color(0xffF2F3F7))
                  ),
                  hintText: "댓글을 입력해주세요.",
                  hintStyle: TextStyle(fontSize: 16,color: Color(0xFFADADAD))
                ),
              )
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _appBar(),
      body: _bodyWidget(),
      // bottomNavigationBar: _bottomNavigationBarWidget(MediaQuery.of(context).size),
    );
  }
}
