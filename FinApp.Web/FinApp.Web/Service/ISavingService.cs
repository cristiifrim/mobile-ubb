using FinApp.Web.Models;

namespace FinApp.Web.Service
{
    public interface ISavingService
    {
        Task<List<Saving>> RetrieveAllSavings();
        Task<Saving?> RetrieveSaving(int id);
        Task<Saving> AddSaving(SavingDto savingDto);
        Task<Saving> UpdateSaving(int id, SavingDto savingDto);
        Task DeleteSaving(int id);
    }
}
