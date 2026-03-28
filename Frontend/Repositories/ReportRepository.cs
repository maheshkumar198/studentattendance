using MySql.Data.MySqlClient;
using System.Data;
using StudentAttendanceAPI.Request;
using StudentAttendanceAPI.Response;

namespace StudentAttendanceAPI.Repositories
{
    public interface IReportRepository 
    {
        /// <summary>
        /// Get Dashboard Count
        /// </summary>
        /// <returns></returns>
        Task<BaseResponse<DashboardCountResponse>> GetDashboardCounts();

        /// <summary>
        /// Get Student Report
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        Task<BaseResponse<List<StudentReportResponse>>> GetStudentReport(StudentReportRequest request);
    }
    public class ReportRepository : IReportRepository
    {
        private readonly IConfiguration _configuration;
        public ReportRepository(IConfiguration configuration) 
        {
            _configuration = configuration;
        }

        /// <summary>
        /// Get Dashboard Count
        /// </summary>
        /// <returns></returns>
        public async Task<BaseResponse<DashboardCountResponse>> GetDashboardCounts()
        {
            var baseResponse = new BaseResponse<DashboardCountResponse>();
            using var connection = new MySqlConnection(_configuration.GetConnectionString("DefaultConnection"));
            await connection.OpenAsync();
            using var command = new MySqlCommand("sp_GetAttendanceSummaryToday", connection)
            {
                CommandType = CommandType.StoredProcedure
            };
            using var reader = await command.ExecuteReaderAsync();
            DashboardCountResponse count = new DashboardCountResponse();
            while (await reader.ReadAsync())
            {
                count.PresentCount = reader?.GetInt32("PresentCount") ?? 0;
                count.AbsentCount = reader?.GetInt32("AbsentCount") ?? 0;
            }
            baseResponse.Result = count;
            return baseResponse;
        }

        /// <summary>
        /// Get Student Report
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        public async Task<BaseResponse<List<StudentReportResponse>>> GetStudentReport(StudentReportRequest request)
        {
            var baseResponse = new BaseResponse<List<StudentReportResponse>>();
            using var connection = new MySqlConnection(_configuration.GetConnectionString("DefaultConnection"));
            await connection.OpenAsync();
            using var command = new MySqlCommand("sp_GetStudentReport", connection)
            {
                CommandType = CommandType.StoredProcedure
            };
            command.Parameters.AddWithValue("@p_FromDate", request.FromDate);
            command.Parameters.AddWithValue("@p_ToDate", request.ToDate);
            command.Parameters.AddWithValue("@p_StudentName", request.StudentName);
            command.Parameters.AddWithValue("@p_RollNo", request.RollNo);
            command.Parameters.AddWithValue("@p_Status", request.Status);
            using var reader = await command.ExecuteReaderAsync();
            List<StudentReportResponse> lst = new List<StudentReportResponse>();
            while (await reader.ReadAsync())
            {
                lst.Add(new StudentReportResponse
                {
                    FirstName = reader.GetString("FirstName"),
                    LastName = reader.GetString("LastName"),
                    RollNo = reader.GetString("RollNo"),
                    Class = reader.GetString("Class"),
                    AttendanceDate = reader.GetDateTime("AttendanceDate"),
                    Status = reader.GetString("Status")
                });
            }
            baseResponse.Result = lst;
            return baseResponse;
        }
    }
}
