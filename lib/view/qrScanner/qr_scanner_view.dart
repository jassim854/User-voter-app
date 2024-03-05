// import 'package:flutter/material.dart';

// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:voter_app/view/qrScanner/candidate-view.dart';

// class QRCodeScanner extends StatefulWidget {
//   const QRCodeScanner({Key? key}) : super(key: key);

//   @override
//   State<QRCodeScanner> createState() => _QRCodeScannerState();
// }

// class _QRCodeScannerState extends State<QRCodeScanner> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   late QRViewController controller;
//   bool torchEnabled = false;
//   CameraFacing currentCameraFacing =
//       CameraFacing.back; // Initially set to the back camera

//   @override
//   Widget build(BuildContext context) {
//     var scanArea = (MediaQuery.of(context).size.width < 400 ||
//             MediaQuery.of(context).size.height < 400)
//         ? 200.0
//         : 300.0;
//     return Scaffold(
//       body: Stack(
//         children: [
//           QRView(
//             key: qrKey,
//             overlay: QrScannerOverlayShape(
//                 borderColor: Colors.black,
//                 borderRadius: 10,
//                 borderLength: 30,
//                 borderWidth: 5,
//                 cutOutSize: scanArea),
//             onQRViewCreated: _onQRViewCreated,
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(
//                   left: 15,
//                   right: 15,
//                   top: 40,
//                   bottom: 30,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       width: 70,
//                       height: 50,
//                       color: Colors.grey,
//                       child: IconButton(
//                         icon: const Icon(Icons.cameraswitch_outlined),
//                         onPressed: _toggleCameraFacing,
//                       ),
//                     ),
//                     Container(
//                       width: 70,
//                       height: 50,
//                       color: Colors.grey, // Replace with your color
//                       child: IconButton(
//                         icon: const Icon(Icons.lightbulb),
//                         onPressed: _toggleTorch,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text(
//                   'Place a QR code inside the viewfinder rectangle to scan',
//                   style: TextStyle(fontSize: 15, color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       print("QR Code Data: ${scanData.code}");
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const CandidateView()),
//       );
//       controller.dispose();
//     });
//   }

//   void _toggleCameraFacing() {
//     setState(() {
//       currentCameraFacing = (currentCameraFacing == CameraFacing.back)
//           ? CameraFacing.front
//           : CameraFacing.back;
//       controller.flipCamera();
//     });
//   }

//   void _toggleTorch() {
//     setState(() {
//       torchEnabled = !torchEnabled;
//       controller.toggleFlash();
//     });
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
// }