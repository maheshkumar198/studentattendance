using Microsoft.AspNetCore.Mvc;
using StudentAttendanceAPI.Common;
using StudentAttendanceAPI.Repositories;
using StudentAttendanceAPI.Response;

namespace StudentAttendanceAPI.Services
{
    public interface ICommonService
    {
        /// <summary>
        /// Get the DropDown Data
        /// </summary>
        /// <returns></returns>
        Task<ActionResult<BaseResponse<List<CommonResponse>>>> GetCommonData();
    }
    public class CommonService : ICommonService
    {
        private readonly ICommonRepository _repository;
        /// <summary>
        /// CommonService
        /// </summary>
        /// <param name="repository"></param>
        public CommonService(ICommonRepository repository) 
        {
            _repository = repository;
        }

        /// <summary>
        /// Get the DropDown Data
        /// </summary>
        /// <returns></returns>
        public async Task<ActionResult<BaseResponse<List<CommonResponse>>>> GetCommonData()
        {
            var baseResponse = new BaseResponse<List<CommonResponse>>();
            try
            {
                baseResponse = await _repository.GetCommonData();
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
