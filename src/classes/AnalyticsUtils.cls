public with sharing class AnalyticsUtils {

    public Static List<List<String>> getTabularReport(Id reportId) {
        List<List<String>> rowList = new List<List<String>>();

        //get the report result
        Reports.ReportResults results = Reports.ReportManager.runReport(reportId, true);

        //get the metadata
        Reports.ReportMetadata reportMetadata = results.getReportMetadata();

        //get a string array of the field names
        List<String> fieldNames = reportMetadata.getDetailColumns();

        // Get the fact map from the report results
        Reports.ReportFactWithDetails factDetails = (Reports.ReportFactWithDetails)results.getFactMap().get('T!T');     

        List<reports.ReportDetailRow> reportDetailRowList = factDetails.getRows();

        //add the field names as the first row
        rowList.add(fieldNames);

        //loop over the rows
        for (Reports.ReportDetailRow reportDetailRow: reportDetailRowList) {
            List<String> cellList = new List<String>();
            //loop over the cells in the row
            for (Reports.ReportDataCell reportDataCell: reportDetailRow.getDataCells()) {
                cellList.add(reportDataCell.getLabel());        
            }

            //add the row to the list
            rowList.add(cellList);
        }

        return rowList;
    }

}