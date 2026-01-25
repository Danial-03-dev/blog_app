import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/blog/presentation/blocs/blog_bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/widgets/cards/blog_card.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogsList extends StatelessWidget {
  const BlogsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlogBloc, BlogState>(
      listener: (context, state) {
        if (state is BlogFailureState) {
          showSnackbar(context: context, text: state.message);
        }
      },
      builder: (context, state) {
        if (state is BlogLoadingState) {
          return Loader();
        }

        if (state is BlogGetAllBlogsSuccessState) {
          final blogs = state.blogs;
          return GridView.builder(
            itemCount: blogs.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 768, // max width of each card
              mainAxisSpacing: 8, // vertical spacing
              crossAxisSpacing: 8, // horizontal spacing
              childAspectRatio:
                  1.8, // width / height ratio of the card (adjust as needed)
            ),
            itemBuilder: (context, index) {
              final blog = blogs[index];
              final cardColors = [
                AppPallete.gradient1,
                AppPallete.gradient2,
                AppPallete.gradient3,
              ];

              return Padding(
                padding: const EdgeInsets.all(2),
                child: BlogCard(
                  blog: blog,
                  color: cardColors[index % cardColors.length],
                ),
              );
            },
          );
        }

        return const Text('No Blogs');
      },
    );
  }
}
