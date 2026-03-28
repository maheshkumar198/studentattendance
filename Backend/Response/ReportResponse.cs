namespace StudentAttendanceAPI.Response
{
    public class DashboardCountResponse
    {
        public int PresentCount { get; set; } = 0;
        public int AbsentCount { get; set; } = 0;
    }

    public class StudentReportResponse
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string RollNo { get; set; }
        public string Class {  get; set; }
        public DateTime AttendanceDate { get; set; }
        public string Status { get; set; }
    }
}
