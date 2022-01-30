using Microsoft.EntityFrameworkCore;

namespace CodeFirstApproach.Entity
{
    public class Context :DbContext
    {
        public Context(DbContextOptions options) : base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Student_Education>().HasKey(se => new { se.studentId, se.lessonId });
            modelBuilder.Entity<Assistant_Education>().HasKey(ae => new { ae.assistantId, ae.lessonId });
            modelBuilder.Entity<Teacher_Education>().HasKey(te => new { te.teacherId, te.lessonId });

        }

        public DbSet<Role> Roles { get; set; }    
        public DbSet<Education> Educations { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Student_RollCall> Student_RollCalls { get; set; }
        public DbSet<Student_Success> Student_Successes { get; set; }
        public DbSet<Student_Education> Student_Educations { get; set; }
        public DbSet<Assistant_Education> Assistant_Educations { get; set; }
        public DbSet<Teacher_Education> Teacher_Educations { get; set; }

    }
}
