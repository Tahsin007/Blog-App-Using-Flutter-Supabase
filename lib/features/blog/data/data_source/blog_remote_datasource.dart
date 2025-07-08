import 'dart:io';

import 'package:currency_converter/core/error/exceptions.dart';
import 'package:currency_converter/features/blog/data/model/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadImage(File image, BlogModel blog);
  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDatasourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;
  BlogRemoteDatasourceImpl(this.supabaseClient);

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData =
          await supabaseClient.from('blogs').insert(blog.toJson()).select();

      return BlogModel.fromJson(blogData.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadImage(File image, BlogModel blog) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(blog.id, image);
      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<List<BlogModel>> getAllBlogs() async{
    try {
      final response = await supabaseClient.from('blogs').select('*,profiles(name)');
      return response.map((blog) => BlogModel.fromJson(blog).copyWith(
        authorName: blog['profiles']?['name'] as String?,
      )).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
