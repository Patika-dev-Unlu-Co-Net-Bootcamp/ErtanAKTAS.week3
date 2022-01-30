using System.ComponentModel.DataAnnotations.Schema;

namespace CodeFirstApproach.Entity
{
    public class Student_Success
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int id { get; set; }
        [Column(TypeName = "decimal(10,2)")]
        public decimal score { get; set; }

        [ForeignKey("User")]
        public int studentId { get; set; }
        
        public virtual User User { get; set; }  

    }
}
