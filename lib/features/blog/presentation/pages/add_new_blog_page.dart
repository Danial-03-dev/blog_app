import 'package:blog_app/core/common/widgets/custom_scroll_config.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/features/blog/presentation/widgets/appbars/add_new_blog_page_appbar.dart';
import 'package:blog_app/features/blog/presentation/widgets/inputs/blog_editor.dart';
import 'package:blog_app/features/blog/presentation/widgets/lists/blog_category_list.dart';
import 'package:blog_app/features/blog/presentation/widgets/select_img_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
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

  @override
  void dispose() {
    super.dispose();

    titleController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AddNewBlogPageAppBar(),
      body: CustomScrollConfig(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
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
      ),
    );
  }
}
