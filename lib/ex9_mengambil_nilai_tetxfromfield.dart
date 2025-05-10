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
      home: const MyHomePage(title: 'Flutter Demo Home Page'), // Halaman awal aplikasi
    );
  }
}

// Widget halaman utama (Stateful)
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title; // Judul halaman

  @override
  State<MyHomePage> createState() => _MyHomePageState(); // Membuat state dari widget
}

class _MyHomePageState extends State<MyHomePage> {
  // Kunci global untuk form dan scaffold agar bisa divalidasi dan dikontrol
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // Fokus dan controller untuk masing-masing input
  late FocusNode myFocusNode; // Fokus untuk field Nama
  final prodiController = TextEditingController(); // Controller untuk Program Studi
  final nimController = TextEditingController(); // Controller untuk NIM
  final namaController = TextEditingController(); // Controller untuk Nama
  final semesterController = TextEditingController(); // Controller untuk Semester

  // Fungsi mencetak nilai pada Program Studi ke konsol saat teks berubah
  void printValue() {
    print("Teks pada field Program Studi: ${prodiController.text}");
  }

  // Fungsi untuk menampilkan semua data dalam dialog pop-up setelah validasi
 showData() {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(
          'Nim     : ${nimController.text} \n'
          'Nama    : ${namaController.text}\n'
          'Prodi   : ${prodiController.text}\n'
          'Semester: ${semesterController.text}',
        ),
      );
    },
  );
}

  // Inisialisasi focus node dan listener saat state pertama kali dibuat
  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode(); // Fokus untuk field Nama
    prodiController.addListener(printValue); // Menjalankan printValue saat teks pada field Prodi berubah
  }

  // Bersihkan resource ketika widget dihapus dari tree
  @override
  void dispose() {
    myFocusNode.dispose();
    prodiController.dispose();
    nimController.dispose();
    namaController.dispose();
    semesterController.dispose();
    super.dispose();
  }

  // Fungsi validasi form dan menampilkan snackbar + dialog jika berhasil
  void validateInput() {
    FormState? form = formKey.currentState;
    const snackBar = SnackBar(
      content: Text('Semua data sudah tervalidasi'),
    );
    if (form!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      showData(); // Tampilkan data jika valid
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey, // Key scaffold
      appBar: AppBar(
        title: Text(widget.title), // Judul halaman
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0), // Padding konten
        child: Form(
          key: formKey, // Key form untuk validasi
          child: Column(
            children: <Widget>[
              // Input NIM
              TextFormField(
                controller: nimController, // Controller untuk ambil teks
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

              // Input Nama
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(
                  hintText: 'Nama',
                  labelText: 'Nama',
                  icon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                focusNode: myFocusNode, // Fokus untuk tombol fokus
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                },
              ),
              const SizedBox(height: 10.0),

              // Input Program Studi
              TextFormField(
                controller: prodiController,
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
                controller: semesterController,
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

              // Tombol aksi
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Tombol Submit
                  ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: validateInput,
                  ),
                  const SizedBox(width: 20),
                  // Tombol Fokus ke Nama
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
