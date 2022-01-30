using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace CodeFirstApproach.Migrations
{
    public partial class intiaCreate : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Educations",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    lessonName = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    lessonStartDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    lessonEndDate = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Educations", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "Users",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    name = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    lastName = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    email = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    roleId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Users", x => x.id);
                    table.ForeignKey(
                        name: "FK_Users_Roles_roleId",
                        column: x => x.roleId,
                        principalTable: "Roles",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Student_Educations",
                columns: table => new
                {
                    studentId = table.Column<int>(type: "int", nullable: false),
                    lessonId = table.Column<int>(type: "int", nullable: false),
                    Userid = table.Column<int>(type: "int", nullable: true),
                    Educationid = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Student_Educations", x => new { x.studentId, x.lessonId });
                    table.ForeignKey(
                        name: "FK_Student_Educations_Educations_Educationid",
                        column: x => x.Educationid,
                        principalTable: "Educations",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Student_Educations_Users_Userid",
                        column: x => x.Userid,
                        principalTable: "Users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "Student_RollCalls",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    lessonId = table.Column<int>(type: "int", nullable: false),
                    studentId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Student_RollCalls", x => x.id);
                    table.ForeignKey(
                        name: "FK_Student_RollCalls_Educations_lessonId",
                        column: x => x.lessonId,
                        principalTable: "Educations",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Student_RollCalls_Users_studentId",
                        column: x => x.studentId,
                        principalTable: "Users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Student_Successes",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    score = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    studentId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Student_Successes", x => x.id);
                    table.ForeignKey(
                        name: "FK_Student_Successes_Users_studentId",
                        column: x => x.studentId,
                        principalTable: "Users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Student_Educations_Educationid",
                table: "Student_Educations",
                column: "Educationid");

            migrationBuilder.CreateIndex(
                name: "IX_Student_Educations_Userid",
                table: "Student_Educations",
                column: "Userid");

            migrationBuilder.CreateIndex(
                name: "IX_Student_RollCalls_lessonId",
                table: "Student_RollCalls",
                column: "lessonId");

            migrationBuilder.CreateIndex(
                name: "IX_Student_RollCalls_studentId",
                table: "Student_RollCalls",
                column: "studentId");

            migrationBuilder.CreateIndex(
                name: "IX_Student_Successes_studentId",
                table: "Student_Successes",
                column: "studentId");

            migrationBuilder.CreateIndex(
                name: "IX_Users_roleId",
                table: "Users",
                column: "roleId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Student_Educations");

            migrationBuilder.DropTable(
                name: "Student_RollCalls");

            migrationBuilder.DropTable(
                name: "Student_Successes");

            migrationBuilder.DropTable(
                name: "Educations");

            migrationBuilder.DropTable(
                name: "Users");
        }
    }
}
