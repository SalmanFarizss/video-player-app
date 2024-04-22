import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lilac_task_app/core/utilities.dart';
import 'package:lilac_task_app/features/home/controller/home_controller.dart';
import 'package:lilac_task_app/models/user_model.dart';
import '../../../core/commons/loading.dart';
import '../../../core/constants/constants.dart';
import '../../auth/screens/splash_screen.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  final String phone;
  final String uid;
  const ProfileScreen({super.key, required this.phone, required this.uid});
  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final imageProviderProvider = StateProvider<File?>((ref) => null);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> pickImage(WidgetRef ref) async {
    var pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 60);
    if (pickedFile != null) {
      ref
          .read(imageProviderProvider.notifier)
          .update((state) => File(pickedFile.path));
    }
  }

  Future<void> addDetails(
      {required WidgetRef ref,
      required File selectedImage,
      required BuildContext context}) async {
    UserModel user = UserModel(
        name: nameController.text,
        imageUrl: '',
        email: emailController.text,
        phone: widget.phone,
        dateOfBirth: pikedDate!,
        uid: widget.uid);
    ref.read(homeControllerProvider.notifier).addUserData(
        userModel: user, selectedImage: selectedImage, context: context);
  }

  DateTime? pikedDate;
  Future<void> selectDOB(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: pikedDate ?? DateTime(2000),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null) {
      pikedDate = picked;
      dobController.text = '${picked.day}/${picked.month}/${picked.year}';
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    dobController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(homeControllerProvider);
    return Scaffold(
      body: isLoading
          ? const Loading()
          : Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.1),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome to the App',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        'Enter your details for this app, and Proceed',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Consumer(builder: (context, ref, child) {
                        File? image = ref.watch(imageProviderProvider);
                        return SizedBox(
                          height: height * 0.18,
                          width: width,
                          child: InkWell(
                              onTap: () {
                                pickImage(ref);
                              },
                              child: image == null
                                  ? Image.asset(Constants.defaultAvatar)
                                  : CircleAvatar(
                                      radius: width * 0.2,
                                      backgroundImage: FileImage(image))),
                        );
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                            text: 'Name',
                            style: Theme.of(context).textTheme.labelSmall,
                            children: [
                              TextSpan(
                                  text: '*',
                                  style: TextStyle(
                                      fontSize: width * 0.035,
                                      color: Colors.red))
                            ]),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: height * 0.06,
                        child: TextFormField(
                          style: Theme.of(context).textTheme.bodyMedium,
                          controller: nameController,
                          decoration: InputDecoration(
                              hintText: 'Name',
                              hintStyle: Theme.of(context).textTheme.labelSmall,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade100))),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                            text: 'Email',
                            style: Theme.of(context).textTheme.labelSmall,
                            children: [
                              TextSpan(
                                  text: '*',
                                  style: TextStyle(
                                      fontSize: width * 0.035,
                                      color: Colors.red))
                            ]),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: height * 0.06,
                        child: TextFormField(
                          controller: emailController,
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: Theme.of(context).textTheme.labelSmall,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade100))),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                            text: 'Date of Birth',
                            style: Theme.of(context).textTheme.labelSmall,
                            children: [
                              TextSpan(
                                  text: '*',
                                  style: TextStyle(
                                      fontSize: width * 0.035,
                                      color: Colors.red))
                            ]),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: height * 0.06,
                        child: TextFormField(
                          style: Theme.of(context).textTheme.bodyMedium,
                          readOnly: true,
                          controller: dobController,
                          keyboardType: TextInputType.phone,
                          onTap: () {
                            selectDOB(context);
                          },
                          decoration: InputDecoration(
                              hintText: 'dd/mm/yyyy',
                              hintStyle: Theme.of(context).textTheme.labelSmall,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade100))),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.1,
                      ),
                      InkWell(
                        onTap: () {
                          File? image = ref.read(imageProviderProvider);
                          if (_formKey.currentState!.validate()) {
                            if (image != null &&
                                validateEmail(emailController.text.trim()) &&
                                pikedDate != null) {
                              addDetails(
                                  ref: ref,
                                  selectedImage: image,
                                  context: context);
                            } else {
                              image == null
                                  ? failureSnackBar(
                                      context, 'Please Select Image')
                                  : pikedDate == null
                                      ? failureSnackBar(context,
                                          'Please Choose date of birth')
                                      : failureSnackBar(
                                          context, 'Please enter valid email');
                            }
                          }
                        },
                        child: Container(
                          height: height * 0.06,
                          width: width,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(height * 0.25),
                              color: Colors.black),
                          child: Center(
                            child: Text(
                              'Proceed',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
