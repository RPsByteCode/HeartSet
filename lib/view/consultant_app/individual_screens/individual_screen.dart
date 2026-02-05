// import 'package:flutter/material.dart';

// class IndividualScreen extends StatelessWidget {
//   const IndividualScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: const Color(0xFFF8FAFF),
//       child: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           _buildTableHeader(),
//           const SizedBox(height: 10),
//           _buildPatientRow("Marcus Aurelius", "ACTIVE", "Oct 22, 2023", Colors.red, true),
//           _buildPatientRow("Elena Gilbert", "ACTIVE", "Oct 19, 2023", Colors.amber, true),
//           _buildPatientRow("David Goggins", "ON BREAK", "Sep 12, 2023", Colors.green, false),
//           const SizedBox(height: 40),
//           const Center(
//             child: Text("END OF DIRECTORY", 
//               style: TextStyle(color: Colors.grey, fontSize: 12, letterSpacing: 1.2)),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTableHeader() {
//     return const Padding(
//       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(flex: 3, child: Text("NAME", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.blueGrey))),
//           Expanded(flex: 2, child: Text("STATUS", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.blueGrey))),
//           Expanded(flex: 2, child: Text("LAST VISIT", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.blueGrey))),
//           Expanded(flex: 1, child: Text("RISK", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.blueGrey))),
//           Expanded(flex: 1, child: Text("ACTIONS", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.blueGrey))),
//         ],
//       ),
//     );
//   }

//   Widget _buildPatientRow(String name, String status, String date, Color riskColor, bool isActive) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 2),
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         border: Border(bottom: BorderSide(color: Color(0xFFF0F0F0))),
//       ),
//       child: Row(
//         children: [
//           Expanded(flex: 3, child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
//           Expanded(
//             flex: 2,
//             child: UnconstrainedBox(
//               alignment: Alignment.centerLeft,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: isActive ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 child: Text(status, style: TextStyle(color: isActive ? Colors.green : Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
//               ),
//             ),
//           ),
//           Expanded(flex: 2, child: Text(date, style: const TextStyle(color: Colors.grey, fontSize: 13))),
//           Expanded(flex: 1, child: Icon(Icons.circle, color: riskColor, size: 14)),
//           const Expanded(
//             flex: 1,
//             child: Row(
//               children: [
//                 Icon(Icons.visibility_outlined, size: 20, color: Color(0xFF006064)),
//                 SizedBox(width: 8),
//                 Icon(Icons.chat_bubble_outline, size: 18, color: Colors.grey),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }










import 'package:flutter/material.dart';

class IndividualScreen extends StatelessWidget {
  const IndividualScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    // Determine a minimum width for the table to prevent squishing on tiny phones
    final double minTableWidth = screenWidth > 600 ? screenWidth : 500;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Allow horizontal scroll on very small screens
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: minTableWidth),
              child: Container(
                width: screenWidth > 600 ? screenWidth : 600, // Fixed width for mobile, fluid for tablet
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTableHeader(),
                    const SizedBox(height: 10),
                    _buildPatientRow("Marcus Aurelius", "ACTIVE", "Oct 22, 2023", Colors.red, true),
                    _buildPatientRow("Elena Gilbert", "ACTIVE", "Oct 19, 2023", Colors.amber, true),
                    _buildPatientRow("David Goggins", "ON BREAK", "Sep 12, 2023", Colors.green, false),
                    const SizedBox(height: 40),
                    const Center(
                      child: Text("END OF DIRECTORY",
                          style: TextStyle(color: Colors.grey, fontSize: 12, letterSpacing: 1.2)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Column Flex logic defined once to keep header and rows perfectly aligned
  static const int nameFlex = 3;
  static const int statusFlex = 2;
  static const int dateFlex = 3;
  static const int riskFlex = 1;
  static const int actionFlex = 2;

  Widget _buildTableHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Expanded(flex: nameFlex, child: Text("NAME", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.blueGrey))),
          Expanded(flex: statusFlex, child: Text("STATUS", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.blueGrey))),
          Expanded(flex: dateFlex, child: Text("LAST VISIT", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.blueGrey))),
          Expanded(flex: riskFlex, child: Center(child: Text("RISK", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.blueGrey)))),
          Expanded(flex: actionFlex, child: Text("ACTIONS", textAlign: TextAlign.right, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.blueGrey))),
        ],
      ),
    );
  }

  Widget _buildPatientRow(String name, String status, String date, Color riskColor, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16), // Slightly reduced vertical padding
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFF0F0F0))),
      ),
      child: Row(
        children: [
          // Name Column
          Expanded(
            flex: nameFlex,
            child: Text(name, 
              overflow: TextOverflow.ellipsis, // Prevent long names from breaking layout
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)
            )
          ),
          
          // Status Column
          Expanded(
            flex: statusFlex,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isActive ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(status, style: TextStyle(color: isActive ? Colors.green : Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          
          // Date Column
          Expanded(
            flex: dateFlex, 
            child: Text(date, style: const TextStyle(color: Colors.grey, fontSize: 13))
          ),
          
          // Risk Column
          Expanded(
            flex: riskFlex, 
            child: Icon(Icons.circle, color: riskColor, size: 14)
          ),
          
          // Actions Column
          Expanded(
            flex: actionFlex,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(Icons.visibility_outlined, size: 20, color: Color(0xFF006064)),
                  onPressed: () {},
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(Icons.chat_bubble_outline, size: 18, color: Colors.grey),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}