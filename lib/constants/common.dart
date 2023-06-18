// const String urlPrefix = "https://daystar-backend-atrocious-jpg.vercel.app";
// For local development

import 'package:academia/models/user.dart';
import 'package:hive/hive.dart';

const String urlPrefix = "https://daystar-backend.onrender.com";
const String dbName = "appDB";
User user = User();
late Box appDB;

// extension StringExtension on String {
//     String capitalize() {
//       return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
//     }
// }
