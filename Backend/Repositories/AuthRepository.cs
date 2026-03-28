using MySql.Data.MySqlClient;
using StudentAttendanceAPI.Helpers;
using System.Data;
using StudentAttendanceAPI.Request;
using StudentAttendanceAPI.Response;

namespace StudentAttendanceAPI.Repositories
{
    public interface IAuthRepository
    {
        /// <summary>
        /// User Login
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        Task<LoginResponse> UserAuthenticate(LoginRequest request);
    }
    public class AuthRepository : IAuthRepository
    {
        private readonly IConfiguration _configuration;
        public AuthRepository(IConfiguration configuration) 
        {
            _configuration = configuration;
        }

        /// <summary>
        /// User Login
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        public async Task<LoginResponse> UserAuthenticate(LoginRequest request)
        {
            using var connection = new MySqlConnection(_configuration.GetConnectionString("DefaultConnection"));
            await connection.OpenAsync();

            using var command = new MySqlCommand("sp_ValidateUser", connection)
            {
                CommandType = CommandType.StoredProcedure
            };
            request.Password = EncryptDecrypt.Encrypt(request.Password);
            command.Parameters.AddWithValue("@p_UserName", request.Username);
            command.Parameters.AddWithValue("@p_Password", request.Password);

            LoginResponse res = new LoginResponse();

            using (var reader = await command.ExecuteReaderAsync())
            {
                if (await reader.ReadAsync())
                {
                    res.UserName = reader?.GetString("UserName") ?? null;
                    res.UserId = reader?.GetInt32("UserId") ?? 0;
                }
            }

            if (res.UserName != null && res.UserId > 0) {
                using var cmd = new MySqlCommand("sp_CheckUserPermission", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@p_UserId", res.UserId);
                using var rdr = await cmd.ExecuteReaderAsync();
                while (await rdr.ReadAsync())
                {
                    res.userPermissions.Add(new UserPermission
                    {
                        PermissionId = rdr.GetInt32("PermissionId"),
                        PermissionName = rdr.GetString("PermissionName")
                    });
                }
            }
            return res;
        }
    }

}
