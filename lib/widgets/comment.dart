import 'package:carrot_matket/repository/comment_repository.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatefulWidget {
  MainComment comment;

  CommentWidget({Key key, this.comment}) : super(key: key);

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<CommentWidget> {
  
  Widget _subComment(List<SubComment> subComments) {
    int cnt = subComments.length;

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

        Row(
          children: [
            CircleAvatar(radius: 18, backgroundImage: Image.asset("assets/images/user.png",).image,),
            SizedBox(width: 14),
            Container(
              width: MediaQuery.of(context).size.width - 125 ,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Color(0xffF2f3f6),
                  width: 2,
                )
              ),
              
              child: Text("답글을 입력해 주세요.", style: TextStyle(color: Color(0x66000000))),
            )
          ],
        ),
        // Expanded( child: Text("test"))
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
                Text('답글쓰기', style: TextStyle( color: Color(0xff9C9C9C)))
              ]
            ),

            SizedBox(height: 18),

            _subComment(widget.comment.subComments),
          ],
        )
      ],
    );
  }

}