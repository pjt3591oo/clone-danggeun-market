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
      "imgPath": "https://dnvefa72aowie.cloudfront.net/origin/article/202106/9cfb351f824ad1f2368d8a1a870030c6d44ef379cb1c910e05db942dd4677fc9.webp?q=95&s=1440x1440&t=inside",
    }, {
      "categoty": "동네맛집",
      "content": "문산에 파주페이 사용가능한 편의점말고 마트가 있을까요? 문산에 파주페이 사용가능한 편의점말고 마트가 있을까요? 문산에 파주페이 사용가능한 편의점말고 마트가 있을까요?",
      "createdAt": "2021-06-06",
      "author": "멍개",
      "location": "문산",
      "commentCnt": "5",
      "likeCnt": "3",
      "sadCnt": "2",
      "imgPath": "https://dnvefa72aowie.cloudfront.net/origin/article/202106/9cfb351f824ad1f2368d8a1a870030c6d44ef379cb1c910e05db942dd4677fc9.webp?q=95&s=1440x1440&t=inside",
    }, {
      "categoty": "강아지",
      "content": "문산에 파주페이 사용가능한 편의점말고 마트가 있을까요?",
      "createdAt": "2021-06-06",
      "author": "멍개",
      "location": "문산",
      "commentCnt": "5",
      "likeCnt": "3",
      "sadCnt": "2",
      "imgPath": "https://dnvefa72aowie.cloudfront.net/origin/article/202106/9cfb351f824ad1f2368d8a1a870030c6d44ef379cb1c910e05db942dd4677fc9.webp?q=95&s=1440x1440&t=inside",
    }, {
      "categoty": "동네맛집",
      "content": "문산에 파주페이 사용가능한 편의점말고 마트가 있을까요?",
      "createdAt": "2021-06-06",
      "author": "멍개",
      "location": "문산",
      "commentCnt": "5",
      "likeCnt": "3",
      "sadCnt": "2",
      "imgPath": "https://dnvefa72aowie.cloudfront.net/origin/article/202106/9cfb351f824ad1f2368d8a1a870030c6d44ef379cb1c910e05db942dd4677fc9.webp?q=95&s=1440x1440&t=inside",
    }
  ] ;


  Future<List<Map<String, String>>> loadLocationLifeContents() async {
    int min= 500, max = 2000;
    Random random = new Random();
    int responseTime = min + random.nextInt(max - min);

    await Future.delayed(
      Duration(milliseconds: responseTime), 
    );
    return datas;
  } 
}