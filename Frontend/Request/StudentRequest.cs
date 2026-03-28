namespace StudentAttendanceAPI.Request
{
    public class StudentRequest
    {
        public int Id { get; set; }
        public string FirstName { get; set; } = string.Empty;
        public string LastName { get; set; } = string.Empty;
        public string RollNo { get; set; } = string.Empty;
        public int ClassId { get; set; } = 0;
        public string Remarks { get; set; } = string.Empty; 
    }
}
