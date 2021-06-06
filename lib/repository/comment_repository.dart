class SubComment {
  String location;
  String createdAt;
  int likeCnt;
  String author;
  String content;

  SubComment(this.location, this.createdAt, this.likeCnt, this.author, this.content);

  showData() {
    print('$location, $createdAt, $likeCnt, $author, $content');
  }
}

class MainComment {
  String location;
  String createdAt;
  int likeCnt;
  String author;
  String content;

  List<SubComment> subComments;

  MainComment(this.location, this.createdAt, this.likeCnt, this.author, this.content, this.subComments);

  showData() {
    print('$location, $createdAt, $likeCnt, $author, ${subComments.length}');
  }
}

class CommentRepository {
  List<MainComment> datas = [
    MainComment("문산읍", "2020-06-06", 10, "멍개1", "더워1!!",[
      SubComment("문산읍", "2020-06-06", 10, "멍개2", "아오 더워라1-1!!!!"),
      SubComment("문산읍", "2020-06-06", 10, "멍개3", "아오 더워라1-2!!!!"),
      SubComment("문산읍", "2020-06-06", 10, "멍개4", "아오 더워라1-3!!!!"),
    ]),
    MainComment("문산읍", "2020-06-06", 7, "멍개1-1", "더워2!!", [
      SubComment("문산읍", "2020-06-06", 10, "멍개2-1", "아오 더워라2-1!!!!"),
      SubComment("문산읍", "2020-06-06", 10, "멍개3-1", "아오 더워라2-2!!!!"),
      SubComment("문산읍", "2020-06-06", 10, "멍개4-1", "아오 더워라2-3!!!!"),
      SubComment("문산읍", "2020-06-06", 10, "멍개6-1", "아오 더워라2-4!!!!"),
    ]),
  ];

  Future<List<MainComment>> loadComments() async {
    return datas;
  } 

  Future<MainComment> loadCommentByIndex(int index) async {
    return datas[index];
  }
}