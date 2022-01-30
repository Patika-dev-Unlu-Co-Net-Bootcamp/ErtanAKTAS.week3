using System.ComponentModel.DataAnnotations.Schema;

namespace CodeFirstApproach.Entity
{
    public class Student_RollCall
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int id { get; set; }
        [ForeignKey("Education")]
        public int lessonId { get; set; }

        [ForeignKey("User")]
        public int studentId { get; set; }

        public virtual Education Education { get; set; }
        public virtual User User { get; set; }
    }
}
