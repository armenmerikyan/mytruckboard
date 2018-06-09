<%@ page import="org.apache.poi.ss.util.CellRangeAddress,org.apache.poi.hssf.util.HSSFColor,org.apache.poi.hssf.usermodel.*,org.apache.poi.hssf.usermodel.HSSFWorkbook,org.apache.poi.ss.usermodel.*,org.apache.commons.io.IOUtils,junit.framework.Assert,org.apache.poi.xssf.streaming.SXSSFWorkbook,org.apache.poi.ss.util.CellReference,org.apache.poi.ss.usermodel.Workbook,org.apache.poi.ss.usermodel.Sheet,org.apache.poi.ss.usermodel.Row,org.apache.poi.ss.usermodel.Cell,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %><%
		//response.setContentType("application/application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		//response.setContentType("application/vnd.ms-excel");
	response.setContentType("application/ms-excel");
	if(request.getParameter("fuel_batch_id")!=null){
		response.setHeader("Content-Disposition", "attachment; filename=dd"+ request.getParameter("fuel_batch_id") +".xls");
	}	
	if(request.getParameter("factoring_batch_id")!=null){
		response.setHeader("Content-Disposition", "attachment; filename="+ request.getParameter("factoring_batch_id") +".xls");        
	}		
if(session.getAttribute("issubscribed")!=null && session.getAttribute("issubscribed").equals("true")){ 

      
		DateFormat formatter = new SimpleDateFormat("MM-dd-yyyy");
        
			String uuid = (String)session.getAttribute("uuid");

			if(uuid !=null){

	         try{
			Vector userList = new Vector();
			HashMap user_map = new HashMap();
			Vector resultSetVector = new Vector();
			HashMap resultSetMap = new HashMap();
			HashMap resultSetMapPayments = new HashMap();

			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");			

			PreparedStatement ps = connection.prepareStatement("select * from test.TRUCKING_USERS WHERE COMPANY_ID = ?");
			ps.setString(1, uuid);
			ResultSet resultSet = ps.executeQuery();
			while (resultSet.next()) {
				String[] userItem = new String[4];
				userItem[0] = resultSet.getString("email");
				userItem[1] = resultSet.getString("f_name");
				userItem[2] = resultSet.getString("l_name");
				userItem[3] = resultSet.getString("phone");
				user_map.put(resultSet.getString("email") , userItem);
			}
			
				
				//;
				//
				PreparedStatement psMain = connection.prepareStatement("select load_board.load_board_id, SUM(load_board_finance.fin_amount) as all_total_paid from test.load_board left join test.load_board_finance on load_board.load_board_id = load_board_finance.load_id left join test.locations on load_board.bill_to_id = locations.location_id where load_board.company_id = ? and load_board_finance.fin_type = 'Invoice Payment' group by  load_board.load_board_id order by load_board.ts asc");
				//psMain.setString(1, uuid);	
				if(request.getParameter("factoring_batch_id")!=null){
					psMain = connection.prepareStatement("select load_board.load_board_id, SUM(load_board_finance.fin_amount) as all_total_paid from test.load_board left join test.load_board_finance on load_board.load_board_id = load_board_finance.load_id left join test.locations on load_board.bill_to_id = locations.location_id where load_board.company_id = ? and load_board_finance.fin_type = 'Invoice Payment' and (load_status_factoring_batch_id= ?) group by  load_board.load_board_id order by load_board.ts asc");
					psMain.setString(1, uuid);	
					psMain.setString(2, request.getParameter("factoring_batch_id"));	
				}	
				if(request.getParameter("fuel_batch_id")!=null){
					psMain = connection.prepareStatement("select load_board.load_board_id, SUM(load_board_finance.fin_amount) as all_total_paid from test.load_board left join test.load_board_finance on load_board.load_board_id = load_board_finance.load_id left join test.locations on load_board.bill_to_id = locations.location_id where load_board.company_id = ? and load_board_finance.fin_type = 'Invoice Payment' and (load_status_fuel_batch_id= ?) group by  load_board.load_board_id order by load_board.ts asc");
					psMain.setString(1, uuid);	
					psMain.setString(2, request.getParameter("fuel_batch_id"));	
				}
				
				
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					resultSetMapPayments.put(resultSet.getString("load_board_id"), resultSet.getString("all_total_paid"));
				}

				psMain = connection.prepareStatement("select * from test.load_board left join test.locations on load_board.bill_to_id = locations.location_id left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id  where load_board.company_id = ? order by load_board.ts asc");
				//psMain.setString(1, uuid);
				if(request.getParameter("factoring_batch_id")!=null){
					psMain = connection.prepareStatement("select * from test.load_board left join test.locations on load_board.bill_to_id = locations.location_id left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id  where load_board.company_id = ? and (load_status_factoring_batch_id= ?) order by load_board.ts asc");
					psMain.setString(1, uuid);
					psMain.setString(2, request.getParameter("factoring_batch_id"));
				}
				if(request.getParameter("fuel_batch_id")!=null){
					psMain = connection.prepareStatement("select * from test.load_board left join test.locations on load_board.bill_to_id = locations.location_id left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id  where load_board.company_id = ? and (load_status_fuel_batch_id= ?) order by load_board.ts asc");
					psMain.setString(1, uuid);
					psMain.setString(2, request.getParameter("fuel_batch_id"));
				}
				
			resultSet = psMain.executeQuery();
			float totalBatch = 0.0f;
			while (resultSet.next()) {
				String pickDate = "";
				String pickTime = "";

				String dropDate = "";
				String dropTime = "";	
				if(!resultSetMap.containsKey(resultSet.getString("load_board_id"))){
					resultSetVector.add(resultSet.getString("load_board_id"));
					String[] rowArray = new String[27];
					rowArray[0] = resultSet.getString("load_board_id");
					rowArray[1] = resultSet.getString("load_number");
					rowArray[2] = resultSet.getString("load_wo");
					rowArray[3] = resultSet.getString("disdetail");
					rowArray[4] = resultSet.getString("load_rate");
					rowArray[5] = resultSet.getString("load_carrier_fee");
					rowArray[6] = "";
					rowArray[7] = "";
					rowArray[8] = pickDate + " " + pickTime;
					rowArray[9] = dropDate + " " + dropTime;
					rowArray[10] = resultSet.getString("locations.org_name");
					rowArray[11] = "";
					rowArray[12] = "";
					rowArray[13] = resultSet.getString("load_status");	
					rowArray[14] = resultSet.getString("advances_total");
					rowArray[15] = resultSet.getString("load_other");
					rowArray[16] = resultSet.getString("bill_to_advances");	
					float tmpPaid = 0.0f;
					if(resultSetMapPayments.containsKey(resultSet.getString("load_board_id")))tmpPaid = Float.parseFloat((String)resultSetMapPayments.get(resultSet.getString("load_board_id")));
					float tmpTotal = ((resultSet.getFloat("load_rate") * resultSet.getFloat("load_units")) + resultSet.getFloat("load_other")) - (resultSet.getFloat("bill_to_advances") + tmpPaid);	
					float tmpTotalInv = (resultSet.getFloat("load_rate") * resultSet.getFloat("load_units")) + resultSet.getFloat("load_other");	
					float tmpTotalAdv = tmpTotalInv * 0.5f;
					if(tmpTotalAdv>3000.0f)tmpTotalAdv= 3000.0f;
					rowArray[17] = String.format("%.02f", tmpTotal);
					rowArray[18] = resultSet.getString("load_units");
					rowArray[19] = (String)resultSetMapPayments.get(resultSet.getString("load_board_id"));
					rowArray[20] = resultSet.getString("trucking_equipment.name");											
					rowArray[21] = String.format("%.02f", tmpTotalInv);
					rowArray[22] = resultSet.getString("load_status_fuel_batch_id");
					rowArray[23] = resultSet.getString("load_status_factoring_batch_id");										
					rowArray[24] = String.format("%.02f", tmpTotalAdv);
					rowArray[25] = formatter.format(resultSet.getDate("TS"));
					if(resultSet.getDate("INVOICE_DATE")!=null){
					rowArray[26] = formatter.format(resultSet.getDate("INVOICE_DATE"));
					}else{
					rowArray[26] = "";
					}
					totalBatch = totalBatch + tmpTotalInv;
					resultSetMap.put(rowArray[0] , rowArray);
				}
			}
			connection.close();
			int rowCount = 0;
			
      HSSFWorkbook wb = new HSSFWorkbook(); // keep 100 rows in memory, exceeding rows will be flushed to disk
	 HSSFSheet sh = wb.createSheet();
        sh.setColumnWidth(0,100);
	if(request.getParameter("fuel_batch_id")!=null){
	//FileOutputStream out2 = new FileOutputStream("H:\\maidsSecure\\excel\\fuel_" + request.getParameter("fuel_batch_id") + ".xlsx");
      
HSSFRow rowHeader = sh.createRow(1);
short b = 200;
rowHeader.setHeight(b);
            HSSFCellStyle style = wb.createCellStyle();
            HSSFCellStyle styleLine = wb.createCellStyle();
            style.setWrapText(true);
      		HSSFFont fontBold = wb.createFont();
      		fontBold.setBold(true);
     		 style.setFont(fontBold);
style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
style.setBorderTop(HSSFCellStyle.BORDER_THIN);
style.setBorderRight(HSSFCellStyle.BORDER_THIN);
style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
styleLine.setBorderBottom(HSSFCellStyle.BORDER_THIN);
styleLine.setBorderTop(HSSFCellStyle.BORDER_THIN);
styleLine.setBorderRight(HSSFCellStyle.BORDER_THIN);
styleLine.setBorderLeft(HSSFCellStyle.BORDER_THIN);

            	rowHeader.setRowStyle(style);
            
      HSSFCellStyle styleTItle = wb.createCellStyle();

      HSSFFont font = wb.createFont();
      font.setFontHeightInPoints((short) 14);
      font.setItalic(true);
      styleTItle.setFont(font);
      
HSSFCell cellHeader = rowHeader.createCell(2);
cellHeader.setCellValue("FUEL ADVANCE REQUEST FORM:");
cellHeader.setCellStyle(styleTItle);
Cell cellHeaderCompanyName = rowHeader.createCell(6);
cellHeaderCompanyName.setCellValue("My Company");

InputStream inputStream = new FileInputStream("D:\\apache-tomcat-7.0.41\\webapps\\ROOT\\images\\triumph_logo.png");

   byte[] imageBytes = IOUtils.toByteArray(inputStream);

   int pictureureIdx = wb.addPicture(imageBytes, Workbook.PICTURE_TYPE_PNG);

   inputStream.close(); 
   
   CreationHelper helper = wb.getCreationHelper();

   Drawing drawing = sh.createDrawingPatriarch();

   ClientAnchor anchor = helper.createClientAnchor();

   anchor.setCol1(1);
   anchor.setRow1(1);

   drawing.createPicture(anchor, pictureureIdx);
   Row rowHeaderTable = sh.createRow(9);
   rowHeaderTable.createCell(1).setCellValue("Customer Name");
   rowHeaderTable.createCell(2).setCellValue("Load Number");
   rowHeaderTable.createCell(3).setCellValue("Conf #");
   rowHeaderTable.createCell(4).setCellValue("Total Rate of Load $");
   rowHeaderTable.createCell(5).setCellValue("ADVANCE REQ $");
   rowHeaderTable.createCell(6).setCellValue("ADV PAYMENT METHOD");
   rowHeaderTable.setRowStyle(style);
   rowHeaderTable.setHeight((short)700);
   rowHeaderTable.getCell(1).setCellStyle(style);
   rowHeaderTable.getCell(2).setCellStyle(style);
   rowHeaderTable.getCell(3).setCellStyle(style);
   rowHeaderTable.getCell(4).setCellStyle(style);
   rowHeaderTable.getCell(5).setCellStyle(style);
   rowHeaderTable.getCell(6).setCellStyle(style);
   String dateBatch = "";
			for(int l=0;l<resultSetVector.size();l++){
			rowCount +=1;

				    for(int cellnum = 0; cellnum < 10; cellnum++){
					    Row row = sh.createRow(l+10);
					    Cell cellCustomer = row.createCell(1);
					    Cell cellLN = row.createCell(2);
					    Cell cellConfNo = row.createCell(3);
					    Cell cellRate = row.createCell(4);
					    Cell cellAdvanceReq = row.createCell(5);
					    Cell cellMethod = row.createCell(6);
					    
   					    cellCustomer.setCellStyle(styleLine);
   					    cellLN.setCellStyle(styleLine);
   					    cellConfNo.setCellStyle(styleLine);
   					    cellRate.setCellStyle(styleLine);
   					    cellAdvanceReq.setCellStyle(styleLine);
   					    cellMethod.setCellStyle(styleLine);
					    cellLN.setCellValue(NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[1]));
					    cellRate.setCellValue(NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[21]));
					    cellCustomer.setCellValue(NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[10]));
					    cellAdvanceReq.setCellValue(NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[24]));
					    cellMethod.setCellValue("THC");
					    dateBatch = NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[25]);
					    
				    }
			}


   Row rowFooterOne = sh.createRow(resultSetVector.size()+11);
   rowFooterOne.createCell(2).setCellValue("Advance Request Form       Rate Confirmation       B.O.L.");
   
   HSSFRow rowFooterTwo = sh.createRow(resultSetVector.size()+13);
   HSSFRow rowFooter4 = sh.createRow(resultSetVector.size()+17);
   HSSFRow rowFooter5 = sh.createRow(resultSetVector.size()+19);
   rowFooter5.createCell(1).setCellValue("Company Name");
   rowFooter4.createCell(1).setCellValue("Terms: This form must be completed and signed along with a copy of the load confirmation and BOL verifying load acceptance prior to delivery of advance funds.  Advance Business Capital does not advance more than 50% or $2,000 of the total rate agreed on the Rate Confirmation. ABC charges a one-time fee of $15.00 per advance, per load. Once an advance has been given by ABC, no outside advances shall be taken. If outside advances are taken from a broker / shipper or any other financial source, ABC reserves the right to charge back the total amount advanced, plus a $50 penalty fee. Once an advance has been given by ABC the Client is required to submit their paperwork for factoring within 7 days or ABC reserves the right to charge back the total amount advanced. Standard funding transmission fees apply to all fuel advance transactions, pursuant to the Factoring and Security Agreement.");
  

HSSFCellStyle styleBorder = wb.createCellStyle();
styleBorder.setBorderBottom(HSSFCellStyle.BORDER_THIN);
styleBorder.setBorderTop(HSSFCellStyle.BORDER_THIN);
styleBorder.setBorderRight(HSSFCellStyle.BORDER_THIN);
styleBorder.setBorderLeft(HSSFCellStyle.BORDER_THIN);

   HSSFRow rowFooter6 = sh.createRow(resultSetVector.size()+20);
   rowFooter6.createCell(1).setCellValue("Company Name");
   rowFooter6.getCell(1).setCellStyle(styleBorder);
   HSSFRow rowFooter7 = sh.createRow(resultSetVector.size()+22);
   rowFooter7.createCell(1).setCellValue("Authorization Signature");
   rowFooter7.createCell(5).setCellValue("Date of Fuel Advance Request");
   HSSFRow rowFooter8 = sh.createRow(resultSetVector.size()+23);
   rowFooter8.createCell(1).setCellValue("Company Name");
   rowFooter8.createCell(5).setCellValue(dateBatch);
   rowFooter8.getCell(1).setCellStyle(styleBorder);
   rowFooter8.getCell(5).setCellStyle(styleBorder);

HSSFFont fontFooter = wb.createFont();
fontFooter.setFontHeightInPoints((short) 12);
fontFooter.setBold(true);
HSSFCellStyle styleFooter = wb.createCellStyle();
styleFooter.setFont(fontFooter);
rowFooterTwo.setRowStyle(styleFooter);
rowFooterTwo.createCell(2).setCellValue("SUBMIT FUEL ADVANCE BY FAX OR E-MAIL");
rowFooterTwo.getCell(2).setCellStyle(styleFooter);

HSSFCellStyle styleFooter4 = wb.createCellStyle();
HSSFFont fontFooter4 = wb.createFont();
fontFooter4.setFontHeightInPoints((short) 7);
fontFooter4.setBold(true);
styleFooter4.setFont(fontFooter4);
styleFooter4.setWrapText(true);
rowFooter4.getCell(1).setCellStyle(styleFooter4);
sh.addMergedRegion(new CellRangeAddress(resultSetVector.size()+17,resultSetVector.size()+17,1,6));   
sh.addMergedRegion(new CellRangeAddress(resultSetVector.size()+23,resultSetVector.size()+23,5,6));   
rowFooter4.setHeight((short)1000);
   
	sh.autoSizeColumn(1);

        }
	if(request.getParameter("factoring_batch_id")!=null){
            HSSFCellStyle style = wb.createCellStyle();
            style.setWrapText(true);
      		HSSFFont fontBold = wb.createFont();
      		fontBold.setBold(true);
     		 style.setFont(fontBold);
   Row rowHeaderTable = sh.createRow(0);
   rowHeaderTable.createCell(1).setCellValue("Customer Name");
   rowHeaderTable.createCell(2).setCellValue("Invoice #");
   rowHeaderTable.createCell(3).setCellValue("INV_DATE");
   rowHeaderTable.createCell(4).setCellValue("PO");
   rowHeaderTable.createCell(5).setCellValue("INVAMT");
   rowHeaderTable.setRowStyle(style);
   rowHeaderTable.setHeight((short)700);
   rowHeaderTable.getCell(1).setCellStyle(style);
   rowHeaderTable.getCell(2).setCellStyle(style);
   rowHeaderTable.getCell(3).setCellStyle(style);
   rowHeaderTable.getCell(4).setCellStyle(style);
   rowHeaderTable.getCell(5).setCellStyle(style);
sh.addMergedRegion(new CellRangeAddress(resultSetVector.size()+7,resultSetVector.size()+7,1,5));  

			for(int l=0;l<resultSetVector.size();l++){
			rowCount +=1;

					    Row row = sh.createRow(l+1);
					    Cell cellCustomer = row.createCell(1);
					    Cell cellLN = row.createCell(2);
					    Cell cellConfNo = row.createCell(3);
					    Cell cellRate = row.createCell(5);
					    Cell cellPO = row.createCell(4);
					    Cell cellAdvanceReq = row.createCell(5);
					    Cell cellMethod = row.createCell(6);
					    cellLN.setCellValue(NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[1]));
					    cellRate.setCellValue(NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[21]));
					    cellCustomer.setCellValue(NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[10]));
					    cellPO.setCellValue(NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[2]));
					    cellConfNo.setCellValue(NullCheck.check(((String[])resultSetMap.get((String)resultSetVector.get(l)))[26]));
					
			}

   Row rowTotal = sh.createRow(resultSetVector.size()+2);
   rowTotal.createCell(5).setCellValue("" + totalBatch);
	sh.autoSizeColumn(1);
	sh.autoSizeColumn(4);
	
   
   HSSFRow rowFooterTwo = sh.createRow(resultSetVector.size()+5);
   HSSFRow rowFooter4 = sh.createRow(resultSetVector.size()+7);
   HSSFRow rowFooter5 = sh.createRow(resultSetVector.size()+10);
   rowFooter5.createCell(1).setCellValue("Company Name");

HSSFCellStyle styleBorder = wb.createCellStyle();
styleBorder.setBorderBottom(HSSFCellStyle.BORDER_THIN);
styleBorder.setBorderTop(HSSFCellStyle.BORDER_THIN);
styleBorder.setBorderRight(HSSFCellStyle.BORDER_THIN);
styleBorder.setBorderLeft(HSSFCellStyle.BORDER_THIN);

   HSSFRow rowFooter6 = sh.createRow(resultSetVector.size()+11);
   rowFooter6.createCell(1).setCellValue("Company Name");
   rowFooter6.getCell(1).setCellStyle(styleBorder);
   HSSFRow rowFooter7 = sh.createRow(resultSetVector.size()+12);
   rowFooter7.createCell(1).setCellValue("Authorization Signature");
   rowFooter7.createCell(5).setCellValue("Date Advance Request");
   HSSFRow rowFooter8 = sh.createRow(resultSetVector.size()+13);
   rowFooter8.createCell(1).setCellValue("Company Name");
   rowFooter8.createCell(5).setCellValue("");
   rowFooter8.getCell(1).setCellStyle(styleBorder);
   rowFooter8.getCell(5).setCellStyle(styleBorder);
   
HSSFCellStyle styleFooter4 = wb.createCellStyle();
HSSFFont fontFooter4 = wb.createFont();
fontFooter4.setFontHeightInPoints((short) 7);
fontFooter4.setBold(true);
styleFooter4.setFont(fontFooter4);
styleFooter4.setWrapText(true);
rowFooter4.createCell(1).setCellValue("Terms: This form must be completed and signed along with a copy of the load confirmation and BOL verifying load acceptance prior to delivery of advance funds.  Advance Business Capital does not advance more than 50% or $2,000 of the total rate agreed on the Rate Confirmation. ABC charges a one-time fee of $15.00 per advance, per load. Once an advance has been given by ABC, no outside advances shall be taken. If outside advances are taken from a broker / shipper or any other financial source, ABC reserves the right to charge back the total amount advanced, plus a $50 penalty fee. Once an advance has been given by ABC the Client is required to submit their paperwork for factoring within 7 days or ABC reserves the right to charge back the total amount advanced. Standard funding transmission fees apply to all fuel advance transactions, pursuant to the Factoring and Security Agreement.");
rowFooter4.getCell(1).setCellStyle(styleFooter4); 
rowFooter4.setHeight((short)1000);

        }        
        wb.write(response.getOutputStream());
        //out2.close();
	//wb.close();  			
	         }catch (Exception ex){
	             System.out.println("" + ex);
	         }		
			
		}}

		%>