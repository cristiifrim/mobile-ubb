namespace FinApp.Web.Models
{
    public class Saving
    {
        public Saving() { }

        public Saving(SavingDto dto)
        {
            Category = dto.Category;
            Title = dto.Title;
            Description = dto.Description;
            Amount = dto.Amount;
            StartTimeInterval = dto.StartTimeInterval;
            EndTimeInterval = dto.EndTimeInterval;
            IsCommited = dto.IsCommited;
        }

        public int Id { get; set; }
        public string? Category { get; set; }
        public string? Title { get; set; }
        public string? Description { get; set; }
        public double Amount { get; set; }
        public DateTime? StartTimeInterval { get; set; }
        public DateTime? EndTimeInterval { get; set; }
        public DateTime? LastUpdateDate { get; set; }
        public bool IsCommited { get; set; }
    }
}
