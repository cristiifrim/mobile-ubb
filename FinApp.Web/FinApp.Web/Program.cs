using FinApp.Web.DataContext;
using FinApp.Web.Repository;
using FinApp.Web.Service;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

builder.Logging.ClearProviders();
builder.Logging.AddConsole();

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddDbContext<FinAppDbContext>(opts =>
{
    opts.UseNpgsql("Host=127.0.0.1;Port=5432;Database=FinAppDb_RO;Username=postgres;Password=admin;");
});

builder.Services.AddScoped<ISavingRepository, SavingRepository>();
builder.Services.AddScoped<ISavingService, SavingService>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors(builder =>
{
    builder
        .AllowAnyOrigin()
        .AllowAnyMethod()
        .AllowAnyHeader();
});

//app.UseHttpsRedirection();

app.UseWebSockets();

app.UseAuthorization();

app.MapControllers();

app.Run();
