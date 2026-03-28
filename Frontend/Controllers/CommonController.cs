using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using StudentAttendanceAPI.Response;
using StudentAttendanceAPI.Services;

namespace StudentAttendanceAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class CommonController : ControllerBase
    {
        private readonly ICommonService _service;

        public CommonController(ICommonService service) 
        {
            _service = service;
        }

        /// <summary>
        /// Get the DropDown Data
        /// </summary>
        /// <returns></returns>
        [HttpPost("GetCommonData")]
        public async Task<ActionResult<BaseResponse<List<CommonResponse>>>> GetCommonData()
        {
            var data = await _service.GetCommonData();
            return data;
        }
    }
}
