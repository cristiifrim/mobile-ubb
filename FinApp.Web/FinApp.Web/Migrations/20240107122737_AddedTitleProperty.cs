using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FinApp.Web.Migrations
{
    /// <inheritdoc />
    public partial class AddedTitleProperty : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Title",
                table: "Savings",
                type: "text",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Title",
                table: "Savings");
        }
    }
}
