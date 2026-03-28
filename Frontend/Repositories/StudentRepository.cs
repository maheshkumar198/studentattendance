using MySql.Data.MySqlClient;
using System.Data;
using StudentAttendanceAPI.Request;
using StudentAttendanceAPI.Response;

namespace StudentAttendanceAPI.Repositories
{
    public interface IStudentRepository
    {
        /// <summary>
        /// Student Register
        /// </summary>
        /// <param name="request"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        Task<List<int>> StudentRegister(List<StudentRequest> request, long userId);

        /// <summary>
        /// Get Student List
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        Task<BaseResponse<List<StudentResponse>>> GetStudentList(GetStudentListRequest request);
    }
    public class StudentRepository : IStudentRepository
    {

        private readonly IConfiguration _configuration;

        /// <summary>
        /// StudentRepository
        /// </summary>
        /// <param name="configuration"></param>
        public StudentRepository(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        /// <summary>
        /// Student Register
        /// </summary>
        /// <param name="request"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public async Task<List<int>> StudentRegister(List<StudentRequest> request, long userId)
        {
            using var connection = new MySqlConnection(_configuration.GetConnectionString("DefaultConnection"));
            await connection.OpenAsync();
            var studentIds = new List<int>();
            
            foreach (var item in request)
            {
                using var cmd = connection.CreateCommand();
                cmd.CommandText = "sp_SaveStudent";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Clear();
                cmd.Parameters.Add(new MySqlParameter("@p_Id", item.Id));
                cmd.Parameters.Add(new MySqlParameter("@p_FirstName", item.FirstName));
                cmd.Parameters.Add(new MySqlParameter("@p_LastName", item.LastName));
                cmd.Parameters.Add(new MySqlParameter("@p_RollNo", item.RollNo));
                cmd.Parameters.Add(new MySqlParameter("@p_ClassId", item.ClassId));
                cmd.Parameters.Add(new MySqlParameter("@p_UserId", userId));
                cmd.Parameters.Add(new MySqlParameter("@p_Remarks", item.Remarks));

                using var reader = await cmd.ExecuteReaderAsync();
                if (await reader.ReadAsync())
                {
                    var studentId = reader["StudentId"] != DBNull.Value ? Convert.ToInt32(reader["StudentId"]) : 0;
                    studentIds.Add(studentId);
                }
                await reader.CloseAsync();
            }
            return studentIds;
        }

        /// <summary>
        /// Get Student List
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        public async Task<BaseResponse<List<StudentResponse>>> GetStudentList(GetStudentListRequest request)
        {
            var baseResponse = new BaseResponse<List<StudentResponse>>();
            using var connection = new MySqlConnection(_configuration.GetConnectionString("DefaultConnection"));
            await connection.OpenAsync();
            using var command = new MySqlCommand("sp_GetStudents", connection)
            {
                CommandType = CommandType.StoredProcedure
            };
            command.Parameters.AddWithValue("@p_SearchKeyword", request.SearchKeyword ?? "");
            command.Parameters.AddWithValue("@p_PageIndex", request.PageIndex);
            command.Parameters.AddWithValue("@p_PageSize", request.PageSize);
            command.Parameters.AddWithValue("@p_SortColumn", request.SortColumn);
            command.Parameters.AddWithValue("@p_SortDirection", request.SortDirection);

            using var reader = await command.ExecuteReaderAsync();
            // First result set: total count
            if (await reader.ReadAsync())
            {
                baseResponse.TotalCount = reader.GetInt32("TotalCount");
            }

            // Move to second result set
            await reader.NextResultAsync();
            List<StudentResponse> lst = new List<StudentResponse>();
            while (await reader.ReadAsync())
            {
                lst.Add(new StudentResponse
                {
                    Id = reader.GetInt32("Id"),
                    FirstName = reader.GetString("FirstName"),
                    LastName = reader.GetString("LastName"),
                    RollNo = reader.GetString("RollNo"),
                    Class = reader.GetString("Class")
                });
            }
            baseResponse.Result = lst;
            return baseResponse;
        }
    }
}
