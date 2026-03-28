using StudentAttendanceAPI.Common;

namespace StudentAttendanceAPI.Response
{
    public class BaseResponse<T>
    {
        public ResponseStatus Status { get; set; }
        public string Message { get; set; } = string.Empty;
        public int TotalCount { get; set; } = 0;
        public T Result { get; set; }
    }
}
