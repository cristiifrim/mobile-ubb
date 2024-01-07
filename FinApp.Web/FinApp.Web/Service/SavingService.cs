using FinApp.Web.Errors;
using FinApp.Web.Models;
using FinApp.Web.Repository;

namespace FinApp.Web.Service
{
    public class SavingService : ISavingService
    {
        private readonly ISavingRepository _repository;

        public SavingService(IServiceProvider serviceProvider)
        {
            _repository = serviceProvider.GetRequiredService<ISavingRepository>();
        }

        public async Task<Saving> AddSaving(SavingDto savingDto)
        {
            var saving = new Saving(savingDto)
            {
                LastUpdateDate = DateTime.Now,
            };
            return await _repository.AddSaving(saving);
        }

        public async Task DeleteSaving(int id)
        {
            var saving = await _repository.RetrieveSaving(id);
            if (saving == null)
            {
                throw new SavingNotFoundException(id);
            }
            await _repository.DeleteSaving(saving);
        }

        public async Task<List<Saving>> RetrieveAllSavings()
        {
            return await _repository.RetrieveAllSavings();
        }

        public async Task<Saving?> RetrieveSaving(int id)
        {
            var saving = await _repository.RetrieveSaving(id);
            if (saving == null)
            {
                throw new SavingNotFoundException(id);
            }
            return saving;
        }

        public async Task<Saving> UpdateSaving(int id, SavingDto savingToBeUpdated)
        {
            var saving = await _repository.RetrieveSaving(id);
            if (saving == null)
            {
                throw new SavingNotFoundException(id);
            }
            saving.Category = savingToBeUpdated.Category;
            saving.Title = savingToBeUpdated.Title;
            saving.EndTimeInterval = savingToBeUpdated.EndTimeInterval;
            saving.StartTimeInterval = savingToBeUpdated.StartTimeInterval;
            saving.IsCommited = savingToBeUpdated.IsCommited;
            saving.Amount = savingToBeUpdated.Amount;
            saving.Description = savingToBeUpdated.Description;
            saving.LastUpdateDate = DateTime.Now;
            return await _repository.UpdateSaving(saving);
        }
    }
}
