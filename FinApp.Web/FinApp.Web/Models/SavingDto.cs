namespace FinApp.Web.Models
{
    public class SavingDto
    {
        public string? Category { get; set; }
        public string? Title { get; set; }
        public string? Description { get; set; }
        public double Amount { get; set; }
        public DateTime? StartTimeInterval { get; set; }
        public DateTime? EndTimeInterval { get; set; }
        public bool IsCommited { get; set; }
    }
}
