import 'dart:convert';
import 'package:INGSW_MezMar/config/config.dart';
import 'package:INGSW_MezMar/models/movie_list.dart';
import 'package:INGSW_MezMar/models/movie_list_prefer_to_see.dart';
import 'package:INGSW_MezMar/models/reviews_list.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class MovieRepository {
  Future<MovieList> getMovies(int currentPage, String query) async {
    var url = Config.apiTMDB +
        'discover/movie?api_key=' +
        Config.apiKeyTMDB +
        '&language=' +
        Config.language +
        '&page=' +
        currentPage.toString();

    if (query.isNotEmpty && query != '') {
      url = Config.apiTMDB +
          'search/movie?api_key=' +
          Config.apiKeyTMDB +
          '&language=' +
          Config.language +
          '&page=' +
          currentPage.toString() +
          '&query=' +
          query;
    }

    print(url);
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

    var body = json.encode(data);

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

  Future<MovieListPreferToSee> getMyMovieList(String type) async {
    final prefs = await SharedPreferences.getInstance();

    String url = Config.apiUrl + '/list?type=' + type;

    final response = await http
        .get(url, headers: {"Authorization": prefs.getString('token')});

    if (response.statusCode == 200) {
      return MovieListPreferToSee.fromJson(json.decode(response.body));
    } else {
      throw Exception('Faild to load');
    }
  }

  dynamic removeMovieList(int movieId, String type) async {
    final prefs = await SharedPreferences.getInstance();

    await http.delete(
        Config.apiUrl + '/list/remove/' + movieId.toString() + '/' + type,
        headers: {
          'Authorization': prefs.getString('token'),
          'Content-type': 'application/json',
        });
  }

  Future<Map<String, dynamic>> addReview(
      int movieId, String title, String description, int valutation) async {
    final prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> data = {
      'movie_id': movieId,
      'title': title,
      'description': description,
      'valutation': valutation,
    };

    var body = json.encode(data);

    var response = await http.post(Config.apiUrl + '/reviews/add',
        headers: {
          'Authorization': prefs.getString('token'),
          'Content-type': 'application/json',
        },
        body: body);

    return json.decode(response.body);
  }

  Future<ReviewsList> getReviewsByMovie(int movieId, int currentPage) async {
    final prefs = await SharedPreferences.getInstance();

    var url = Config.apiUrl +
        '/reviews/list?movie_id=' +
        movieId.toString() +
        '&page=' +
        currentPage.toString();

    final response = await http
        .get(url, headers: {"Authorization": prefs.getString('token')});

    if (response.statusCode == 200) {
      return ReviewsList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Faild to load');
    }
  }
}
