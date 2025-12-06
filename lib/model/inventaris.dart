class Inventaris {
  int? id;
  int? memberId;
  String? nama;
  int? harga;
  int? jumlah;
  String? tanggalMasuk;
  String? tanggalKedaluwarsa;

  Inventaris({
    this.id,
    this.memberId,
    this.nama,
    this.harga,
    this.jumlah,
    this.tanggalMasuk,
    this.tanggalKedaluwarsa,
  });

  factory Inventaris.fromJson(Map<String, dynamic> json) {
    return Inventaris(
      id: int.parse(json['id'].toString()),
      memberId: int.parse(json['member_id'].toString()),
      nama: json['nama'],
      harga: int.parse(json['harga'].toString()),
      jumlah: int.parse(json['jumlah'].toString()),
      tanggalMasuk: json['tanggal_masuk'],
      tanggalKedaluwarsa: json['tanggal_kedaluwarsa'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'harga': harga,
      'jumlah': jumlah,
      'tanggal_masuk': tanggalMasuk,
      'tanggal_kedaluwarsa': tanggalKedaluwarsa,
    };
  }
}