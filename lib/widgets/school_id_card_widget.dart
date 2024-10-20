import 'package:academia/exports/barrel.dart';
import 'package:academia/models/models.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SchoolIDCard extends StatelessWidget {
  const SchoolIDCard({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.shadow,
        ),
      ),
      padding: const EdgeInsets.all(12),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: 250,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Image.asset(
                "assets/logos/du-logo.png",
                width: 80,
              ),
              const Spacer(),
              Text(
                "STUDENT",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                    ),
              )
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "${user.firstName.toUpperCase()} ${user.lastName.toUpperCase()}",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontFamily: GoogleFonts.jetBrainsMono().fontFamily,
                ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Flexible(
                  flex: 1,
                  child: CircleAvatar(
                    radius: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(800),
                      child: Image.memory(
                        Uint8List.fromList(
                          base64Decode(
                            userController.user.value!.schoolProfile
                                .replaceFirst("data:image/gif;base64,", ""),
                          ),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
              const SizedBox(width: 12),
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text(
                          "ID/ Passport: ",
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.jetBrainsMono().fontFamily,
                                  ),
                        ),
                        Text(
                          user.nationalId,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontFamily:
                                        GoogleFonts.jetBrainsMono().fontFamily,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          "Admission: ",
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.jetBrainsMono().fontFamily,
                                  ),
                        ),
                        Text(
                          user.admissionNumber,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontFamily:
                                        GoogleFonts.jetBrainsMono().fontFamily,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      user.admissionNumber,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily:
                                GoogleFonts.libreBarcode128().fontFamily,
                          ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const Spacer(),
          Text(
            "*Note that this is a duplicate, data provided here is as is",
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.red, overflow: TextOverflow.fade),
          ),
        ],
      ),
    );
  }
}
