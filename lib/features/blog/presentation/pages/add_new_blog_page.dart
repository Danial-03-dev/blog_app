import 'package:blog_app/core/common/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:blog_app/core/common/widgets/custom_scroll_config.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/blog/presentation/blocs/blog_bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/appbars/add_new_blog_page_appbar.dart';
import 'package:blog_app/features/blog/presentation/widgets/inputs/blog_editor.dart';
import 'package:blog_app/features/blog/presentation/widgets/lists/blog_category_list.dart';
import 'package:blog_app/features/blog/presentation/widgets/select_img_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedTopics = [];
  Uint8List? selectedImage;

  void handleCategorySelect(String category) {
    setState(() {
      if (selectedTopics.contains(category)) {
        selectedTopics.remove(category);
      } else {
        selectedTopics.add(category);
      }
    });
  }

  void selectImage() async {
    final pickedImage = await pickImage();

    setState(() {
      selectedImage = pickedImage;
    });
  }

  void handleUploadBlog() {
    if (formKey.currentState!.validate() &&
        selectedTopics.isNotEmpty &&
        selectedImage != null) {
      final posterId =
          (context.read<AppUserCubit>().state as AppUserLoggedInState).user.id;
      final title = titleController.text.trim();
      final content = contentController.text.trim();

      context.read<BlogBloc>().add(
        BlogUploadEvent(
          posterId: posterId,
          title: title,
          content: content,
          image: selectedImage!,
          topics: selectedTopics,
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();

    titleController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AddNewBlogPageAppBar(handleAddBlog: handleUploadBlog),
      body: CustomScrollConfig(
        child: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogFailureState) {
              showSnackbar(context: context, text: state.message);
            } else if (state is BlogUploadSuccessState) {
              Navigator.pushAndRemoveUntil(
                context,
                BlogPage.route(),
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            if (state is BlogLoadingState) {
              return const Loader();
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formKey,
                  child: Column(
                    spacing: 20,
                    children: [
                      SelectImgBox(onTap: selectImage, image: selectedImage),
                      BlogCategoryList(
                        selectedTopics: selectedTopics,
                        handleCategorySelect: handleCategorySelect,
                      ),
                      Column(
                        spacing: 12,
                        children: [
                          BlogEditor(
                            controller: titleController,
                            hintText: 'Blog Title',
                          ),
                          BlogEditor(
                            controller: contentController,
                            hintText: 'Content',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
