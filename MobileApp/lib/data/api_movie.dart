import 'dart:convert';
import 'package:INGSW_MezMar/config/config.dart';
import 'package:INGSW_MezMar/models/movie_list.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class MovieRepository {
  Future<MovieList> getMovies(int currentPage) async {
    var url = Config.apiTMDB +
        'discover/movie?api_key=' +
        Config.apiKeyTMDB +
        '&language=' +
        Config.language +
        '&page=' +
        currentPage.toString();

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return MovieList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Faild to load');
    }
  }

  dynamic addMovieList(int movieId, String type) async {
    final prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> decodedToken =
        JwtDecoder.decode(prefs.getString('token'));

    Map data = {
      'user_id': decodedToken['id'],
      'movie_id': movieId,
      'type': type
    };

    print(Config.apiUrl + '/list/add');
    var body = json.encode(data);

    // Future<http.Response> response = http.post({url: ''});
    var response = await http.post(Config.apiUrl + '/list/add',
        headers: {
          'Authorization': prefs.getString('token'),
          'Content-type': 'application/json',
        },
        body: body);

    var res = json.decode(response.body);

    String message = res['message'];

    return message;
  }
}
