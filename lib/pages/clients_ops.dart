// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../helpers/sql_helper.dart';
import '../widgets/app_elevated_button.dart';
import '../widgets/app_text_form_field.dart';

import 'package:get_it/get_it.dart';

class ClientsOpsPage extends StatefulWidget {
  const ClientsOpsPage({super.key});

  @override
  State<ClientsOpsPage> createState() => _ClientsOpsPageState();
}

class _ClientsOpsPageState extends State<ClientsOpsPage> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              AppTextFormField(
                controller: nameController,
                validator: (value) {
                  if (value!.isEmpty || checker(value, ' ')) {
                    return 'Name is required';
                  }
                  return null;
                },
                label: 'Name',
                hint: 'nada mostafa',
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextFormField(
                controller: emailController,
                autoCorrectBool: true,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty ||
                      !checker(value, '@') ||
                      !checker(value, '.com') ||
                      !checker(value, 'gmail') &&
                          !checker(value, 'yahoo') &&
                          !checker(value, 'hotmail')) {
                    return 'Please enter a valid Email Adress';
                  }
                  return null;
                },
                label: 'Email',
                hint: 'email@adress.com',
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextFormField(
                controller: phoneController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Phone is required';
                  }
                  return null;
                },
                label: 'Phone',
                hint: '01231231231',
                textInputType: TextInputType.phone,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextFormField(
                controller: addressController,
                validator: (value) {
                  if (value!.isEmpty || checker(value, ' ')) {
                    return 'Address is required';
                  }
                  return null;
                },
                label: 'Address',
                hint: '24 address st.',
                textInputType: TextInputType.streetAddress,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(
                height: 20,
              ),
              AppElevatedButton(
                label: 'Submit',
                onPressed: () async {
                  await onSubmit();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onSubmit() async {
    try {
      if (formKey.currentState!.validate()) {
        var sqlHelper = GetIt.I.get<SqlHelper>();
        await sqlHelper.db!.insert(
          'Clients',
          {
            'name': nameController.text,
            'email': emailController.text,
            'phone': phoneController.text,
            'address': addressController.text,
          },
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Client Saved Successfully'),
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error In Create Client : $e'),
        ),
      );
    }
  }
}

bool checker(String value, String check) => value.contains(check);

InputDecoration textFieldDecoration(
  BuildContext context, {
  Color? color,
  required IconData icon,
  required String label,
  required String hint,
}) {
  return InputDecoration(
    prefixIcon: Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Icon(
        icon,
        color: color,
      ),
    ),
    labelText: label,
    labelStyle: Theme.of(context).textTheme.labelMedium,
    hintText: hint,
    hintStyle:
        Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey),
  );
}
