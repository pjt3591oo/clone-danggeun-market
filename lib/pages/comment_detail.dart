import 'package:carrot_matket/repository/comment_repository.dart';
import 'package:flutter/material.dart';

class CommentDetail extends StatefulWidget {
  MainComment comment;
  
  CommentDetail({Key key, this.comment}) : super(key: key);

  @override
  _CommentDetailState createState() => _CommentDetailState();
}

class _CommentDetailState extends State<CommentDetail> {
  
  Widget _subComment(List<SubComment> subComments) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...subComments.map<Widget>((SubComment comment) =>  Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(radius: 18, backgroundImage: Image.asset("assets/images/user.png").image,),
                SizedBox(width: 14,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(comment.author, style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff262626))),
                    SizedBox(height: 3),
                    Text('${comment.location} ${comment.createdAt}', style: TextStyle( color: Color(0xffA6A6AE))),
                    SizedBox(height: 3),
                    Text(comment.content, style: TextStyle( color: Color(0xff282828))),
                    SizedBox(height: 3),
                    Row(
                      children:[
                        Text('좋아요 ${comment.likeCnt.toString()}', style: TextStyle( color: Color(0xff9C9C9C))),
                        SizedBox(width: 12),
                      ]
                    ),
                    SizedBox(height: 12),
                  ],
                )
              ],
            )
          )
        ).toList(),

      ]
    );
  }

  Widget _bodyWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(radius: 18, backgroundImage: Image.asset("assets/images/user.png").image,),
        SizedBox(width: 14,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.comment.author, style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xff262626))),
            SizedBox(height: 3),
            Text('${widget.comment.location} ${widget.comment.createdAt}', style: TextStyle( color: Color(0xffA6A6AE))),
            SizedBox(height: 3),
            Text(widget.comment.content, style: TextStyle( color: Color(0xff282828))),
            SizedBox(height: 3),
            Row(
              children:[
                Text('좋아요 ${widget.comment.likeCnt.toString()}', style: TextStyle( color: Color(0xff9C9C9C))),
                SizedBox(width: 12),
              ]
            ),

            SizedBox(height: 18),

            _subComment(widget.comment.subComments),
          ],
        )
      ],
    )
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
      appBar: AppBar(
        elevation: 0,
        title: Text('답글쓰기'),
        centerTitle: false,
      ),
      body: _bodyWidget(context),
      bottomNavigationBar: _bottomNavigationBarWidget(MediaQuery.of(context).size),
    );
  }
}