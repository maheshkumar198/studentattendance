using StudentAttendanceAPI.Common;
using StudentAttendanceAPI.Repositories;
using StudentAttendanceAPI.Request;
using StudentAttendanceAPI.Response;

namespace StudentAttendanceAPI.Services
{
    public interface IStudentService
    {
        /// <summary>
        /// Student Register
        /// </summary>
        /// <param name="request"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        Task<BaseResponse<List<int>>> StudentRegister(List<StudentRequest> request, long userId);

        /// <summary>
        /// Get Student List
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        Task<BaseResponse<List<StudentResponse>>> GetStudentList(GetStudentListRequest request);
    }
    public class StudentService : IStudentService
    {
        private readonly IStudentRepository _repository;

        /// <summary>
        /// StudentService
        /// </summary>
        /// <param name="repository"></param>
        public StudentService(IStudentRepository repository)
        {
            _repository = repository;
        }

        /// <summary>
        /// Student Register
        /// </summary>
        /// <param name="request"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public async Task<BaseResponse<List<int>>> StudentRegister(List<StudentRequest> request, long userId)
        {
            var baseResponse = new BaseResponse<List<int>>();
            try
            {
                baseResponse.Result = await _repository.StudentRegister(request, userId);
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
        /// Get Student List
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        public async Task<BaseResponse<List<StudentResponse>>> GetStudentList(GetStudentListRequest request)
        {
            var baseResponse = new BaseResponse<List<StudentResponse>>();
            try
            {
                baseResponse = await _repository.GetStudentList(request);
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
