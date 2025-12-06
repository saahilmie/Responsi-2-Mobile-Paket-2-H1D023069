import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../helpers/api.dart';
import '../model/inventaris.dart';

class InventarisForm extends StatefulWidget {
  final Inventaris? inventaris;

  const InventarisForm({Key? key, this.inventaris}) : super(key: key);

  @override
  State<InventarisForm> createState() => _InventarisFormState();
}

class _InventarisFormState extends State<InventarisForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _hargaController = TextEditingController();
  final _jumlahController = TextEditingController();
  final _tanggalMasukController = TextEditingController();
  final _tanggalKedaluwarsaController = TextEditingController();

  bool _isLoading = false;
  bool _isEdit = false;
  String _judul = 'Tambah Inventaris Khonsaa';
  String _tombolSubmit = 'SIMPAN';

  @override
  void initState() {
    super.initState();
    _checkEditMode();
  }

  void _checkEditMode() {
    if (widget.inventaris != null) {
      setState(() {
        _isEdit = true;
        _judul = 'Ubah Inventaris Khonsaa';
        _tombolSubmit = 'UBAH';
        _namaController.text = widget.inventaris!.nama ?? '';
        _hargaController.text = widget.inventaris!.harga?.toString() ?? '';
        _jumlahController.text = widget.inventaris!.jumlah?.toString() ?? '';
        _tanggalMasukController.text = widget.inventaris!.tanggalMasuk ?? '';
        _tanggalKedaluwarsaController.text = widget.inventaris!.tanggalKedaluwarsa ?? '';
      });
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _hargaController.dispose();
    _jumlahController.dispose();
    _tanggalMasukController.dispose();
    _tanggalKedaluwarsaController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF8da750),
              onPrimary: Colors.white,
              onSurface: Color(0xFF537b2f),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final data = {
      'nama': _namaController.text,
      'harga': int.parse(_hargaController.text),
      'jumlah': int.parse(_jumlahController.text),
      'tanggal_masuk': _tanggalMasukController.text,
      'tanggal_kedaluwarsa': _tanggalKedaluwarsaController.text,
    };

    dynamic response;
    if (_isEdit) {
      response = await Api.put('/inventaris/${widget.inventaris!.id}', data);
    } else {
      response = await Api.post('/inventaris', data);
    }

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (response['code'] == 200 && response['status'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isEdit ? 'Data berhasil diubah' : 'Data berhasil ditambahkan'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['data']?.toString() ?? 'Gagal menyimpan data'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf5f8f2),
      appBar: AppBar(
        title: Text(_judul),
        backgroundColor: const Color(0xFF8da750),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Informasi Bahan Makanan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF537b2f),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _namaController,
                          decoration: InputDecoration(
                            labelText: 'Nama Bahan Makanan',
                            hintText: 'Contoh: Beras Premium',
                            prefixIcon: const Icon(Icons.shopping_basket),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFF8da750), width: 2),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nama harus diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _hargaController,
                          decoration: InputDecoration(
                            labelText: 'Harga (Rp)',
                            hintText: 'Contoh: 85000',
                            prefixIcon: const Icon(Icons.attach_money),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFF8da750), width: 2),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Harga harus diisi';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Harga harus berupa angka';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _jumlahController,
                          decoration: InputDecoration(
                            labelText: 'Jumlah Stok',
                            hintText: 'Contoh: 50',
                            prefixIcon: const Icon(Icons.inventory),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFF8da750), width: 2),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Jumlah harus diisi';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Jumlah harus berupa angka';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tanggal',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF537b2f),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _tanggalMasukController,
                          decoration: InputDecoration(
                            labelText: 'Tanggal Masuk',
                            hintText: 'Pilih tanggal',
                            prefixIcon: const Icon(Icons.calendar_today),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.date_range),
                              onPressed: () => _selectDate(_tanggalMasukController),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFF8da750), width: 2),
                            ),
                          ),
                          readOnly: true,
                          onTap: () => _selectDate(_tanggalMasukController),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Tanggal masuk harus diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _tanggalKedaluwarsaController,
                          decoration: InputDecoration(
                            labelText: 'Tanggal Kedaluwarsa',
                            hintText: 'Pilih tanggal',
                            prefixIcon: const Icon(Icons.warning_amber_rounded),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.date_range),
                              onPressed: () => _selectDate(_tanggalKedaluwarsaController),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFF8da750), width: 2),
                            ),
                          ),
                          readOnly: true,
                          onTap: () => _selectDate(_tanggalKedaluwarsaController),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Tanggal kedaluwarsa harus diisi';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF537b2f),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          _tombolSubmit,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}