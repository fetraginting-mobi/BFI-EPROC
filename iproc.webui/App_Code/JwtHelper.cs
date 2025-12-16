using System;
using System.Text;

public class JwtHelper
{
    public static string DecodeJwtPayload(string jwt)
    {
        string[] parts = jwt.Split('.');
        if (parts.Length < 2)
            throw new Exception("Invalid JWT");

        string payload = parts[1]
            .Replace('-', '+')
            .Replace('_', '/');

        switch (payload.Length % 4)
        {
            case 0: break;
            case 2: payload += "=="; break;
            case 3: payload += "="; break;
            default: throw new Exception("Invalid Base64URL payload");
        }

        byte[] bytes = Convert.FromBase64String(payload);
        return Encoding.UTF8.GetString(bytes);
    }
}
