using Microsoft.IdentityModel.Tokens;
using StudentAttendanceAPI.Response;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace StudentAttendanceAPI.Helpers
{
    public class JwtHelper
    {
        /// <summary>
        /// Generate JWT Token
        /// </summary>
        /// <param name="response"></param>
        /// <param name="jwtKey"></param>
        /// <param name="jwtIssuer"></param>
        /// <param name="jwtAudience"></param>
        /// <returns></returns>
        public string GenerateJwtToken(LoginResponse response, byte[] jwtKey, string jwtIssuer, string jwtAudience)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[]
                {
                new Claim(ClaimTypes.Name, response.UserName),
                new Claim("UserId", response.UserId.ToString())
            }),
                Expires = DateTime.UtcNow.AddHours(2),
                Issuer = jwtIssuer,
                Audience = jwtAudience,
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(jwtKey), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }
    }
}
