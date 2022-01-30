using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace CodeFirstApproach.Entity
{
    public class Education
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int id { get; set; }
        public string lessonName { get; set; }

        public DateTime lessonStartDate { get; set; }
        public DateTime lessonEndDate { get; set; }

        public IList<Student_Education> Student_Education { get; set; }
        public IList<Assistant_Education>  Assistant_Educations{ get; set; }
        public IList<Teacher_Education> Teacher_Educations { get; set; }

    }
}
