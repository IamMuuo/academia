import 'package:academia/features/auth/cubit/auth_cubit.dart';
import 'package:academia/utils/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _admissionNumberController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nationalIdController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  bool _showPassword = false;
  bool _dataFetched = false;
  DateTime? _dateOfBirth;

  late AuthCubit authCubit;

  @override
  void initState() {
    super.initState();
    authCubit = BlocProvider.of<AuthCubit>(context);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _dateOfBirth) {
      setState(() {
        _dateOfBirth = picked;
      });
    }
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is removed
    _admissionNumberController.dispose();
    _passwordController.dispose();
    _nationalIdController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void _checkValidity() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Perform your validity check (e.g., check admission number and password)
      // This is a placeholder for your validity check logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Checking validity...", softWrap: true)),
      );

      final result = await authCubit.authenticate(
        _admissionNumberController.text,
        _passwordController.text,
      );

      result.fold((l) {
        _showAlertDialog(l);
      }, (r) {
        // print(r);
        // print(r.toJson());

        _nationalIdController.text = r.nationalId;
        _firstNameController.text = r.firstname;
        _lastNameController.text = r.othernames;
        _phoneController.text = r.phone;
        _emailController.text = r.email;
        _usernameController.text = r.username;
        _dateOfBirth = r.dateOfBirth;
        _dateOfBirthController.text =
            DateFormat.yMMMMEEEEd().format(r.dateOfBirth);

        setState(() {});
      });

      setState(() {
        _dataFetched = true;
      });
    } else {
      _showAlertDialog("Please fill in all required fields.");
    }
  }

  void _getStarted() {
    if (_formKey.currentState?.validate() ?? false) {
      // Perform sign-up logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Signing up...")),
      );
    } else {
      _showAlertDialog("Please fill in all required fields.");
    }
  }

  void _showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Validation Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add your info"),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                TextFormField(
                  controller: _admissionNumberController,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d{0,2}-?\d{0,4}$'),
                    ),
                    AdmnoDashFormatter(),
                  ],
                  decoration: InputDecoration(
                    label: const Text("Admission Number"),
                    hintText: "00-0000",
                    helperText: "Please input your school admission number",
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your admission number.';
                    }
                    return null;
                  },
                ),

                // Password field
                TextFormField(
                  controller: _passwordController,
                  textAlign: TextAlign.center,
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      icon: Icon(
                        _showPassword ? EvaIcons.eye_off_outline : EvaIcons.eye,
                      ),
                    ),
                    label: const Text("Password"),
                    hintText: "Provide your school portal password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password.';
                    }
                    return null;
                  },
                ),
                Visibility(
                  visible: _dataFetched,
                  child: TextFormField(
                    controller: _usernameController,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      FilteringTextInputFormatter.singleLineFormatter,
                    ],
                    decoration: InputDecoration(
                      label: const Text("Username"),
                      hintText: "Your username",
                      helperText: "Provide a username or nickname",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill your username';
                      }
                      return null;
                    },
                  ),
                ),

                Visibility(
                  visible: _dataFetched,
                  child: TextFormField(
                    controller: _emailController,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      EmailInputFormatter(),
                    ],
                    decoration: InputDecoration(
                      label: const Text("National ID"),
                      hintText: "Your national identity",
                      helperText:
                          "In case you're a minor use your admission number",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your National ID.';
                      }
                      return null;
                    },
                  ),
                ),

                Visibility(
                  visible: _dataFetched,
                  child: TextFormField(
                    controller: _firstNameController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      label: const Text("First name"),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name.';
                      }
                      return null;
                    },
                  ),
                ),

                Visibility(
                  visible: _dataFetched,
                  child: TextFormField(
                    controller: _lastNameController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      label: const Text("Last name"),
                      helperText:
                          "Please make sure your names appear correctly",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name.';
                      }
                      return null;
                    },
                  ),
                ),

                Visibility(
                  visible: _dataFetched,
                  child: IntlPhoneField(
                    controller: _phoneController,
                    showCountryFlag: true,
                    keyboardType: TextInputType.phone,
                    initialCountryCode: "KE",
                    disableLengthCheck: true,
                    invalidNumberMessage: "Please enter a valid phone number",
                    decoration: InputDecoration(
                      label: const Text("Phone"),
                      hintText: "712345678",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),

                Visibility(
                  visible: _dataFetched,
                  child: TextFormField(
                    controller: _emailController,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      EmailInputFormatter(),
                    ],
                    decoration: InputDecoration(
                      label: const Text("Email"),
                      hintText: "someone@daystar.ac.ke",
                      helperText: "Use your school email",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email.';
                      }
                      return null;
                    },
                  ),
                ),
                // Date of Birth Picker
                Visibility(
                  visible: _dataFetched,
                  child: GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: _dateOfBirthController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          label: const Text("Date of Birth"),
                          hintText: _dateOfBirth != null
                              ? "${_dateOfBirth!.day}/${_dateOfBirth!.month}/${_dateOfBirth!.year}"
                              : "Select your date of birth",
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        validator: (value) {
                          if (_dateOfBirth == null) {
                            return 'Please select your date of birth.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),

                _dataFetched
                    ? FilledButton.icon(
                        icon: const Icon(Bootstrap.person_fill_add),
                        onPressed: _getStarted,
                        label: const Text("Get started"),
                      )
                    : FilledButton.icon(
                        icon: const Icon(EvaIcons.person_done_outline),
                        onPressed: _checkValidity,
                        label: const Text("Check validity"),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
