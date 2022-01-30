using System.ComponentModel.DataAnnotations.Schema;

namespace CodeFirstApproach.Entity
{
    public class Role
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int id { get; set; }
        public string roleName { get; set; }
    }
}
