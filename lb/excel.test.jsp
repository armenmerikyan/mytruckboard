<%@ page import="junit.framework.Assert,org.apache.poi.xssf.streaming.SXSSFWorkbook,org.apache.poi.ss.util.CellReference,org.apache.poi.ss.usermodel.Workbook,org.apache.poi.ss.usermodel.Sheet,org.apache.poi.ss.usermodel.Row,org.apache.poi.ss.usermodel.Cell,org.apache.http.client.fluent.Form,org.apache.http.client.fluent.Request,org.apache.http.client.methods.HttpGet,org.apache.http.Header,org.apache.http.HttpResponse,org.apache.http.NameValuePair,org.apache.http.client.entity.UrlEncodedFormEntity,org.apache.http.message.BasicNameValuePair,org.apache.http.client.methods.HttpPost,org.apache.http.impl.client.DefaultHttpClient,org.apache.http.client.HttpClient,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %><%

      SXSSFWorkbook wb = new SXSSFWorkbook(100); // keep 100 rows in memory, exceeding rows will be flushed to disk
        Sheet sh = wb.createSheet();
        for(int rownum = 0; rownum < 1000; rownum++){
            Row row = sh.createRow(rownum);
            for(int cellnum = 0; cellnum < 10; cellnum++){
                Cell cell = row.createCell(cellnum);
                String address = new CellReference(cell).formatAsString();
                cell.setCellValue(address);
            }

        }

        // Rows with rownum < 900 are flushed and not accessible
        for(int rownum = 0; rownum < 900; rownum++){
          Assert.assertNull(sh.getRow(rownum));
        }

        // ther last 100 rows are still in memory
        for(int rownum = 900; rownum < 1000; rownum++){
            Assert.assertNotNull(sh.getRow(rownum));
        }
        
        FileOutputStream out2 = new FileOutputStream("H:\\maidsSecure\\excel\\sxssf.xlsx");
        wb.write(out2);
        out2.close();

        // dispose of temporary files backing this workbook on disk
        wb.dispose();
%>
