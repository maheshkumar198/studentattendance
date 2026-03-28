using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using StudentAttendanceAPI.Request;
using StudentAttendanceAPI.Response;
using StudentAttendanceAPI.Services;

namespace StudentAttendanceAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class AttendanceController : ControllerBase
    {
        private readonly IAttendanceService _service;

        /// <summary>
        /// AttendanceController
        /// </summary>
        /// <param name="service"></param>
        public AttendanceController(IAttendanceService service)
        {
            _service = service;
        }

        /// <summary>
        /// Student Attendance Add Update
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpPost("StudentAttendance")]
        public async Task<ActionResult<BaseResponse<string>>> StudentAttendance([FromBody] AttendanceRequest request)
        {
            long userId = long.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? "1");
            var result = await _service.StudentAttendance(request, userId);
            return result;
        }
    }
}
