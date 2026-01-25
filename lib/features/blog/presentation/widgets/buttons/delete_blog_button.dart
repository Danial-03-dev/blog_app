import 'package:blog_app/core/common/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/presentation/blocs/blog_bloc/blog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteBlogButton extends StatefulWidget {
  final Blog blog;

  const DeleteBlogButton({super.key, required this.blog});

  @override
  State<DeleteBlogButton> createState() => _DeleteBlogButtonState();
}

class _DeleteBlogButtonState extends State<DeleteBlogButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final user =
        (context.read<AppUserCubit>().state as AppUserLoggedInState).user;

    final blog = widget.blog;
    final isUsersBlog = user.id == blog.posterId;

    void handleBlogDelete() {
      setState(() {
        loading = true;
      });

      context.read<BlogBloc>().add(BlogDeleteEvent(blogId: blog.id));
    }

    if (!isUsersBlog) return const SizedBox();

    return BlocConsumer<BlogBloc, BlogState>(
      listener: (context, state) {
        if (state is BlogFailureState && loading == true) {
          showSnackbar(context: context, text: state.message);
        }

        setState(() {
          loading = false;
        });
      },
      builder: (context, state) {
        return IconButton(
          onPressed: loading ? null : handleBlogDelete,
          icon: loading
              ? Loader(size: 16)
              : Icon(Icons.delete, color: AppPallete.errorColor),
        );
      },
    );
  }
}
