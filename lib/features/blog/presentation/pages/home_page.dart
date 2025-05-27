import 'package:currency_converter/core/common/entities/user_entity.dart';
import 'package:currency_converter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:currency_converter/features/auth/presentation/pages/sign_in_page.dart';
import 'package:currency_converter/features/blog/presentation/pages/add_new_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage(this.user, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Blog Home Page")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_box_rounded),
        onPressed: () => {
          Navigator.push(context, AddNewBlogPage.route())

        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome Back! ${widget.user.name}"),
            Text("User Email : ${widget.user.email}"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthSignOut());
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInPage()),
                );
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
