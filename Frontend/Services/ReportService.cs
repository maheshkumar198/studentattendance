using StudentAttendanceAPI.Common;
using StudentAttendanceAPI.Repositories;
using StudentAttendanceAPI.Request;
using StudentAttendanceAPI.Response;

namespace StudentAttendanceAPI.Services
{
    public interface IReportService
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
    public class ReportService : IReportService
    {
        private readonly IReportRepository _repository;
        public ReportService(IReportRepository repository) 
        {
            _repository = repository;
        }

        /// <summary>
        /// Get Dashboard Count
        /// </summary>
        /// <returns></returns>
        public async Task<BaseResponse<DashboardCountResponse>> GetDashboardCounts()
        {
            var baseResponse = new BaseResponse<DashboardCountResponse>();
            try
            {
                baseResponse = await _repository.GetDashboardCounts();
                baseResponse.Status = ResponseStatus.Success;
                baseResponse.Message = "Success";
            }
            catch (Exception ex)
            {
                baseResponse.Status = ResponseStatus.Fail;
                baseResponse.Message = $"An error occurred: {ex.Message}";
            }
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
            try
            {
                baseResponse = await _repository.GetStudentReport(request);
                baseResponse.Status = ResponseStatus.Success;
                baseResponse.Message = "Success";
            }
            catch (Exception ex)
            {
                baseResponse.Status = ResponseStatus.Fail;
                baseResponse.Message = $"An error occurred: {ex.Message}";
            }
            return baseResponse;
        }
    }
}
