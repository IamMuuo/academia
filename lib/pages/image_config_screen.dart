import 'package:academia/exports/barrel.dart';

class ImageConfigScreen extends StatefulWidget {
  const ImageConfigScreen({
    super.key,
    this.title = "Configure image",
    required this.onImagePicked,
  });
  final String title;
  final void Function(XFile?) onImagePicked;

  @override
  State<ImageConfigScreen> createState() => _ImageConfigScreenState();
}

class _ImageConfigScreenState extends State<ImageConfigScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  bool isPicked = false;

  // Future<void> _pickImage(ImageSource source) async {
  //   final XFile? image = await _picker.pickImage(source: source);
  //   setState(() {
  //     _imageFile = image;
  //   });
  // }

  Future<void> _pickAndCropImage(ImageSource source) async {
    // Pick image
    final XFile? pickedImage = await _picker.pickImage(source: source);

    if (pickedImage != null) {
      // Crop image
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: mounted
                ? Theme.of(context).colorScheme.primary
                : Colors.deepPurple,
            toolbarWidgetColor: mounted
                ? Theme.of(context).colorScheme.onPrimary
                : Colors.white,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio16x9,
              CropAspectRatioPreset.ratio4x3,
            ],
          ),
          IOSUiSettings(
              title: "Cropper",
              minimumAspectRatio: 1.0,
              aspectRatioPresets: [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio16x9,
                CropAspectRatioPreset.ratio4x3,
              ]),
        ],
      );

      setState(() {
        _imageFile = croppedFile != null ? XFile(croppedFile.path) : null;
        isPicked = true;
      });
      widget.onImagePicked(null);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: _imageFile == null
            ? null
            : [
                FilledButton(
                    onPressed: () {
                      setState(() {
                        _imageFile = null;
                        isPicked = false;
                      });
                    },
                    child: const Text("Clear"))
              ],
      ),
      body: _imageFile == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Tap to pick an image",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () async {
                        await _pickAndCropImage(ImageSource.gallery);
                      },
                      icon: const Icon(Ionicons.images),
                    ),
                    IconButton(
                      onPressed: () async {
                        await _pickAndCropImage(ImageSource.camera);
                      },
                      icon: const Icon(Ionicons.camera),
                    ),
                  ],
                )
              ],
            )
          : FutureBuilder(
              future: _imageFile!.readAsBytes(),
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
      floatingActionButton: isPicked
          ? FloatingActionButton(
              child: const Icon(Ionicons.checkmark),
              onPressed: () {
                widget.onImagePicked(_imageFile);
                Navigator.pop(context);
              },
            )
          : null,
    );
  }
}
