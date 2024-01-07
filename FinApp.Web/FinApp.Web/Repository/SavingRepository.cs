using FinApp.Web.DataContext;
using FinApp.Web.Models;
using Microsoft.EntityFrameworkCore;

namespace FinApp.Web.Repository
{
    public class SavingRepository : ISavingRepository
    {
        private readonly FinAppDbContext _context;

        public SavingRepository(FinAppDbContext context)
        {
            _context = context;
        }

        public async Task<Saving> AddSaving(Saving saving)
        {
            await _context.Savings.AddAsync(saving);
            await _context.SaveChangesAsync();
            return saving;
        }

        public async Task DeleteSaving(Saving saving)
        {
            _context.Savings.Remove(saving);
            await _context.SaveChangesAsync();
        }

        public async Task<List<Saving>> RetrieveAllSavings()
        {
            return await _context.Savings.ToListAsync();
        }

        public async Task<Saving?> RetrieveSaving(int id)
        {
            return await _context.Savings.FirstOrDefaultAsync(x => x.Id == id);
        }

        public async Task<Saving> UpdateSaving(Saving saving)
        {
            _context.Update(saving);
            await _context.SaveChangesAsync();
            return saving;
        }
    }
}
