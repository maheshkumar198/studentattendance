using MySql.Data.MySqlClient;
using System.Data;
using StudentAttendanceAPI.Response;

namespace StudentAttendanceAPI.Repositories
{
    public interface ICommonRepository
    {
        /// <summary>
        /// Get the DropDown Data
        /// </summary>
        /// <returns></returns>
        Task<BaseResponse<List<CommonResponse>>> GetCommonData();
    }
    public class CommonRepository : ICommonRepository
    {
        private readonly IConfiguration _configuration;
        public CommonRepository(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        /// <summary>
        /// Get the DropDown Data
        /// </summary>
        /// <returns></returns>
        public async Task<BaseResponse<List<CommonResponse>>> GetCommonData()
        {
            var baseResponse = new BaseResponse<List<CommonResponse>>();
            using var connection = new MySqlConnection(_configuration.GetConnectionString("DefaultConnection"));
            await connection.OpenAsync();
            using var command = new MySqlCommand("sp_GetCommonData", connection)
            {
                CommandType = CommandType.StoredProcedure
            };
            using var reader = await command.ExecuteReaderAsync();
            List<CommonResponse> lst = new List<CommonResponse>(); 
            while (await reader.ReadAsync())
            {
                lst.Add(new CommonResponse
                {
                    Id = reader.GetInt32("Id"),
                    Value = reader.GetString("Value")
                });
            }
            baseResponse.Result = lst;
            return baseResponse;
        }
    }
}
