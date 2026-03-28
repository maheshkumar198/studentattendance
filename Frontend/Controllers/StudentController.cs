using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;
using Microsoft.AspNetCore.Mvc;
using StudentAttendanceAPI.Services;
using StudentAttendanceAPI.Request;
using StudentAttendanceAPI.Response;

namespace StudentAttendanceAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class StudentController : ControllerBase
    {
        private readonly IStudentService _service;

        /// <summary>
        /// StudentController
        /// </summary>
        /// <param name="service"></param>
        public StudentController(IStudentService service)
        {
            _service = service;
        }

        /// <summary>
        /// Student Register
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpPost("StudentRegister")]
        public async Task<ActionResult<BaseResponse<List<int>>>> StudentRegister([FromBody] List<StudentRequest> request)
        {
            long userId = long.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? "1");
            var result = await _service.StudentRegister(request, userId);
            return result;
        }

        /// <summary>
        /// Get Student List
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpPost("GetStudentList")]
        public async Task<ActionResult<BaseResponse<List<StudentResponse>>>> GetStudentList([FromBody] GetStudentListRequest request)
        {
            var students = await _service.GetStudentList(request);
            return students;
        }
    }
}
