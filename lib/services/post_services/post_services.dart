import 'package:petapp_mobile/models/post_model/post_model.dart';

class PostService {
  static PostModel getPost(Map<String, dynamic> jsonData) =>
      PostModel.fromJson(jsonData);

  static List<PostModel> getPostList(Map<String, dynamic> jsonData) {
    final postListJson = jsonData['post'] as List;
    final List<PostModel> postList = List.empty(growable: true);
    for (var element in postListJson) {
      postList.add(getPost(element));
    }
    return postList;
  }
}