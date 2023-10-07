import 'package:blog_explorer/models/post.dart';
import 'package:hive/hive.dart';

class PostAdapter extends TypeAdapter<Post> {
  @override
  final int typeId = 0; 

  @override
  Post read(BinaryReader reader) {
    final id = reader.readString();
    final imageUrl = reader.readString();
    final title = reader.readString();

    return Post(
      blogs: [Blog(id: id, imageUrl: imageUrl, title: title)],
    );
  }

  @override
  void write(BinaryWriter writer, Post obj) {
    final blog = obj.blogs[0]; 
    writer.writeString(blog.id);
    writer.writeString(blog.imageUrl);
    writer.writeString(blog.title);
  }
}
