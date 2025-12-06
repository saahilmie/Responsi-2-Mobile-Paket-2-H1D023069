import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../helpers/api.dart';
import '../model/inventaris.dart';
import 'inventaris_form.dart';

class InventarisDetail extends StatefulWidget {
  final Inventaris inventaris;

  const InventarisDetail({Key? key, required this.inventaris}) : super(key: key);

  @override
  State<InventarisDetail> createState() => _InventarisDetailState();
}

class _InventarisDetailState extends State<InventarisDetail> {
  bool _isDeleting = false;

  String _formatCurrency(int amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  Color _getStatusColor(String tanggalKedaluwarsa) {
    try {
      final expDate = DateFormat('yyyy-MM-dd').parse(tanggalKedaluwarsa);
      final now = DateTime.now();
      final difference = expDate.difference(now).inDays;

      if (difference < 0) return Colors.red;
      if (difference <= 7) return Colors.orange;
      if (difference <= 30) return Colors.yellow[700]!;
      return Colors.green;
    } catch (e) {
      return Colors.grey;
    }
  }

  String _getStatusText(String tanggalKedaluwarsa) {
    try {
      final expDate = DateFormat('yyyy-MM-dd').parse(tanggalKedaluwarsa);
      final now = DateTime.now();
      final difference = expDate.difference(now).inDays;

      if (difference < 0) return 'KADALUWARSA';
      if (difference == 0) return 'KADALUWARSA HARI INI!';
      if (difference <= 7) return 'SEGERA KADALUWARSA ($difference hari)';
      if (difference <= 30) return 'Perhatian: $difference hari lagi';
      return 'Kondisi Baik';
    } catch (e) {
      return 'Unknown';
    }
  }

  Future<void> _confirmDelete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: Text('Apakah Anda yakin ingin menghapus "${widget.inventaris.nama}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      _deleteInventaris();
    }
  }

  Future<void> _deleteInventaris() async {
    setState(() => _isDeleting = true);

    final response = await Api.delete('/inventaris/${widget.inventaris.id}');

    setState(() => _isDeleting = false);

    if (!mounted) return;

    if (response['code'] == 200 && response['status'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data berhasil dihapus'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['data']?.toString() ?? 'Gagal menghapus data'),
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
        title: const Text('Detail Inventaris Khonsaa'),
        backgroundColor: const Color(0xFF8da750),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InventarisForm(
                    inventaris: widget.inventaris,
                  ),
                ),
              );
              if (result == true) {
                if (!mounted) return;
                Navigator.pop(context, true);
              }
            },
            tooltip: 'Edit',
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _isDeleting ? null : _confirmDelete,
            tooltip: 'Hapus',
          ),
        ],
      ),
      body: _isDeleting
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF8da750),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Status Card
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: _getStatusColor(widget.inventaris.tanggalKedaluwarsa ?? ''),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: Colors.white,
                              size: 32,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _getStatusText(widget.inventaris.tanggalKedaluwarsa ?? ''),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Main Info Card
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: const Color(0xFF8da750).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Icons.shopping_basket,
                                size: 50,
                                color: Color(0xFF8da750),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              widget.inventaris.nama ?? '-',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF537b2f),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _formatCurrency(widget.inventaris.harga ?? 0),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF8da750),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'Stok: ${widget.inventaris.jumlah} unit',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Date Info Card
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
                              'Informasi Tanggal',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF537b2f),
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildInfoRow(
                              icon: Icons.calendar_today,
                              label: 'Tanggal Masuk',
                              value: widget.inventaris.tanggalMasuk ?? '-',
                              color: Colors.blue,
                            ),
                            const Divider(height: 24),
                            _buildInfoRow(
                              icon: Icons.warning_amber_rounded,
                              label: 'Tanggal Kedaluwarsa',
                              value: widget.inventaris.tanggalKedaluwarsa ?? '-',
                              color: _getStatusColor(widget.inventaris.tanggalKedaluwarsa ?? ''),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InventarisForm(
                                    inventaris: widget.inventaris,
                                  ),
                                ),
                              );
                              if (result == true) {
                                if (!mounted) return;
                                Navigator.pop(context, true);
                              }
                            },
                            icon: const Icon(Icons.edit),
                            label: const Text('EDIT'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF8da750),
                              side: const BorderSide(color: Color(0xFF8da750), width: 2),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _isDeleting ? null : _confirmDelete,
                            icon: const Icon(Icons.delete),
                            label: const Text('HAPUS'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF537b2f),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}