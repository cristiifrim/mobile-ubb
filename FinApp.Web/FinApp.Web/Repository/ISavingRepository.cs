using FinApp.Web.Models;

namespace FinApp.Web.Repository
{
    public interface ISavingRepository
    {
        Task<List<Saving>> RetrieveAllSavings();
        Task<Saving?> RetrieveSaving(int id);
        Task<Saving> AddSaving(Saving saving);
        Task<Saving> UpdateSaving(Saving saving);
        Task DeleteSaving(Saving saving);
    }
}
