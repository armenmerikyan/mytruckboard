<%@page import="org.apache.poi.hssf.usermodel.*" %><%@page import="java.io.*" %><%

// create a small spreadsheet
HSSFWorkbook wb = new HSSFWorkbook();
HSSFSheet sheet = wb.createSheet();
HSSFRow row = sheet.createRow(0);
HSSFCell cell = row.createCell(0);
cell.setCellValue("Some text");

// write it as an excel attachment
ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
wb.write(outByteStream);
byte [] outArray = outByteStream.toByteArray();
response.setContentType("application/ms-excel");
response.setContentLength(outArray.length);
response.setHeader("Expires:", "0"); // eliminates browser caching
response.setHeader("Content-Disposition", "attachment; filename=testxls.xls");
OutputStream outStream = response.getOutputStream();
outStream.write(outArray);
outStream.flush();

%>