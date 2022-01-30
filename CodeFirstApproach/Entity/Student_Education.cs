namespace CodeFirstApproach.Entity
{
    public class Student_Education
    {
        
        public int studentId { get; set; }
        public User User { get; set; }

        public int lessonId { get; set; }
        public Education Education { get; set; }
    }
}
