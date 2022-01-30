namespace CodeFirstApproach.Entity
{
    public class Teacher_Education
    {
        public int teacherId { get; set; }
        public User User { get; set; }

        public int lessonId { get; set; }
        public Education Education { get; set; }
    }
}
