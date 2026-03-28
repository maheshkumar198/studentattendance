namespace StudentAttendanceAPI.Request
{
    public class GetStudentListRequest
    {
        public string SearchKeyword { get; set; }
        public int PageIndex { get; set; } = 1;
        public int PageSize { get; set; } = 10;
        public string SortColumn { get; set; }
        public string SortDirection { get; set; }
    }
}
