import 'package:currency_converter/core/common/widgets/loader.dart';
import 'package:currency_converter/core/theme/app_textstyles.dart';
import 'package:currency_converter/core/utils/calculate_reading_time.dart';
import 'package:currency_converter/features/blog/domain/entities/blog_entity.dart';
import 'package:flutter/material.dart';

class BlogViewerPage extends StatelessWidget {
  final Blog blog;
  const BlogViewerPage({super.key, required this.blog});
  static Route route(Blog blog) =>
      MaterialPageRoute(builder: (context) => BlogViewerPage(blog: blog));

  @override
  Widget build(BuildContext context) {
    final authorName =
        (blog.authorName != null) ? blog.authorName : "Unknown Author";
    return Scaffold(
      appBar: AppBar(title: Text("Blog Viewer", style: AppTextStyle.h2)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 6,
            children: [
              Text(blog.title, style: AppTextStyle.h2),
              Text("By $authorName"),
              Row(
                spacing: 8,
                children: [
                  Text(
                    "${blog.updatedAt.day}/${blog.updatedAt.month}/${blog.updatedAt.year} ${blog.updatedAt.hour.toString().padLeft(2, '0')}:${blog.updatedAt.minute.toString().padLeft(2, '0')}",
                  ),
                  Text("${calculateReadingTime(blog.description)} min"),
                ],
              ),
              SizedBox(height: 10),
              ShowImage(blog: blog),
              SizedBox(height: 10),
              Text(blog.description),
            ],
          ),
        ),
      ),
    );
  }
}

class ShowImage extends StatelessWidget {
  const ShowImage({super.key, required this.blog});

  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        blog.imageUrl,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(
                value:
                    loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image, size: 80);
        },
      ),
    );
  }
}
