import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:synchronized/synchronized.dart';

class DbHelper {
  final String tblFoods= 'foods';

  final String colId = 'id';
  final String colSiparisNo = 'siparisNo';
  final String colKullaniciId = 'kullaniciId';
  final String colCariId = 'cariId';
  final String colCariKod = 'cariKod';
  final String colCariUnvan = 'cariUnvan';
  final String colProjeKod = 'projeKod';
  final String colStoKod = 'stoKod';
  final String colStoIsim = 'stoIsim';
  final String colMiktar = 'miktar';
  final String colBirimFiyat = 'birimFiyat';
  final String colIskonto1 = 'iskonto1';
  final String colIskonto2 = 'iskonto2';
  final String colIskonto3 = 'iskonto3';
  final String colStoAlSipBirim = 'stoAlSipBirim';
  final String colVergiPntr = 'vergiPntr';
  final String colFuarInsert = 'fuarInsert';
  final String colStokVadesiGun = 'stokVadesiGun';
  final String colStokVadesi = 'stokVadesi';
  final String colSatirAciklamasi = 'satirAciklamasi';
  final String colEvrakAciklamasi = 'evrakAciklamasi';
  final String colTarih = 'tarih';
  final String colBirim1Ad = 'birim1Ad';
  final String colBirim1Katsayi = 'birim1Katsayi';
  final String colBirim2Ad = 'birim2Ad';
  final String colBirim2Katsayi = 'birim2Katsayi';
  final String colBirim3Ad = 'birim3Ad';
  final String colBirim3Katsayi = 'birim3Katsayi';
  final String colBirim4Ad = 'birim4Ad';
  final String colBirim4Katsayi = 'birim4Katsayi';
  final String colNakit = 'nakit';
  final String colSipSpecial2 = 'sipSpecial2';

  static final DbHelper _dbHelper = DbHelper._internal();

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  static Database _db;
  final _lock = new Lock();

  Future<Database> get db async {
    if (_db == null) {
      await _lock.synchronized(() async {
        // Check again once entering the synchronized block
        if (_db == null) {
          _db = await initDB();
        }
      });
    }
    return _db;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "SiparisDB.db");
    var dbSiparis = await openDatabase(path,
        onOpen: _onOpen,
        version: 1,
        onCreate: _createDb,
        onUpgrade: _onUpgrade);
    return dbSiparis;
  }

  _onOpen(Database db) async {
    // Database is open, print its version
    print('db version ${await db.getVersion()}');
   // _createExtras(db,1);
  }

  void _createDb(Database db, int version) async {
  print('*****************************');
  print('*  Databaseler oluşturuldu  *');
  print('*****************************');
      await db.execute(
    '''CREATE TABLE foods 
    (id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,foodId TEXT,extraId TEXT, name TEXT, amount INTEGER, price REAL,image TEXT); 
    '''
    );
       await db.execute('''CREATE TABLE extras 
        (id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,foodId TEXT,extraId TEXT, name TEXT, amount INTEGER,price REAL);'''
    );
  }
 /*  void createExtras() async {
  print('extrasCreate');
      Database db = await this.db;
      await db.execute(
  '''CREATE TABLE extras 
  (id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,foodId TEXT,extraId TEXT, name TEXT, amount INTEGER, price REAL); 
  CREATE TABLE extras (id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,foodId TEXT,extraId TEXT, name TEXT, amount INTEGER,price REAL)
  '''
  );
  } */
  //SEPET Food
  Future<int> insertFood(String foodId ,String name,int amount,double price,String image) async {
    Database db = await this.db;
    var result = await db.rawInsert('INSERT INTO foods(foodId,name, amount,price,image) VALUES("$foodId","$name", $amount,$price,"$image")');
    print(result);
    return result;
  }
  Future<int> insertExtras(String foodId ,String name,String extraId,double price) async {
    Database db = await this.db;
    var result = await db.rawInsert('INSERT INTO extras(foodId,name, extraId,price) VALUES("$foodId","$name", $extraId,$price)');
    print(result);
    return result;
  }
  Future<int> deleteExtras(String foodId) async {
    Database db = await this.db;
    //var result = await db.delete("food", where: 'id = 2', whereArgs: ['id']);
    var resultRaw = await db.rawDelete("Delete from extras where foodId = $foodId");
    return resultRaw;
  }
  Future<List> getFoods() async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "Select * from foods");
    return result;
  }
  Future<List> getExtras() async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "Select * from extras");
    return result;
  }
  Future<List> getExtrasByFoodId(String foodId) async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "Select * from extras where foodId = '$foodId'");
    return result;
  }
  Future<int> deleteFood(String foodId) async {
    Database db = await this.db;
    //var result = await db.delete("food", where: 'id = 2', whereArgs: ['id']);
    var resultRaw = await db.rawDelete("Delete from foods where  foodId = '$foodId'");
    return resultRaw;
  }
  Future<int> deleteAllFoods() async {
    Database db = await this.db;
    //var result = await db.delete("food", where: 'id = 2', whereArgs: ['id']);
    var resultRaw = await db.rawDelete("Delete from foods");
    return resultRaw;
  }
  
  Future<int> deleteAllExtras() async {
    Database db = await this.db;
    //var result = await db.delete("food", where: 'id = 2', whereArgs: ['id']);
    var resultRaw = await db.rawDelete("Delete from extras");
    return resultRaw;
  }

   Future<int> updateFood(int id) async {
    Database db = await this.db;
    var result = await db
        .rawUpdate("update foods set amount=3, name='osman' where id=$id");
    return result;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Database version is updated, alter the table
  }



  /* //SEPET SQL
  Future<int> insertSepet(Sepet sepet) async {
    Database db = await this.db;
    var result = await db.insert(tblFoods, sepet.toMap());
    return result;
  }

  Future<int> deleteSepet(int id) async {
    Database db = await this.db;
    var result =
        await db.delete(tblFoods, where: '$colId = ?', whereArgs: [id]);
    //var resultRaw = await db.rawDelete("Delete from $tblFoods where $colId = $id");
    return result;
  }

  Future<int> deleteTumSepet() async {
    Database db = await this.db;
    var resultRaw = await db.rawDelete("Delete from $tblFoods");
    return resultRaw;
  }

  Future<int> deleteAktifSepet(Sepet sepet) async {
    Database db = await this.db;
    var resultRaw = await db.rawDelete(
        "Delete from $tblFoods where $colSiparisNo=${sepet.siparisNo} and $colCariId=${sepet.cariId} and $colKullaniciId=${sepet.kullaniciId}");
    return resultRaw;
  }

  Future<int> updateSepet(Sepet sepet) async {
    Database db = await this.db;
    var result = await db.update(tblFoods, sepet.toMap(),
        where: '$colId = ?', whereArgs: [sepet.id]);
    return result;
  }

  Future<int> updateSepetMiktarbyId(int id, double miktar) async {
    Database db = await this.db;
    var result = await db
        .rawUpdate("update $tblFoods set $colMiktar=$miktar where $colId=$id");
    return result;
  }

  Future<int> updateSepetEvrakAciklama(Sepet sepet, String aciklama) async {
    Database db = await this.db;
    var result = await db.rawUpdate(
        "update $tblFoods set $colEvrakAciklamasi='$aciklama' where $colSiparisNo=${sepet.siparisNo} and $colCariId=${sepet.cariId} and $colKullaniciId=${sepet.kullaniciId}");
    return result;
  }

  Future<List> getTumSepetleri() async {
    Database db = await this.db;
    var result = await db.rawQuery("Select * from $tblFoods");
    return result;
  }

  Future<List> getSepetiSiparisNoVeCariIdIle(int siparisNo, int cariId) async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "Select * from $tblFoods where $colSiparisNo=$siparisNo and $colCariId=$cariId");
    return result;
  }

  Future<List> getSepetiSiparisNoCariIdVeKullaniciIdIle(
      int siparisNo, int cariId, int kullaniciId) async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "Select * from $tblFoods where $colSiparisNo=$siparisNo and $colCariId=$cariId and $colKullaniciId=$kullaniciId");
    return result;
  }

  Future<int> cariSepetKontrol(int kullaniciId, int cariId) async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(await db.rawQuery(
        "Select count(*) from $tblFoods where $colKullaniciId=$kullaniciId and $colCariId=$cariId"));
    return result;
  }

  Future<int> carininSonSiparisNoSu(int kullaniciId, int cariId) async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(await db.rawQuery(
        "Select max($colSiparisNo) from $tblFoods where $colKullaniciId=$kullaniciId and $colCariId=$cariId"));
    return result;
  }

  Future<List> getCarininBekleyenSepetOzetlerini(int kullaniciId, int cariId) async {
    Database db = await this.db;
    var result = await db.rawQuery('''
    Select s.siparisNo,s.kullaniciId,s.cariId,s.cariKod,s.cariUnvan,
    count(s.stoKod) as urunCesit, sum(s.birimFiyat) as toplamTutar, min(s.tarih) as tarih
    from $tblFoods as s 
    where s.$colKullaniciId=$kullaniciId and s.$colCariId=$cariId
    group by s.siparisNo,s.kullaniciId,s.cariId,s.cariKod,s.cariUnvan
    ''');
    return result;
  } */

  Future close() async => _db.close();
}
