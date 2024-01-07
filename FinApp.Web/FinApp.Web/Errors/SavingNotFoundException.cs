namespace FinApp.Web.Errors
{
    public class SavingNotFoundException : Exception
    {
        public SavingNotFoundException() : base("The request saving was not found") { }
        public SavingNotFoundException(int id) : base($"The saving with id {id} was not found") { }
    }
}
