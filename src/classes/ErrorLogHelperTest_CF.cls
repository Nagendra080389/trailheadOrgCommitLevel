/**
 * Helper class for Exception testing..
 * <p /><p />
 * @author Raymundo Rodriguez
 */
@isTest
public class ErrorLogHelperTest_CF {
  
  /**
   * Future method 1.
   */
  @future
  public static void futureMethodOne() {
    try {
      futureMethodTwo();
    } catch(AsyncException objFutureException) {
      ErrorLogClass_CF.processException(objFutureException);
    }
  }
  
  /**
   * Future method 2.
   */
  @future
  public static void futureMethodTwo() {
    System.debug('Empty');
  }
}