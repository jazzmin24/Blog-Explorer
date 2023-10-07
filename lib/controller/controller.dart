import 'package:get/get.dart';

import '../models/post.dart';

class PostController extends GetxController {
  RxList<Blog> blogs = <Blog>[].obs;

  void makemyfavorite(Blog blog) {
    final index = blogs.indexOf(blog);
    if (index != -1) {
      blogs[index].isFavorite.value = !blogs[index].isFavorite.value;
    }
  }

  List<Blog> getFavoriteBlogs() {
    return blogs.where((blog) => blog.isFavorite.value).toList();
  }
}
//hence the controller for get is ready