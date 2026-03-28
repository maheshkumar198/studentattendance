using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using StudentAttendanceAPI.Common;
using StudentAttendanceAPI.Request;
using StudentAttendanceAPI.Response;
using StudentAttendanceAPI.Services;

namespace StudentAttendanceAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [AllowAnonymous]
    public class AuthController : ControllerBase
    {
        private readonly IAuthService _authService;
        /// <summary>
        /// AuthController
        /// </summary>
        /// <param name="authService"></param>
        public AuthController(IAuthService authService)
        {
            _authService = authService;
        }

        /// <summary>
        /// User Login API
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpPost("Login")]
        public async Task<ActionResult<BaseResponse<LoginResponse>>> Login([FromBody] LoginRequest request)
        {
            var response = await _authService.UserAuthenticate(request);
            if (response.Value == null && response?.Value?.Status != ResponseStatus.Success)
                return Unauthorized("Invalid credentials");

            return response;
        }
    }
}
