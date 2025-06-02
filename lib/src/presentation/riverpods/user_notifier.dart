import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_notifier.g.dart';

@Riverpod(keepAlive: false)
class UserNotifier extends _$UserNotifier {
  @override
  UserState build() {
    return const UserState();
  }

  void setUserName(String userName) {
    state = state.copyWith(userName: userName);
  }

  void setImageUrl(String imageUrl) {
    state = state.copyWith(imageUrl: imageUrl);
  }
}

class UserState {
  final String? userName;
  final String? imageUrl;

  const UserState({this.userName, this.imageUrl});

  UserState copyWith({String? userName, String? imageUrl}) {
    return UserState(
      userName: userName ?? this.userName,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
