import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:dart_twitter_api/twitter_api.dart';
import 'package:get/get.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:twitter_login/twitter_login.dart';

import '../classes/spotify.dart';
import '../classes/user.dart';

class UserController extends GetxController {
  MyUser usr = MyUser(isLogin: ValueNotifier<bool>(false));

  Future login() async {
    final twitterLogin = TwitterLogin(
      // Consumer API keys
      apiKey: '',
      // Consumer API Secret keys
      apiSecretKey: '',
      // Registered Callback URLs in TwitterApp
      // Android is a deeplink
      // iOS is a URLScheme
      redirectURI: '',
    );
    return await twitterLogin.login().then((value) async {
      switch (value.status) {
        case TwitterLoginStatus.loggedIn:
          // success
          usr.authToken = value.authToken;
          usr.authTokenSecret = value.authTokenSecret;
          usr.profileImage = value.user!.thumbnailImage.replaceAll("_normal", "");
          usr.username = value.user!.screenName;
          final twitterApi = TwitterApi(
              client: TwitterClient(
                  consumerKey: "",
                  consumerSecret:
                      "",
                  token: value.authToken!,
                  secret: value.authTokenSecret!));
          final userInfos = await twitterApi.client.get(Uri.https(
              'api.twitter.com', '1.1/account/verify_credentials.json'));
          Map valueMap = json.decode(userInfos.body);
          usr.bio = valueMap["description"];
          usr.newBio = valueMap["description"];
          usr.spotifyKey = await SpotifySdk.getAccessToken(
              clientId: "",
              redirectUrl: "",
              scope: "user-read-currently-playing");
          usr.isLogin.value = true;
          changeBio();
          break;

        case TwitterLoginStatus.cancelledByUser:
          // cancel
          return "Giriş Kullanıcı Tarafından İptal Edildi";
        case TwitterLoginStatus.error:
          return "Hata Oluştu";
        case null:
          return "Hata Oluştu";
      }
    });
  }

  Future changeBio() async {
    final twitterApi = TwitterApi(
        client: TwitterClient(
            consumerKey: "",
            consumerSecret:
                "",
            token: usr.authToken!,
            secret: usr.authTokenSecret!));
    var url = Uri.https('api.spotify.com', '/v1/me/player/currently-playing');
    var response = await http.get(url,headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${usr.spotifyKey!}'
    });
    if (response.statusCode == 200) {
      var sptf = Spotify.fromJson(jsonDecode(response.body));
      if (sptf.currentlyPlayingType == "track" && sptf.isPlaying!) {
        usr.newBio = "🎧 ${sptf.item!.artists![0].name!} - ${sptf.item!.name!}";
        await twitterApi.client.post(
            Uri.https('api.twitter.com', '1.1/account/update_profile.json'),
            body: <String, String>{'description': usr.newBio!});
      } else {
        usr.newBio = usr.bio;
        await twitterApi.client.post(
            Uri.https('api.twitter.com', '1.1/account/update_profile.json'),
            body: <String, String>{'description': usr.bio!});
      }
    }
  }
  Future logout() async{
    final twitterApi = TwitterApi(
        client: TwitterClient(
            consumerKey: "",
            consumerSecret:
            "",
            token: usr.authToken!,
            secret: usr.authTokenSecret!));
    await twitterApi.client.post(
        Uri.https('api.twitter.com', '1.1/account/update_profile.json'),
        body: <String, String>{'description': usr.bio!});
  }
}
