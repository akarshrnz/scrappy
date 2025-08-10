import 'package:intl/intl.dart';
import 'package:scrappy/core/utils/appUrls.dart';

final String rupeeSymbol="₹";


String formatDate(String dateString) {
  try {
    // Parse the input date string
    DateTime dateTime = DateTime.parse(dateString);

    // Format the date in the desired format
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

    return formattedDate;
  } catch (e) {
    // Handle the case where parsing fails
    return '';
  }
}

getImageUrl(String imageUrl){
  return "${AppApi.baseUrlImage}/${imageUrl}";
}