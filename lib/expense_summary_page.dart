import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseSummaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEBB812),
        title: Text(
          "Expense Summary",
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFFEBB812)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.account_circle, size: 50, color: Colors.white),
                  SizedBox(height: 10),
                  Text("User Name", style: GoogleFonts.poppins(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                  Text("user@example.com", style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70)),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text("Dashboard", style: GoogleFonts.poppins()),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.pie_chart),
              title: Text("View Expenses", style: GoogleFonts.poppins()),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings", style: GoogleFonts.poppins()),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Logout", style: GoogleFonts.poppins(color: Colors.red)),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: _fetchExpenses(),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No expenses recorded.", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500)));
          }

          double totalAmount = snapshot.data!["total"];
          Map<String, double> categoryWise = snapshot.data!["categories"];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Expenses",
                  style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                SizedBox(height: 10),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    title: Text("Total Amount", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                    subtitle: Text(
                      "\$${totalAmount.toStringAsFixed(2)}",
                      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.redAccent),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Category-wise Breakdown",
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView(
                    children: categoryWise.entries.map((entry) {
                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        child: ListTile(
                          title: Text(entry.key, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500)),
                          trailing: Text(
                            "\$${entry.value.toStringAsFixed(2)}",
                            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<Map<String, dynamic>> _fetchExpenses() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('expenses').get();

    double totalAmount = 0;
    Map<String, double> categoryWise = {};

    for (var doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      double amount = (data['amount'] ?? 0).toDouble();
      String category = data['category'] ?? 'Uncategorized';

      totalAmount += amount;
      categoryWise[category] = (categoryWise[category] ?? 0) + amount;
    }

    return {"total": totalAmount, "categories": categoryWise};
  }
}
