import 'dart:io';

import 'package:currency_converter/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:currency_converter/core/common/widgets/loader.dart';
import 'package:currency_converter/core/theme/app_pallete.dart';
import 'package:currency_converter/core/theme/app_textstyles.dart';
import 'package:currency_converter/core/utils/pick_image.dart';
import 'package:currency_converter/core/utils/snack_bar.dart';
import 'package:currency_converter/features/blog/domain/repository/blog_repository.dart';
import 'package:currency_converter/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:currency_converter/features/blog/presentation/pages/home_page.dart';
import 'package:currency_converter/features/blog/presentation/widgets/blog_text_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final formKey = GlobalKey<FormState>();
  File? image;

  void selectImage() async {
    final selectedImage = await pickImage();
    if (selectedImage != null) {
      setState(() {
        image = selectedImage;
        print("Selected Image: ${image!.path}");
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  void uploadBlog() {
    if (image == null) {
      showSnackBar(
        message: "Please select an image for your blog",
        context: context,
      );
      return;
    }
    if (formKey.currentState!.validate() &&
        selectedTopics.isNotEmpty &&
        image != null) {
      final loggedInUser =
          context.read<AppUserCubit>().state as AppUserLoggedIn;
      final authorId = loggedInUser.user.id;
      context.read<BlogBloc>().add(
        BlogUploadEvent(
          BlogParams(
            image: image!,
            authorId: authorId,
            description: descriptionController.text.trim(),
            title: titleController.text.trim(),
            topics: selectedTopics,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              print("Icon Button is pressed");
              uploadBlog();
            },
            icon: Icon(Icons.done),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogLoading) {
            AppLoader();
          } else if (state is BlogFailure) {
            showSnackBar(message: state.error, context: context);
          } else if (state is BlogUploadSuccess) {
            showSnackBar(
              message: "Blog Created Successfully",
              context: context,
            );
            Navigator.pushAndRemoveUntil(
              context,
              HomePage.route(),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    image != null
                        ? SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: () {
                              selectImage();
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(image!, fit: BoxFit.cover),
                            ),
                          ),
                        )
                        : GestureDetector(
                          onTap: () => {selectImage()},
                          child: DottedBorder(
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
                                  Text(
                                    "Select Your Image",
                                    style: AppTextStyle.h2,
                                  ),
                                ],
                              ),
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
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4.0,
                                ),
                                child: GestureDetector(
                                  onTap:
                                      () => {
                                        if (selectedTopics.contains(e))
                                          {selectedTopics.remove(e)}
                                        else
                                          {selectedTopics.add(e)},
                                        setState(() {}),
                                        print(
                                          "Selected Topics $selectedTopics",
                                        ),
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
                                            : BorderSide(
                                              color: AppPallete.darkGray,
                                            ),
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
        },
      ),
    );
  }
}
