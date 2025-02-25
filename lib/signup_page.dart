import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String _selectedGender = 'Male';

  void _signUp() async {
    if (_passwordController.text.trim() != _confirmPasswordController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords do not match!")),
      );
      return;
    }

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      print("User Created: \${userCredential.user!.email}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sign up successful! Please login.")),
      );
      Navigator.pop(context);
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sign up failed! Try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Color(0xFFEBB812),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Card ko upar shift karne ke liye
            children: [
              Image.asset('assets/logo.png', height: 220), // Logo ka size thoda bara kiya
              SizedBox(height: 10), // Height thodi kam ki taake card upar aaye
              Text("Create Account",
                  style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
              SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      _buildTextField(_nameController, "Full Name", Icons.person, false),
                      SizedBox(height: 10),
                      _buildTextField(_emailController, "Email", Icons.email, false),
                      SizedBox(height: 10),
                      _buildPasswordField(_passwordController, "Password", _obscurePassword,
                              () => setState(() => _obscurePassword = !_obscurePassword)),
                      SizedBox(height: 10),
                      _buildPasswordField(_confirmPasswordController, "Confirm Password",
                          _obscureConfirmPassword,
                              () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword)),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Gender:", style: TextStyle(fontSize: 16, fontFamily: 'Poppins')),
                          SizedBox(width: 10),
                          Row(
                            children: [
                              Radio(
                                value: 'Male',
                                groupValue: _selectedGender,
                                onChanged: (value) {
                                  setState(() => _selectedGender = value.toString());
                                },
                              ),
                              Text("Male", style: TextStyle(fontFamily: 'Poppins')),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 'Female',
                                groupValue: _selectedGender,
                                onChanged: (value) {
                                  setState(() => _selectedGender = value.toString());
                                },
                              ),
                              Text("Female", style: TextStyle(fontFamily: 'Poppins')),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _signUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFEBB812),
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: Text("Sign Up", style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'Poppins')),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?", style: TextStyle(fontFamily: 'Poppins')),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Login",
                                style: TextStyle(
                                  color: Color(0xFFEBB812),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                )),
                          ),
                        ],
                      ),
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

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, bool obscure) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.black54),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String label, bool obscure, VoidCallback toggle) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(Icons.lock, color: Colors.black54),
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility, color: Colors.black54),
          onPressed: toggle,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
