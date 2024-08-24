import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/chirp/controllers/chirp_controller.dart';
import 'package:get/get.dart';

class PostCreatePage extends StatefulWidget {
  const PostCreatePage({super.key});

  @override
  State<PostCreatePage> createState() => _PostCreatePageState();
}

class _PostCreatePageState extends State<PostCreatePage> {
  final formState = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final List<XFile> imageFiles = [];
  final ChirpController chirpController = Get.find<ChirpController>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Ionicons.close),
        ),
        actions: [
          FilledButton(
            onPressed: () {
              if (!formState.currentState!.validate()) {
                return;
              }
              // Create post
              setState(() {
                isLoading = true;
              });
              chirpController
                  .createPost(
                titleController.text,
                bodyController.text,
              )
                  .then((value) {
                value.fold((l) {}, (r) {
                  chirpController.fetchPosts();
                  showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                            title: Text("Success!"),
                            content:
                                Text("Your post was successfully added 😉"),
                          ));
                });
              });

              setState(() {
                isLoading = false;
              });
              Navigator.pop(context);
            },
            child: const Text("Post"),
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(12),
        child: isLoading
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 22),
                    Text("Creating post")
                  ],
                ),
              )
            : Form(
                key: formState,
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (input) {
                        if (input!.isEmpty) {
                          return "Please input a memorable title to your post";
                        }
                        return null;
                      },
                      style: Theme.of(context).textTheme.headlineSmall,
                      decoration: InputDecoration(
                        hintText: "Title",
                        hintStyle: Theme.of(context).textTheme.headlineSmall,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    TextFormField(
                      controller: bodyController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (input) {
                        if (input!.isEmpty) {
                          return "Your body cannot be empty";
                        }
                        return null;
                      },
                      maxLines: 15,
                      decoration: const InputDecoration(
                        hintText: "Body Text",
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return PostAttachmentImageWidget(
                            media: imageFiles[index],
                            onDoubleTap: () {
                              setState(() {
                                imageFiles.removeAt(index);
                              });
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 8);
                        },
                        itemCount: imageFiles.length,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ImageConfigScreen(
                                      onImagePicked: (file) {
                                        setState(() {
                                          imageFiles.add(file!);
                                        });
                                      },
                                    )));
                          },
                          icon: const Icon(Ionicons.attach_outline),
                        ),
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

class PostAttachmentImageWidget extends StatelessWidget {
  const PostAttachmentImageWidget({
    super.key,
    required this.media,
    this.onDoubleTap,
  });
  final XFile media;
  final VoidCallback? onDoubleTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: onDoubleTap,
      child: Container(
        color: Colors.blue,
        width: 80,
        height: 80,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: FutureBuilder(
          future: media.readAsBytes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Text(
                "Processing image",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              );
            }
            return Center(
              child: Image.memory(
                snapshot.data!,
                height: 400,
              ),
            );
          },
        ),
      ),
    );
  }
}
