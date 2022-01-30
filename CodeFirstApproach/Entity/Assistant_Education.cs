namespace CodeFirstApproach.Entity
{
    public class Assistant_Education
    {
        public int assistantId { get; set; }
        public User User { get; set; }

        public int lessonId { get; set; }
        public Education Education { get; set; }
    }
}
