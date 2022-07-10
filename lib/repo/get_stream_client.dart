import 'package:chatter/app.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

final getStreamClientProvider = Provider<StreamChatClient>((ref) {
  return StreamChatClient(streamKey);
});
