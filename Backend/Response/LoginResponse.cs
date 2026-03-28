namespace StudentAttendanceAPI.Response
{
    public class LoginResponse
    {
        public string Token { get; set; } = string.Empty;
        public int UserId { get; set; }
        public string UserName { get; set; } = string.Empty;
        public List<UserPermission> userPermissions { get; set; } = new List<UserPermission>();
    }

    public class UserPermission
    {
        public int PermissionId { get; set; } = 0;
        public string PermissionName { get; set; } = string.Empty;
    }

}
