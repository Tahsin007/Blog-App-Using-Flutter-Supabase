// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:currency_converter/features/auth/domain/use_case/current_user_usecase.dart';
import 'package:currency_converter/features/blog/domain/entities/blog_entity.dart';
import 'package:currency_converter/features/blog/domain/repository/blog_repository.dart';
import 'package:currency_converter/features/blog/domain/use_case/get_all_blogs_usecase.dart';
import 'package:currency_converter/features/blog/domain/use_case/upload_blog_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUsecase uploadBlogUseCase;
  final GetAllBlogsUsecase getAllBlogsUseCase;

  BlogBloc(this.uploadBlogUseCase, this.getAllBlogsUseCase)
    : super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      emit(BlogLoading());
    });

    on<BlogUploadEvent>(_onBlogUpload);
    on<GetAllBlogsEvent>(_getAllBlogs);
  }

  void _onBlogUpload(BlogUploadEvent event, Emitter<BlogState> state) async {
    final res = await uploadBlogUseCase(event.blogParams);
    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(BlogUploadSuccess()),
    );
  }

  void _getAllBlogs(GetAllBlogsEvent event, Emitter<BlogState> state) async {
    final res = await getAllBlogsUseCase(NoParams());
    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(BlogDisplaySuccess(r)),
    );
  }
}
