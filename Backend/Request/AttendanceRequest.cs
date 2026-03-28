namespace StudentAttendanceAPI.Request
{
    public class AttendanceRequest
    {
        public int StudentId { get; set; }
        public DateTime AttendanceDate { get; set; }
        public int Status { get; set; }
        public string Remarks { get; set; }
    }
}
