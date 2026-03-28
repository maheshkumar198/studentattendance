using System.Text;
using Microsoft.AspNetCore.Mvc;
using StudentAttendanceAPI.Common;
using StudentAttendanceAPI.Helpers;
using StudentAttendanceAPI.Repositories;
using StudentAttendanceAPI.Request;
using StudentAttendanceAPI.Response;

namespace StudentAttendanceAPI.Services
{
    public interface IAuthService
    {
        /// <summary>
        /// User Login
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        Task<ActionResult<BaseResponse<LoginResponse>>> UserAuthenticate(LoginRequest request);
    }
    public class AuthService : IAuthService
    {
        private readonly IAuthRepository _repository;
        private readonly IConfiguration _configuration;
        public AuthService(IAuthRepository repository, IConfiguration configuration)
        {
            _repository = repository;
            _configuration = configuration;
        }

        /// <summary>
        /// User Login
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        public async Task<ActionResult<BaseResponse<LoginResponse>>> UserAuthenticate(LoginRequest request)
        {
            var baseResponse = new BaseResponse<LoginResponse>();
            try
            {
                baseResponse.Result = await _repository.UserAuthenticate(request);
                if (baseResponse.Result != null && baseResponse.Result.UserId > 0)
                {
                    byte[] jwtKey = Encoding.UTF8.GetBytes(_configuration["Jwt:Key"]!);
                    string jwtIssuer = _configuration["Jwt:Issuer"] ?? string.Empty;
                    string jwtAudience = _configuration["Jwt:Audience"] ?? string.Empty;

                    var jwtHelper = new JwtHelper();
                    baseResponse.Result.Token = jwtHelper.GenerateJwtToken(baseResponse.Result, jwtKey, jwtIssuer, jwtAudience);
                    baseResponse.Status = ResponseStatus.Success;
                    baseResponse.Message = "Login Succesfully.";
                }
                else
                {
                    baseResponse.Status = ResponseStatus.NotFound;
                    baseResponse.Message = "Invalid username or password.";
                }
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
