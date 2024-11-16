import 'package:kisiler_uygulamasi/Kisiler.dart';
import 'package:kisiler_uygulamasi/VeritabaniYardimcisi.dart';

//Bu method sayesinde veritabanındakı kişileri alıcam
// her bir satırı kişi nesnesıne donusturup bu method kullanıldığında listeye ileticem
class Kisilerdao {
  Future<List<Kisiler>> tumKisiler() async {
    //Veritabanına erişim
    var db = await  VeritabaniYardimcisi.veritabaniErisim();

    //Sorgu yapıp sonucunu alıp listede tutuyorum
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kisiler");

    return List.generate(maps.length, (index) {
      var satir =  maps[index];
      return Kisiler(satir["kisi_id"],satir["kisi_ad"] , satir["kisi_tel"]);
    });
  }

  //Arama işlemi için gerekli method
  Future<List<Kisiler>> kisiArama(String aramaKelimesi) async {
    //Veritabanına erişim
    var db = await  VeritabaniYardimcisi.veritabaniErisim();

   
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kisiler WHERE kisi_ad like  '%$aramaKelimesi%' ");

//Yaptığımız sorguyu kişiler nesnelerine dönüşturup liste halınde tutuyoruz
    return List.generate(maps.length, (index) {
      var satir =  maps[index];
      return Kisiler(satir["kisi_id"],satir["kisi_ad"] , satir["kisi_tel"]);
    });
  }


//Kişi Silme ,Ekleme ve Güncelleme Methodları

//Kişi Ekleme
  Future<void> kisiEkle(String kisi_ad , String kisi_tel) async {
    //Veritabanına erişim
    var db = await  VeritabaniYardimcisi.veritabaniErisim();

    //Bir map olusturup dışardan aldıgımız bilgileri burada tutuyoruz
    var bilgiler = Map<String , dynamic>(); 

    bilgiler["kisi_ad"] = kisi_ad;
    bilgiler["kisi_tel"] = kisi_tel;

    db.insert("kisiler", bilgiler);
  }

//Kişi Güncelleme
Future<void> kisiGuncelle(int kisi_id,String kisi_ad , String kisi_tel) async {
    //Veritabanına erişim
    var db = await  VeritabaniYardimcisi.veritabaniErisim();

    //Bir map olusturup dışardan aldıgımız bilgileri burada tutuyoruz
    var bilgiler = Map<String , dynamic>(); 

    bilgiler["kisi_ad"] = kisi_ad;
    bilgiler["kisi_tel"] = kisi_tel;

    db.update("kisiler", bilgiler , where: "kisi_id = ?" , whereArgs: [kisi_id]);
  }

//Kişi Silme Methodu
Future<void> kisiSilme(int kisi_id) async {
    //Veritabanına erişim
    var db = await  VeritabaniYardimcisi.veritabaniErisim();


    db.delete("kisiler",  where: "kisi_id = ?" , whereArgs: [kisi_id]);
  }

}
