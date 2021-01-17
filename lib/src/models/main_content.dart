class MainContent {
  //此处定义的数据属性与后端接口的定义和以及数据端的定义保持一致
  int id;
  String title;
  String content;
  String link;

  //定义fromjson命名函数解析接收到的map对象
  MainContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    link = json['link'];
  }
}

class MainContentResponse {
  List<MainContent> result = [];
  MainContentResponse.fromJson(List<dynamic> jsonResponse) {
    jsonResponse.forEach((element) {
      result.add(MainContent.fromJson(element));
    });
    //上面的代码也相当于：
    // for (int i; i < jsonResponse.length; i++) {
    //   var element = MainContent.fromJson(jsonResponse[i]);
    //   result.add(element);
    // }
  }
}
