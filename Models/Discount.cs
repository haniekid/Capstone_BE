namespace backend.Models
{
    public class Discount
    {
        public int DiscountId { get; set; }

        public string Code { get; set; } = string.Empty;

        public string? Description { get; set; }

        public string DiscountType { get; set; } = "Percentage"; // "Percentage" or "FixedAmount"

        public decimal DiscountValue { get; set; }

        public DateTime StartDate { get; set; }

        public DateTime? EndDate { get; set; }

        public int? UsageLimit { get; set; }

        public int UsedCount { get; set; } = 0;

        public bool IsActive { get; set; } = true;

        public DateTime CreatedAt { get; set; } = DateTime.Now;
    }
}
