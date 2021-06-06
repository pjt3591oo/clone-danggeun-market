import 'dart:math';

class LocationLifeContentsRepository {
  List<Map<String, String>> datas = [
    {
      "categoty": "우리동네질문",
      "content": "문산에 파주페이 사용가능한 편의점말고 마트가 있을까요?",
      "createdAt": "2021-06-06",
      "author": "멍개",
      "location": "문산",
      "commentCnt": "5",
      "likeCnt": "3",
      "sadCnt": "2",
      "imgPath": "https://lh3.googleusercontent.com/-m9zZm6abxGg/AAAAAAAAAAI/AAAAAAAAAD0/CGF2UYI-EtI/photo.jpg?sz=48",
    }, {
      "categoty": "동네맛집",
      "content": "문산에 파주페이 사용가능한 편의점말고 마트가 있을까요? 문산에 파주페이 사용가능한 편의점말고 마트가 있을까요? 문산에 파주페이 사용가능한 편의점말고 마트가 있을까요?",
      "createdAt": "2021-06-06",
      "author": "멍개",
      "location": "문산",
      "commentCnt": "5",
      "likeCnt": "3",
      "sadCnt": "2",
      "imgPath": "https://lh3.googleusercontent.com/-m9zZm6abxGg/AAAAAAAAAAI/AAAAAAAAAD0/CGF2UYI-EtI/photo.jpg?sz=48",
    }, {
      "categoty": "강아지",
      "content": "문산에 파주페이 사용가능한 편의점말고 마트가 있을까요?",
      "createdAt": "2021-06-06",
      "author": "멍개",
      "location": "문산",
      "commentCnt": "5",
      "likeCnt": "3",
      "sadCnt": "2",
      "imgPath": "https://lh3.googleusercontent.com/-m9zZm6abxGg/AAAAAAAAAAI/AAAAAAAAAD0/CGF2UYI-EtI/photo.jpg?sz=48",
    }, {
      "categoty": "동네맛집",
      "content": "문산에 파주페이 사용가능한 편의점말고 마트가 있을까요?",
      "createdAt": "2021-06-06",
      "author": "멍개",
      "location": "문산",
      "commentCnt": "5",
      "likeCnt": "3",
      "sadCnt": "2",
      "imgPath": "https://lh3.googleusercontent.com/-m9zZm6abxGg/AAAAAAAAAAI/AAAAAAAAAD0/CGF2UYI-EtI/photo.jpg?sz=48",
    }
  ] ;


  Future<List<Map<String, String>>> loadLocationLifeContents() async {
    int min= 500, max = 2000;
    Random random = new Random();
    int responseTime = min + random.nextInt(max - min);

    // await Future.delayed(
    //   Duration(milliseconds: responseTime), 
    // );
    return datas;
  } 
}