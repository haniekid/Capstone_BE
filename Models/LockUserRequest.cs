namespace backend.Models
{
	public class LockUserRequest
	{
		public int UserId { get; set; }
		public bool IsLocked { get; set; }	
	}
}
