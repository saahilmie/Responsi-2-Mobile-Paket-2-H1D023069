import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../helpers/api.dart';
import '../helpers/user_info.dart';
import '../model/inventaris.dart';
import 'inventaris_form.dart';
import 'inventaris_detail.dart';
import 'login_page.dart';

class InventarisPage extends StatefulWidget {
  const InventarisPage({Key? key}) : super(key: key);

  @override
  State<InventarisPage> createState() => _InventarisPageState();
}

class _InventarisPageState extends State<InventarisPage> {
  List<Inventaris> _inventarisList = [];
  bool _isLoading = false;
  String? _userName;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadInventaris();
  }

  Future<void> _loadUserName() async {
    final nama = await UserInfo.getNama();
    setState(() => _userName = nama);
  }

  Future<void> _loadInventaris() async {
    setState(() => _isLoading = true);

    final response = await Api.get('/inventaris');

    setState(() => _isLoading = false);

    if (response['code'] == 200 && response['status'] == true) {
      final List<dynamic> data = response['data'];
      setState(() {
        _inventarisList = data.map((json) => Inventaris.fromJson(json)).toList();
      });
    } else if (response['code'] == 401) {
      if (!mounted) return;
      _handleLogout();
    }
  }

  Future<void> _handleLogout() async {
    await UserInfo.logout();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Logout'),
        content: const Text('Apakah Anda yakin ingin keluar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _handleLogout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

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

      if (difference < 0) return Colors.red; // Expired
      if (difference <= 7) return Colors.orange; // Soon expired
      if (difference <= 30) return Colors.yellow[700]!; // Warning
      return Colors.green; // Fresh
    } catch (e) {
      return Colors.grey;
    }
  }

  String _getStatusText(String tanggalKedaluwarsa) {
    try {
      final expDate = DateFormat('yyyy-MM-dd').parse(tanggalKedaluwarsa);
      final now = DateTime.now();
      final difference = expDate.difference(now).inDays;

      if (difference < 0) return 'Kadaluwarsa';
      if (difference == 0) return 'Kadaluwarsa Hari Ini';
      if (difference <= 7) return '$difference hari lagi';
      if (difference <= 30) return '$difference hari lagi';
      return 'Masih Segar';
    } catch (e) {
      return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf5f8f2),
      appBar: AppBar(
        title: Text('Inventaris Bahan ${_userName ?? ''}'),
        backgroundColor: const Color(0xFF8da750),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadInventaris,
            tooltip: 'Refresh',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _showLogoutConfirmation,
            tooltip: 'Logout',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InventarisForm(),
            ),
          );
          _loadInventaris();
        },
        backgroundColor: const Color(0xFF537b2f),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF8da750),
              ),
            )
          : _inventarisList.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.storefront_outlined,
                        size: 100,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Belum ada data inventaris',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap tombol + untuk menambah',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadInventaris,
                  color: const Color(0xFF8da750),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _inventarisList.length,
                    itemBuilder: (context, index) {
                      final item = _inventarisList[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InventarisDetail(
                                  inventaris: item,
                                ),
                              ),
                            );
                            _loadInventaris();
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF8da750).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(
                                        Icons.storefront
,
                                        color: Color(0xFF8da750),
                                        size: 28,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.nama ?? '-',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF537b2f),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            _formatCurrency(item.harga ?? 0),
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey[700],
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF8da750),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        'Stok: ${item.jumlah}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                const Divider(),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 16,
                                      color: Colors.grey[600],
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Masuk: ${item.tanggalMasuk}',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.warning_amber_rounded,
                                      size: 16,
                                      color: _getStatusColor(item.tanggalKedaluwarsa ?? ''),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Exp: ${item.tanggalKedaluwarsa}',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(item.tanggalKedaluwarsa ?? '')
                                            .withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        _getStatusText(item.tanggalKedaluwarsa ?? ''),
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: _getStatusColor(item.tanggalKedaluwarsa ?? ''),
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
                    },
                  ),
                ),
    );
  }
}