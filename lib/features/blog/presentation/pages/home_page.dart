import 'package:currency_converter/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:currency_converter/core/common/widgets/loader.dart';
import 'package:currency_converter/core/theme/app_pallete.dart';
import 'package:currency_converter/core/utils/snack_bar.dart';
import 'package:currency_converter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:currency_converter/features/auth/presentation/pages/sign_in_page.dart';
import 'package:currency_converter/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:currency_converter/features/blog/presentation/pages/add_new_blog.dart';
import 'package:currency_converter/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static route() => MaterialPageRoute(builder: (context) => HomePage());
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(GetAllBlogsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog Home Page"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(AuthSignOut());
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SignInPage()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle_outline),
        onPressed: () => Navigator.push(context, AddNewBlogPage.route()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(message: state.error, context: context);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const AppLoader();
          } else if (state is BlogDisplaySuccess) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return AppCard(blog: blog, color: AppPallete.primaryColor);
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
