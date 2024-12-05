import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'registration.dart'; // Ensure this import points to your registration page

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({Key? key}) : super(key: key);

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  TextEditingController feeController = TextEditingController();
  TextEditingController patientAddress = TextEditingController();
  TextEditingController notes = TextEditingController();
  TextEditingController vitals = TextEditingController();
  TextEditingController medicines = TextEditingController();
  TextEditingController advice = TextEditingController();
  bool isAuthorized = false;
  String feeAmount = "0"; // Default fee amount
  String walletAddress =
      "0xddbb3be28f13c0d6bddb15a14d0d680c6fba2bd7"; // Doctor's wallet address

  void checkAuthorization() {
    if (patientAddress.text.isNotEmpty) {
      setState(() {
        isAuthorized = true;
      });
    } else {
      Fluttertoast.showToast(msg: "Wrong address");
    }
  }

  void updateFee(String newFee) {
    if (newFee.isNotEmpty) {
      setState(() {
        feeAmount = newFee;
        feeController.clear(); // Clear the text field after updating
      });
      Fluttertoast.showToast(msg: "Fee updated to \$" + newFee);
    } else {
      Fluttertoast.showToast(msg: "Amount cannot be empty");
    }
  }

  void logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => RegistrationPage(),
      ), // Navigate to the registration page
    );
  }

  void sendPrescription() {
    if (isAuthorized) {
      Fluttertoast.showToast(msg: "Prescription sent!");
    } else {
      Fluttertoast.showToast(msg: "Address not authorized!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Widget Header
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 8,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      FontAwesomeIcons.userDoctor,
                      color: Colors.white,
                      size: 40,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Doctor Panel',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // Ethereum Wallet Address Widget
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Wallet Address Display
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            walletAddress,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Logout Button
                    ElevatedButton(
                      onPressed: logout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                      ),
                      child: const Text(
                        "Logout",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),

              // Add Fee Widget
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title Row
                      Row(
                        children: const [
                          Icon(FontAwesomeIcons.moneyBillAlt, size: 20),
                          SizedBox(width: 8),
                          Text(
                            "Add Fee",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Fee Input Field
                      TextFormField(
                        controller: feeController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Enter Fee",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Update Fee Button
                      ElevatedButton(
                        onPressed: () {
                          updateFee(feeController.text); // Update fee on button press
                        },
                        child: const Text("Update Fee"),
                      ),
                      const SizedBox(height: 16),

                      // Display Updated Fee
                      Text(
                        "Current Fee: \$${feeAmount}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Give Prescription Widget
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title Row
                      Row(
                        children: const [
                          Icon(FontAwesomeIcons.prescriptionBottle, size: 20),
                          SizedBox(width: 8),
                          Text(
                            "Give Prescription",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Address Field
                      TextFormField(
                        controller: patientAddress,
                        decoration: const InputDecoration(
                          labelText: "Address",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Check Authorization Button
                      ElevatedButton(
                        onPressed: checkAuthorization,
                        child: const Text("Check Authorization"),
                      ),
                      const SizedBox(height: 16),

                      // Only show below fields if authorized
                      if (isAuthorized) ...[
                        // Notes Field
                        TextFormField(
                          controller: notes,
                          decoration: const InputDecoration(
                            labelText: "Notes",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Vitals Field
                        TextFormField(
                          controller: vitals,
                          decoration: const InputDecoration(
                            labelText: "Vitals",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Medicines Field
                        TextFormField(
                          controller: medicines,
                          decoration: const InputDecoration(
                            labelText: "Medicines",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Advice Field
                        TextFormField(
                          controller: advice,
                          decoration: const InputDecoration(
                            labelText: "Advice",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Send Prescription Button
                        ElevatedButton(
                          onPressed: sendPrescription,
                          child: const Text("Send"),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
