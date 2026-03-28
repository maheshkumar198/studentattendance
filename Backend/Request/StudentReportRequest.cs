namespace StudentAttendanceAPI.Request
{
    public class StudentReportRequest
    {
        public DateTime FromDate { get; set; }
        public DateTime ToDate { get; set; }
        public string StudentName { get; set; }
        public string RollNo { get; set; }
        public string Status { get; set; }
    }
}
