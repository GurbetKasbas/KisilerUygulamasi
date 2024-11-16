import 'package:flutter/material.dart';
import 'package:kisiler_uygulamasi/Kisilerdao.dart';
import 'package:kisiler_uygulamasi/screens/anasayfa.dart';

class KisiKayit extends StatefulWidget {
  const KisiKayit({super.key});

  @override
  State<KisiKayit> createState() => _KisiKayitState();
}

class _KisiKayitState extends State<KisiKayit> {
  var tfKisiAdi = TextEditingController();
  var tfKisiTel = TextEditingController();
//Kişi kaydetme methodu
  Future<void> kayit(String kisi_ad, String kisi_tel) async {
    await Kisilerdao().kisiEkle(kisi_ad, kisi_tel);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Anasayfa()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          "Kişi Kayıt",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: tfKisiAdi,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: const Color.fromARGB(214, 68, 255, 190),
                  hintText: "Kişi Adı",
                ),
              ),
              TextField(
                controller: tfKisiTel,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: const Color.fromARGB(214, 68, 255, 190),
                    hintText: "Kişi Tel"),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () {
          kayit(tfKisiAdi.text, tfKisiTel.text);
        },
        tooltip: 'Kişi Kayıt',
        icon: Icon(
          Icons.save,
          color: Colors.white,
        ),
        label: Text(
          "Kaydet",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
