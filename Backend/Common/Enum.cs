namespace StudentAttendanceAPI.Common
{
    public enum ResponseStatus
    {
        NA = 0,
        Success = 200,
        Created = 201,
        BadRequest = 400,
        UnAuthorized = 401,
        Forbidden = 403,
        NotFound = 404,
        Fail = 420,
        InternalServerError = 500
    }
}
