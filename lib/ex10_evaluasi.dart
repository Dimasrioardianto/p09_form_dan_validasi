import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Pendaftaran Pengguna',
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Form Pendaftaran'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // Controller untuk setiap field
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String selectedRole = '0'; // 0 = User, 1 = Admin

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void validateInput() {
    if (formKey.currentState!.validate()) {
      const snackBar = SnackBar(content: Text('Semua data valid'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      showData();
    }
  }

  Future<void> showData() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            'Username: ${usernameController.text}\n'
            'Email: ${emailController.text}\n'
            'Nomor HP: ${phoneController.text}\n'
            'Password: ${passwordController.text}\n'
            'Role: ${selectedRole == '0' ? 'User' : 'Admin'}',
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Username
                TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    final username = value!.trim();
                    if (username.isEmpty) {
                      return 'Username tidak boleh kosong';
                    } else if (username.length < 4 || username.length > 25) {
                      return 'Username harus 4-25 karakter';
                    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(username)) {
                      return 'Username hanya boleh huruf';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 10),

                // Email
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    final email = value!.trim();
                    if (email.isEmpty) {
                      return 'Email tidak boleh kosong';
                    } else if (email.length < 4 || email.length > 25 || !email.contains('@')) {
                      return 'Email harus 4-25 karakter dan mengandung @';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 10),

                // Nomor HP
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Nomor HP',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    final phone = value!.trim();
                    if (phone.isEmpty) {
                      return 'Nomor HP tidak boleh kosong';
                    } else if (!RegExp(r'^[0-9]{10,12}$').hasMatch(phone)) {
                      return 'Nomor HP harus 10-12 digit angka';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 10),

                // Password
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    final pass = value!.trim();
                    if (pass.isEmpty) {
                      return 'Password tidak boleh kosong';
                    } else if (pass.length < 4 || pass.length > 25) {
                      return 'Password harus 4-25 karakter';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 10),

                // Konfirmasi Password
                TextFormField(
                  controller: confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Konfirmasi Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.trim() != passwordController.text.trim()) {
                      return 'Konfirmasi password tidak cocok';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 10),

                // Role Dropdown
                DropdownButtonFormField<String>(
                  value: selectedRole,
                  items: const [
                    DropdownMenuItem(value: '0', child: Text('User')),
                    DropdownMenuItem(value: '1', child: Text('Admin')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedRole = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Role',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                // Tombol Submit
                ElevatedButton(
                  onPressed: validateInput,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
