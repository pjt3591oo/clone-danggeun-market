
import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';

class DetailContentView extends StatefulWidget {
  Map<String, dynamic> data;
  DetailContentView({Key key, this.data}) : super(key: key);
  
  @override
  _DetailContentViewState createState() => _DetailContentViewState();
}


class _DetailContentViewState extends State<DetailContentView> {
  Size size;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  Widget _appBarWidget() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.share)),
        IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
      ]
    );
  }

  Widget _bodyWidget() {
    return Container(
      child: Hero(
        tag: widget.data['cid'],
        child: Image.asset(
          widget.data['image'], 
          width: size.width,
          fit:BoxFit.fill
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appBarWidget(),
      body: _bodyWidget(),
    );
  }
}