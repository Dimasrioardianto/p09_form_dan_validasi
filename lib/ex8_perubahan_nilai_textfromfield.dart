import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // Menjalankan aplikasi Flutter
}

// Widget utama aplikasi (Stateless)
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo', // Judul aplikasi
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue, // Warna utama biru
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'), // Halaman awal
    );
  }
}

// Widget halaman utama (Stateful)
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title; // Judul halaman

  @override
  State<MyHomePage> createState() => _MyHomePageState(); // Membuat state
}

class _MyHomePageState extends State<MyHomePage> {
  // Kunci global untuk form dan scaffold
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // Fokus dan controller
  late FocusNode myFocusNode; // Fokus untuk field Nama
  final prodiController = TextEditingController(); // Controller untuk field Program Studi

  // Fungsi untuk mencetak teks pada Program Studi ke konsol
  void printValue() {
    print("Teks pada field Program Studi: ${prodiController.text}");
  }

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode(); // Inisialisasi FocusNode
    prodiController.addListener(printValue); // Tambahkan listener pada controller
  }

  @override
  void dispose() {
    myFocusNode.dispose(); // Membersihkan FocusNode saat widget dihancurkan
    prodiController.dispose(); // Membersihkan controller saat widget dihancurkan
    super.dispose();
  }

  // Fungsi untuk validasi input
  void validateInput() {
    FormState? form = formKey.currentState; // Ambil form state saat ini
    const snackBar = SnackBar(
      content: Text('Semua data sudah tervalidasi'), // SnackBar jika valid
    );
    if (form!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar); // Tampilkan SnackBar
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey, // Key untuk Scaffold
      appBar: AppBar(
        title: Text(widget.title), // Tampilkan judul dari widget induk
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0), // Padding isi halaman
        child: Form(
          key: formKey, // Key form untuk validasi
          child: Column(
            children: <Widget>[
              // Field input NIM
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Nim',
                  labelText: 'Nim',
                  icon: Icon(Icons.person_pin),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Nim tidak boleh kosong';
                  }
                },
              ),
              const SizedBox(height: 10.0),

              // Field input Nama dengan FocusNode
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Nama',
                  labelText: 'Nama',
                  icon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                focusNode: myFocusNode, // Digunakan untuk fokus otomatis
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                },
              ),
              const SizedBox(height: 10.0),

              // Field input Program Studi dengan controller
              TextFormField(
                controller: prodiController, // Controller menangani perubahan nilai
                decoration: const InputDecoration(
                  hintText: 'Program Studi',
                  labelText: 'Program Studi',
                  icon: Icon(Icons.dashboard),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Prodi tidak boleh kosong';
                  }
                },
              ),
              const SizedBox(height: 10.0),

              // Field input Semester
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Semester',
                  labelText: 'Semester',
                  icon: Icon(Icons.format_list_numbered),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Semester tidak boleh kosong';
                  }
                },
              ),
              const SizedBox(height: 20.0),

              // Deretan tombol
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Tombol untuk validasi form
                  ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: validateInput,
                  ),
                  Container(width: 20), // Jarak antara dua tombol
                  // Tombol untuk memfokuskan input ke field Nama
                  ElevatedButton(
                    child: const Text('Fokus ke Nama'),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(myFocusNode);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
