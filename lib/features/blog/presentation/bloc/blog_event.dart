part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogUploadEvent extends BlogEvent {
  final BlogParams blogParams;
  BlogUploadEvent(this.blogParams);
}

final class GetAllBlogsEvent extends BlogEvent{
}
