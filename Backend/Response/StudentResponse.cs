namespace StudentAttendanceAPI.Response
{
    public class StudentResponse
    {
        public int Id { get; set; }
        public string FirstName { get; set; } = string.Empty;
        public string LastName { get; set; } = string.Empty;
        public string RollNo { get; set; } = string.Empty;
        public string Class { get; set; } = string.Empty;
    }
}
