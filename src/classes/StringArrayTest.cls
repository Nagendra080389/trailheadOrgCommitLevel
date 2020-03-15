public class StringArrayTest {

    public static List<String> generateStringArray(Integer numberOfString) {

        List<String> strList = new List<String>();

        for (Integer i = 0; i < numberOfString; i++) {
            strList.add('Test ' + i);
        }

        return strList;

    }

    public static void testMainTest() {

    }

}