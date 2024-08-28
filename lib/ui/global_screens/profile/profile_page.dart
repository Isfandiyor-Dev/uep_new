import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uep/bloc/profile/profile_bloc.dart';
import 'package:uep/bloc/profile/profile_event.dart';
import 'package:uep/bloc/profile/profile_state.dart';
import 'package:uep/models/user_model.dart';
import 'package:uep/utils/validators.dart';
import 'package:uep/ui/global_screens/widgets/custom_text_field.dart';

class ProfilePage extends StatefulWidget {
  // final UserModel? userModel;
  const ProfilePage({
    super.key,
    // this.userModel,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  File? image;

  @override
  void initState() {
    nameController = TextEditingController();
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
  }

  bool readOnly = true;

  void onTapSave() async {
    final BuildContext context = this.context;
    if (image != null) {
      BlocProvider.of<ProfileBloc>(context).add(
        EditProfile(
          data: {
            "name": nameController.text,
            "phone": phoneController.text,
          },
          image: image,
        ),
      );
    } else {
      print("Image nullga teng");
    }
  }

  Future<void> _pickImage() async {
    ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double sreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: readOnly
          ? null
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: FloatingActionButton(
                      heroTag: "save",
                      onPressed: onTapSave,
                      child: const Text("Save"),
                    ),
                  ),
                ],
              ),
            ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "My Profile",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 45,
                  height: 45,
                  child: FloatingActionButton(
                    heroTag: "settings",
                    backgroundColor: Colors.white,
                    onPressed: () {},
                    child: const Icon(
                      CupertinoIcons.settings,
                      size: 25,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              height: sreenHeight * 0.6,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xffC4CBD6).withOpacity(0.1),
                    blurRadius: 58,
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                      if (state is ProfileLoading) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      } else if (state is ProfileError) {
                        return Center(
                          child: Text("Xatolik yuz berdi: ${state.message}"),
                        );
                      } else if (state is ProfileLoaded) {
                        UserModel userModel = state.user;
                        nameController.text = userModel.name;
                        phoneController.text = userModel.phone ?? "";
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.teal,
                              backgroundImage: image != null
                                  ? FileImage(image!)
                                  : userModel.photo != null
                                      ? NetworkImage(
                                          "http://millima.flutterwithakmaljon.uz/storage/avatars/${userModel.photo!}")
                                      : null,
                              child: image == null
                                  ? !readOnly
                                      ? IconButton(
                                          onPressed: _pickImage,
                                          icon: const Icon(
                                            Icons.camera_alt_rounded,
                                            color: Colors.white,
                                          ),
                                        )
                                      : null
                                  : null,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  readOnly = !readOnly;
                                });
                              },
                              icon: SvgPicture.asset(
                                "assets/icons/edit.svg",
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ],
                        );
                      } else {
                        // Default holat
                        return const SizedBox.shrink();
                      }
                    }),
                    const SizedBox(height: 25),
                    CustomTextField(
                      labelText: "Name",
                      hintText: "Your name",
                      controller: nameController,
                      readOnly: readOnly,
                      validator: Validator.validateName,
                    ),
                    const SizedBox(height: 25),
                    CustomTextField(
                      labelText: "Phone number",
                      hintText: "+998 88 118 05 15",
                      controller: phoneController,
                      readOnly: readOnly,
                      validator: Validator.validatePhoneNumber,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
