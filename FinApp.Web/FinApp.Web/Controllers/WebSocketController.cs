using Microsoft.AspNetCore.Mvc;
using System.Net.WebSockets;
using System.Text;

[Route("api/[controller]")]
[ApiController]
public class WebSocketController : ControllerBase
{
    private static List<WebSocket> _connectedSockets = new List<WebSocket>();
    private static object _lock = new object();

    [HttpGet("ws")]
    public async Task<IActionResult> GetWebSocket()
    {
        if (HttpContext.WebSockets.IsWebSocketRequest)
        {
            var webSocket = await HttpContext.WebSockets.AcceptWebSocketAsync();

            // Add the WebSocket to the list
            lock (_lock)
            {
                _connectedSockets.Add(webSocket);
            }

            // Handle WebSocket connections
            await HandleWebSocketConnection(webSocket);

            return new EmptyResult(); // WebSocket handled, return an empty result
        }
        else
        {
            return BadRequest("WebSocket requests only.");
        }
    }

    private async Task HandleWebSocketConnection(WebSocket webSocket)
    {
        try
        {
            // Your WebSocket handling logic goes here
            // For example, you can listen for incoming messages and send responses

            byte[] buffer = new byte[1024];
            WebSocketReceiveResult result = await webSocket.ReceiveAsync(new ArraySegment<byte>(buffer), CancellationToken.None);

            while (!result.CloseStatus.HasValue)
            {
                // Handle the received message (if needed)

                // Continue listening for the next message
                result = await webSocket.ReceiveAsync(new ArraySegment<byte>(buffer), CancellationToken.None);
            }

            // Remove the WebSocket from the list when the connection is closed
            lock (_lock)
            {
                _connectedSockets.Remove(webSocket);
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"WebSocket error: {ex.Message}");
        }
    }

    public static async Task NotifyClients(string message)
    {
        byte[] data = Encoding.UTF8.GetBytes(message);
        List<WebSocket> sockets;

        lock (_lock)
        {
            // Make a copy of the list to avoid modifying it while iterating
            sockets = new List<WebSocket>(_connectedSockets);
        }

        foreach (var socket in sockets)
        {
            try
            {
                await socket.SendAsync(new ArraySegment<byte>(data), WebSocketMessageType.Text, true, CancellationToken.None);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error sending WebSocket message: {ex.Message}");
            }
        }
    }

}
