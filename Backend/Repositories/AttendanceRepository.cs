using MySql.Data.MySqlClient;
using System.Data;
using StudentAttendanceAPI.Request;

namespace StudentAttendanceAPI.Repositories
{
    public interface IAttendanceRepository
    {
        /// <summary>
        /// Student Attendance Add Update
        /// </summary>
        /// <param name="request"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        Task<string> StudentAttendance(AttendanceRequest request, long userId);
    }
    public class AttendanceRepository : IAttendanceRepository
    {
        private readonly IConfiguration _configuration;
        public AttendanceRepository(IConfiguration configuration) 
        {
            _configuration = configuration;
        }

        /// <summary>
        /// Student Attendance Add Update
        /// </summary>
        /// <param name="request"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public async Task<string> StudentAttendance(AttendanceRequest request, long userId)
        {
            using var connection = new MySqlConnection(_configuration.GetConnectionString("DefaultConnection"));
            await connection.OpenAsync();
            string message = "";
            using var cmd = connection.CreateCommand();
            cmd.CommandText = "sp_MarkAttendance";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new MySqlParameter("@p_StudentId", request.StudentId));
            cmd.Parameters.Add(new MySqlParameter("@p_AttendanceDate", request.AttendanceDate));
            cmd.Parameters.Add(new MySqlParameter("@p_Status", request.Status));
            cmd.Parameters.Add(new MySqlParameter("@p_UserId", userId));
            cmd.Parameters.Add(new MySqlParameter("@p_Remarks", request.Remarks));

            var reader = await cmd.ExecuteReaderAsync();
            if (await reader.ReadAsync())
            {
                message = reader?.GetString("message") ?? "";
            }
            return message;
        }
    }
}
