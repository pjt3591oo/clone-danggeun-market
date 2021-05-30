import 'dart:math';

class ContentsRepository {
  Map<String, dynamic> datas = {
    'paju': [{
        "cid": "1",
        "image": "assets/images/paju-1.jpg",
        "title": "네메시스 축구화275",
        "location": "경기도 파주시 파주읍",
        "price": "30000",
        "likes": "2"
      }, {
        "cid": "2",
        "image": "assets/images/paju-2.jpg",
        "title": "LA갈비 5kg팔아요~",
        "location": "경기도 파주시 파주읍",
        "price": "100000",
        "likes": "5"
      }, {
        "cid": "3",
        "image": "assets/images/paju-3.jpg",
        "title": "치약팝니다",
        "location": "경기도 파주시 파주읍",
        "price": "5000",
        "likes": "0"
      }, {
        "cid": "4",
        "image": "assets/images/paju-4.jpg",
        "title": "[풀박스]맥북프로16인치 터치바 스페이스그레이",
        "location": "경기도 파주시 파주읍",
        "price": "2500000",
        "likes": "6"
      }, {
        "cid": "5",
        "image": "assets/images/paju-5.jpg",
        "title": "디월트존기임팩",
        "location": "경기도 파주시 파주읍",
        "price": "150000",
        "likes": "2"
      }, {
        "cid": "6",
        "image": "assets/images/paju-6.jpg",
        "title": "갤럭시s10",
        "location": "경기도 파주시 파주읍",
        "price": "180000",
        "likes": "2"
      }, {
        "cid": "7",
        "image": "assets/images/paju-7.jpg",
        "title": "선반",
        "location": "경기도 파주시 파주읍",
        "price": "15000",
        "likes": "2"
      }, {
        "cid": "8",
        "image": "assets/images/paju-8.jpg",
        "title": "냉장 쇼케이스",
        "location": "경기도 파주시 파주읍",
        "price": "80000",
        "likes": "3"
      }, {
        "cid": "9",
        "image": "assets/images/paju-9.jpg",
        "title": "대우 미니냉장고",
        "location": "경기도 파주시 파주읍",
        "price": "30000",
        "likes": "3"
      },  {
        "cid": "10",
        "image": "assets/images/paju-10.jpg",
        "title": "멜킨스 풀업 턱걸이 판매합니다.",
        "location": "경기도 파주시 파주읍",
        "price": "50000",
        "likes": "7"
      }],
      'unjung': [{
        "cid": "1",
        "image": "assets/images/unjung-1.jpg",
        "title": "네메시스 축구화275",
        "location": "경기도 파주시 파주읍",
        "price": "무료나눔",
        "likes": "2"
      }, {
        "cid": "2",
        "image": "assets/images/unjung-2.jpg",
        "title": "LA갈비 5kg팔아요~",
        "location": "경기도 파주시 파주읍",
        "price": "100000",
        "likes": "5"
      }, {
        "cid": "3",
        "image": "assets/images/unjung-3.jpg",
        "title": "치약팝니다",
        "location": "경기도 파주시 파주읍",
        "price": "5000",
        "likes": "0"
      }, {
        "cid": "4",
        "image": "assets/images/unjung-4.jpg",
        "title": "[풀박스]맥북프로16인치 터치바 스페이스그레이",
        "location": "경기도 파주시 파주읍",
        "price": "2500000",
        "likes": "6"
      }, {
        "cid": "5",
        "image": "assets/images/unjung-5.jpg",
        "title": "디월트존기임팩",
        "location": "경기도 파주시 파주읍",
        "price": "150000",
        "likes": "2"
      }, {
        "cid": "6",
        "image": "assets/images/unjung-6.jpg",
        "title": "갤럭시s10",
        "location": "경기도 파주시 파주읍",
        "price": "180000",
        "likes": "2"
      }, {
        "cid": "7",
        "image": "assets/images/unjung-7.jpg",
        "title": "선반",
        "location": "경기도 파주시 파주읍",
        "price": "15000",
        "likes": "2"
      }, {
        "cid": "8",
        "image": "assets/images/unjung-8.jpg",
        "title": "냉장 쇼케이스",
        "location": "경기도 파주시 파주읍",
        "price": "80000",
        "likes": "3"
      }, {
        "cid": "9",
        "image": "assets/images/unjung-9.jpg",
        "title": "대우 미니냉장고",
        "location": "경기도 파주시 파주읍",
        "price": "30000",
        "likes": "3"
      },  {
        "cid": "10",
        "image": "assets/images/unjung-10.jpg",
        "title": "멜킨스 풀업 턱걸이 판매합니다.",
        "location": "경기도 파주시 파주읍",
        "price": "50000",
        "likes": "7"
      }],
    } ;


  Future<List<Map<String, String>>> loadContentsFromLocation(String location) async {
    int min= 500, max = 2000;
    Random random = new Random();
    int responseTime = min + random.nextInt(max - min);

    await Future.delayed(
      Duration(milliseconds: responseTime), 
    );
    return datas[location];
  } 
}