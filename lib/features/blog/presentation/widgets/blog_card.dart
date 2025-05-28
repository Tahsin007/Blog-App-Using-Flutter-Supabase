import 'package:currency_converter/core/theme/app_textstyles.dart';
import 'package:currency_converter/core/utils/calculate_reading_time.dart';
import 'package:currency_converter/features/blog/domain/entities/blog_entity.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  const AppCard({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  spacing: 5.0,
                  children:
                      blog.topics.map((e) => Chip(label: Text(e))).toList(),
                ),
              ),
              SizedBox(height: 6),
              Text(blog.title, style: AppTextStyle.h2.copyWith(fontSize: 20)),
            ],
          ),

          SizedBox(height: 56),
          Text("${calculateReadingTime(blog.description)} min"),
        ],
      ),
    );
  }
}
