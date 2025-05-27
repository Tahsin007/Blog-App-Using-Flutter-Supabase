import 'package:currency_converter/core/theme/app_pallete.dart';
import 'package:currency_converter/core/theme/app_textstyles.dart';
import 'package:currency_converter/features/blog/presentation/widgets/blog_text_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  List<String> selectedTopics = [];
  var topicsList = ['Technology', 'Business', 'Programming', 'Entertainment'];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.done))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  radius: Radius.circular(10),
                  color: AppPallete.white,
                  dashPattern: const [10, 4],
                  strokeCap: StrokeCap.round,
                ),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.folder_open, size: 40),
                      SizedBox(height: 15),
                      Text("Select Your Image", style: AppTextStyle.h2),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      topicsList.map((e) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: GestureDetector(
                            onTap:
                                () => {
                                  if (selectedTopics.contains(e))
                                    {selectedTopics.remove(e)}
                                  else
                                    {selectedTopics.add(e)},
                                  setState(() {}),
                                  print("Selected Topics $selectedTopics"),
                                },
                            child: Chip(
                              label: Text(e),
                              backgroundColor:
                                  selectedTopics.contains(e)
                                      ? AppPallete.primaryColor
                                      : null,
                              side:
                                  selectedTopics.contains(e)
                                      ? null
                                      : BorderSide(color: AppPallete.darkGray),
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
              SizedBox(height: 16),
              BlogTextField(
                controller: titleController,
                hintText: "Blog Title",
              ),
              SizedBox(height: 16),
              BlogTextField(
                controller: descriptionController,
                hintText: "Blog Description",
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
