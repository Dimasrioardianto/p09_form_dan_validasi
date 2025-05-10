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

  // Fokus untuk input nama
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode(); // Inisialisasi FocusNode
  }

  @override
  void dispose() {
    myFocusNode.dispose(); // Buang FocusNode saat widget dihancurkan
    super.dispose();
  }

  // Fungsi untuk validasi input
  void validateInput() {
    FormState? form = formKey.currentState; // Ambil state dari form saat ini

    const snackBar = SnackBar(
      content: Text('Semua data sudah tervalidasi'), // Pesan snackbar
    );

    if (form!.validate()) {
      // Jika semua field valid, tampilkan snackbar
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title), // Menampilkan judul halaman
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0), // Padding di seluruh sisi
        child: Form(
          key: formKey, // Menyambungkan form dengan GlobalKey
          child: Column(
            children: <Widget>[
              // Input NIM
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Nim',
                  labelText: 'Nim',
                  icon: Icon(Icons.person_pin), // Tambahan ikon
                  border: OutlineInputBorder(), // Border
                ),
                keyboardType: TextInputType.text,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Nim tidak boleh kosong';
                  }
                },
              ),
              const SizedBox(height: 10.0),

              // Input Nama dengan focusNode
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Nama',
                  labelText: 'Nama',
                  icon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                focusNode: myFocusNode, // Tambahkan focusNode
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                },
              ),
              const SizedBox(height: 10.0),

              // Input Program Studi
              TextFormField(
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

              // Input Semester
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

              // Dua tombol dalam satu baris
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: validateInput, // Tombol validasi
                  ),
                  Container(width: 20), // Spasi antar tombol
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
