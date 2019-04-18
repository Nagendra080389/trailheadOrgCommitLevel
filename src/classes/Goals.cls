/**
 * Description of the class
 * <p /><p />
 * @author Nagendra Kumar Singh
 */
public class Goals {

    public String label;
    public Integer position;
    public List<Problems> problems;
    public String status;

    public class Problems {
        public String label;
        public Integer position;
        public String priority;
        public String status;
        public List<Interventions> interventions;
    }

    public class Instructions {
        public String label;
        public String status;
    }


    public class Interventions {
        public List<Instructions> instructions;

    }


}