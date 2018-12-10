public class reportResponse{ 
    @AuraEnabled
    public static List<List<String>> getReportRows() {
        return AnalyticsUtils.getTabularReport('00O1I000006PTpR');
    }
}