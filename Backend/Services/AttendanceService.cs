using StudentAttendanceAPI.Common;
using StudentAttendanceAPI.Repositories;
using StudentAttendanceAPI.Request;
using StudentAttendanceAPI.Response;

namespace StudentAttendanceAPI.Services
{
    public interface IAttendanceService
    {
        /// <summary>
        /// Student Attendance Add Update
        /// </summary>
        /// <param name="request"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        Task<BaseResponse<string>> StudentAttendance(AttendanceRequest request, long userId);
    }
    public class AttendanceService : IAttendanceService
    {
        private readonly IAttendanceRepository _repository;
        public AttendanceService(IAttendanceRepository repository)
        {
            _repository = repository;
        }

        /// <summary>
        /// Student Attendance Add Update
        /// </summary>
        /// <param name="request"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public async Task<BaseResponse<string>> StudentAttendance(AttendanceRequest request, long userId)
        {
            var baseResponse = new BaseResponse<string>();
            try
            {
                baseResponse.Result = await _repository.StudentAttendance(request, userId);
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
