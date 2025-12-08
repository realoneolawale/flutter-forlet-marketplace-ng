import 'package:signalr_netcore_plus/hub_connection.dart';
import 'package:signalr_netcore_plus/hub_connection_builder.dart';

class ArtisanHub {
  final hubConnection = HubConnectionBuilder()
      .withUrl('https://forlet.com.ng/artisanchathub')
      .withAutomaticReconnect() // optional, reconnects automatically
      .build();
  ArtisanHub() {
    // initialize the connection
    initializeConnection();
  }

  void ReceiveMessage() {
    hubConnection.on(
        'ReceiveMessage',
        (receiverUserId, message, base64String, date) {
          if (base64String != null) {
            // there is image
          }
          print('New message: ${message![0]}'); // message is a List<dynamic>
        } as MethodInvocationFunc);
  }

  Future<void> initializeConnection() async {
    await hubConnection.start();
    print('CONNECTED: SignalR Connected!');
    // other connection issues
    hubConnection.onclose(({error}) {
      print('Connection closed. Error: $error');
    } as ClosedCallback);
    hubConnection.onreconnecting(({error}) {
      print('Reconnecting... Error: $error');
    } as ReconnectingCallback);
    hubConnection.onreconnected(({connectionId}) {
      print('Reconnected! Connection ID: $connectionId');
    } as ReconnectedCallback);
  }
}
