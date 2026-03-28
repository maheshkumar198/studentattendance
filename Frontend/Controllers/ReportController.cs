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
    public class ReportController : ControllerBase
    {
        private readonly IReportService _service;
        public ReportController(IReportService service) 
        {
            _service = service;
        }

        /// <summary>
        /// Get Dashboard Count
        /// </summary>
        /// <returns></returns>
        [HttpGet("GetDashboardCounts")]
        public async Task<ActionResult<BaseResponse<DashboardCountResponse>>> GetDashboardCounts()
        {
            var report = await _service.GetDashboardCounts();
            return report;
        }

        /// <summary>
        /// Get Student Report
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpPost("GetStudentReport")]
        public async Task<ActionResult<BaseResponse<List<StudentReportResponse>>>> GetStudentReport([FromBody] StudentReportRequest request)
        {
            var report = await _service.GetStudentReport(request);
            return report;
        }
    }
}
