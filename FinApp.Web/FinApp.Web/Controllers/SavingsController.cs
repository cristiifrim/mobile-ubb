using FinApp.Web.Errors;
using FinApp.Web.Models;
using FinApp.Web.Service;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace FinApp.Web.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SavingsController : ControllerBase
    {
        private readonly ISavingService _savingService;
        private readonly ILogger<SavingsController> _logger;

        public SavingsController(IServiceProvider serviceProvider)
        {
            _savingService = serviceProvider.GetRequiredService<ISavingService>();
            _logger = serviceProvider.GetRequiredService<ILogger<SavingsController>>();
        }

        [HttpGet]
        public async Task<IActionResult> RetrieveSavings()
        {
            try
            {
                var savings = await _savingService.RetrieveAllSavings();
                _logger.LogInformation("SERVER LOG: Retrieved all savings");
                return Ok(savings);
            }
            catch (Exception ex)
            {
                _logger.LogCritical($"Unhandled exception when retrieving all entities: {ex.Message}");
                return Problem(
                    detail: "An unexpected error appeared! Please try again or check your internet connection",
                    statusCode: StatusCodes.Status500InternalServerError
                );
            }
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> RetrieveSaving(int id)
        {
            try
            {
                var saving = await _savingService.RetrieveSaving(id);
                _logger.LogInformation($"SERVER LOG: Retrieved saving with id: {id}");
                return Ok(saving);
            }
            catch (SavingNotFoundException ex)
            {
                _logger.LogError(ex.Message);
                return BadRequest(ex.Message);
            }
            catch (Exception ex)
            {
                _logger.LogCritical($"Unhandled exception when retrieving an entity(id: {id}): {ex.Message}");
                return Problem(
                    detail: "An unexpected error appeared! Please try again or check your internet connection",
                    statusCode: StatusCodes.Status500InternalServerError
                );
            }
        }

        [HttpPost]
        public async Task<IActionResult> AddSaving([FromBody] SavingDto savingDto)
        {
            try
            {
                var addedSaving = await _savingService.AddSaving(savingDto);
                _logger.LogInformation($"SERVER LOG: Added a new saving with id: {addedSaving.Id}");
                var message = "New saving added: " + addedSaving.Category;
                await WebSocketController.NotifyClients(message);
                return Ok(addedSaving);
            }
            catch (Exception ex) when (ex is DbUpdateException || ex is DbUpdateConcurrencyException)
            {
                _logger.LogCritical($"Database error on entity addition! {ex.Message}");
                return Problem(
                    detail: "A problem updating the database appeared! Please try again or check your internet connection",
                    statusCode: StatusCodes.Status500InternalServerError
                );
            }
            catch (Exception ex)
            {
                _logger.LogCritical($"Unhandled exception when adding a new entity: {ex.Message}");
                return Problem(
                    detail: "An unexpected error appeared! Please try again or check your internet connection",
                    statusCode: StatusCodes.Status500InternalServerError
                );
            }
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteSaving(int id)
        {
            try
            {
                await _savingService.DeleteSaving(id);
                _logger.LogInformation($"SERVER LOG: Deleted the saving with id {id}");
                return Ok($"Saving with id {id} deleted succesfully");
            }
            catch (SavingNotFoundException ex)
            {
                _logger.LogError(ex.Message);
                return BadRequest(ex.Message);
            }
            catch (Exception ex) when (ex is DbUpdateException || ex is DbUpdateConcurrencyException)
            {
                _logger.LogCritical($"Database error on entity deletion! {ex.Message}");
                return Problem(
                    detail: "A problem updating the database appeared! Please try again or check your internet connection",
                    statusCode: StatusCodes.Status500InternalServerError
                );
            }
            catch (Exception ex)
            {
                _logger.LogCritical($"Unhandled exception when deleting an entity: {ex.Message}");
                return Problem(
                    detail: "An unexpected error appeared! Please try again or check your internet connection",
                    statusCode: StatusCodes.Status500InternalServerError
                );
            }
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateSaving(int id, [FromBody] SavingDto saving)
        {
            try
            {
                var updatedSaving = await _savingService.UpdateSaving(id, saving);
                _logger.LogInformation($"SERVER LOG: Updated saving with id {id}");
                return Ok(updatedSaving);
            }
            catch (SavingNotFoundException ex)
            {
                _logger.LogError(ex.Message);
                return BadRequest(ex.Message);
            }
            catch (Exception ex) when (ex is DbUpdateException || ex is DbUpdateConcurrencyException)
            {
                _logger.LogCritical($"Database error on entity update! {ex.Message}");
                return Problem(
                    detail: "A problem updating the database appeared! Please try again or check your internet connection",
                    statusCode: StatusCodes.Status500InternalServerError
                );
            }
            catch (Exception ex)
            {
                _logger.LogCritical($"Unhandled exception when updating an entity: {ex.Message}");
                return Problem(
                    detail: "An unexpected error appeared! Please try again or check your internet connection",
                    statusCode: StatusCodes.Status500InternalServerError
                );
            }
        }
    }
}
