using FinApp.Web.Models;
using Microsoft.EntityFrameworkCore;

namespace FinApp.Web.DataContext
{
    public class FinAppDbContext : DbContext
    {
        public FinAppDbContext(DbContextOptions<FinAppDbContext> options) : base(options) { }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Saving>()
                .HasKey(x => x.Id);
            modelBuilder.Entity<Saving>()
                .Property(x => x.Id).ValueGeneratedOnAdd();
        }

        public DbSet<Saving> Savings { get; set; }
    }
}
