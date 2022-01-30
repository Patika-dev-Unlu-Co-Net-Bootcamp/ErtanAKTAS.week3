using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace CodeFirstApproach.Entity
{
    public class User
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int id { get; set; }
        public string name { get; set; }
        public string lastName { get; set; }
        public string email { get; set; }

        [ForeignKey("RoleId")]
        public int roleId { get; set; }
        public virtual Role Role { get; set; }

        public IList<Student_Education> Student_Education { get; set; }
        public IList<Assistant_Education> Assistant_Educations { get; set; }
        public IList<Teacher_Education> Teacher_Educations { get; set; }
    }
}
