import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Import the home pages based on the role
import 'patient_home_page.dart';
import 'doctor_home_page.dart';

// Import the login page
import 'login.dart'; // Ensure this points to your login.dart file

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPage createState() => _RegistrationPage();
}

class _RegistrationPage extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? selectedRole = 'patient'; // Default role is 'patient'

  void moveToLogin() {
    // Navigate to the login page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void handleRegistration() {
    if (_formKey.currentState!.validate()) {
      // Registration logic can be added here

      // Based on the role, navigate to the respective home page
      if (selectedRole == 'patient') {
        // Navigate to Patient Home Page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PatientHomePage()),
        );
      } else if (selectedRole == 'doctor') {
        // Navigate to Doctor Home Page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DoctorHomePage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration", style: GoogleFonts.lato()),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Full Name",
                      hintText: "Enter your full name",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name can't be empty";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      hintText: "Enter your email",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email can't be empty";
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      hintText: "Enter your password",
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password can't be empty";
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedRole,
                    decoration: const InputDecoration(
                      labelText: "Role",
                      hintText: "Select your role",
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedRole = newValue;
                      });
                    },
                    items: <String>['patient', 'doctor']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return "Please select a role";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: handleRegistration, // Call the handleRegistration function
                    child: const Text("Register"),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: moveToLogin,
                    child: const Text(
                      "Already have an account? Login here",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
