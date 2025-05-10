import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // Menjalankan aplikasi Flutter
}

// Widget utama aplikasi, tidak bisa berubah (Stateless)
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo', // Judul aplikasi
      theme: ThemeData(
        useMaterial3: false, 
        primarySwatch: Colors.blue, // Tema utama aplikasi berwarna biru
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'), // Halaman awal
    );
  }
}

// Widget halaman utama yang bisa berubah-ubah (Stateful)
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState(); // Membuat state
}

// State dari halaman utama
class _MyHomePageState extends State<MyHomePage> {
  // Kunci global untuk form dan scaffold (untuk validasi dan kontrol)
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey, // Menetapkan scaffold key
      appBar: AppBar(
        title: Text(widget.title), // Menampilkan judul di app bar
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0), // Padding di seluruh sisi
        child: Form(
          key: formKey, // Menetapkan form key
          child: Column(
            children: <Widget>[
              // Text field untuk NIM
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Nim', // Petunjuk input
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 10.0), // Jarak antar input

              // Text field untuk Nama
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Nama',
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 10.0),

              // Text field untuk Program Studi
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Program Studi',
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 10.0),

              // Text field untuk Semester
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Semester',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20.0),

              // Tombol submit
              ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  // Aksi saat tombol ditekan (belum diisi)
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
