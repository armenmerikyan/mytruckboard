<%@ page import="com.itextpdf.text.Font,com.itextpdf.text.Rectangle,com.itextpdf.text.pdf.PdfContentByte,com.itextpdf.text.pdf.PdfPCell,com.itextpdf.text.pdf.PdfPCellEvent,com.itextpdf.text.pdf.PdfPTable,com.itextpdf.text.pdf.PdfPTableEvent,com.itextpdf.text.pdf.PdfWriter,com.itextpdf.text.pdf.BaseFont,com.itextpdf.text.Phrase,com.itextpdf.text.Element,com.itextpdf.text.pdf.ColumnText,com.itextpdf.text.pdf.PdfContentByte,com.itextpdf.text.pdf.PdfWriter,com.itextpdf.text.PageSize,com.itextpdf.text.Paragraph,com.itextpdf.text.DocumentException,com.itextpdf.text.Document,java.security.SecureRandom,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %><%@ page import="com.twilio.sdk.TwilioRestClient" %>
<%@ page import="com.twilio.sdk.resource.factory.SmsFactory" %>
<%@ page import="com.twilio.sdk.resource.instance.Sms" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.BodyPart" %>
<%@ page import="javax.mail.MessagingException" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeBodyPart" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="javax.mail.internet.MimeMultipart" %>
<%@ page import="javax.activation.FileDataSource" %>
<%@ page import="javax.activation.DataHandler" %>
<%@ page import="javax.activation.DataSource" %><%
     final String ACCOUNT_SID = "ACbc6b5f29c1627c6aa7e51f5ad340fa2d";
     final String AUTH_TOKEN = "767154b209800bd1be13e38d8a01fc1b";
     final String FROM = "info@myTruckBoard.com";   // Replace with your "From" address. This address must be verified.
     final String SMTP_USERNAME = "AKIAINFCRKGVZNSB7DHQ";  // Replace with your SMTP username.
     final String SMTP_PASSWORD = "Ar/mcRQJkM9i7Vl45r+CzSrgx/QGb+vuJIuIDfJp/mj8";  // Replace with your SMTP password.
     final String HOST = "email-smtp.us-east-1.amazonaws.com";    
     final int PORT = 25;

     String uuid = (String)session.getAttribute("uuid");

			if(uuid !=null){
		String bill_to_old = "";
		String bill_to_old_id = "";
		String bill_to_old_address = "";
		String ln_number = "";
		String ln_status = "";
		String wo_number = "";
		String type = "";
		String rate = "";
		String units = "";
		String pds = "";
		String fsc_rate = "";
		String other_charges = "";
		String rate_all = "";
		String carrier_id = "";
		String carrier_name = "";
		String carrier_address = "";
		String carrier_type = "";
		String carrier_fee = "";
		String carrier_rate = "";
		String carrier_email = "";
		String carrier_advances = "";
		String carrier_currency = "";
		String disList = "";
		String slList = "";
		String bill_to_advances = "";
		String company_info = "";
		String company_name = "";
		String currency = "";
		String carrier_phone = "";
		String carrier_fax = "";
		String carrier_company_name = "";
		String carrier_terms = "";
		String today_date = new SimpleDateFormat("MM-dd-yyyy").format(new java.sql.Timestamp((new java.util.Date()).getTime()));;
		Vector shipperList = new Vector();
		Vector consigneeList = new Vector();
		int currentPageCount = 1;
		int totalPageCount = 2;
		int totalParties = 0;
		String first_ship_date = "";
		HashMap user_map = new HashMap();
		String dispatcher_name = "";
		String dispatcher_phone = "";
		String dispatcher_fax = "";
		String dispatcher_email = "";
		String tmpFileName = "";
		
		if(request.getParameter("load_id")!=null){
	        	try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/test?zeroDateTimeBehavior=convertToNull";
			Connection connection = DriverManager.getConnection(url,"<USERNAME>", "<PASSWORD>");
			PreparedStatement psMain = null;	
			psMain = connection.prepareStatement("select * from test.TRUCKING_USERS WHERE COMPANY_ID = ?");
			psMain.setString(1, uuid);
			ResultSet resultSet = psMain.executeQuery();
			while (resultSet.next()) {
				String[] userItem = new String[4];
				userItem[0] = resultSet.getString("email");
				userItem[1] = resultSet.getString("f_name");
				userItem[2] = resultSet.getString("l_name");
				userItem[3] = resultSet.getString("phone");
				user_map.put(resultSet.getString("email") , userItem);
			}	
			psMain = connection.prepareStatement("select * from test.load_board left join test.trucking_equipment on load_board.load_equipment_id=trucking_equipment.id left join test.locations on load_board.bill_to_id = locations.location_id WHERE load_board.COMPANY_ID = ? and load_board.load_board_id = ? order by load_board.ts asc");			
			psMain.setString(1, uuid);
			psMain.setString(2, request.getParameter("load_id"));
			resultSet = psMain.executeQuery();
			while (resultSet.next()) {
				wo_number = resultSet.getString("load_wo");
				ln_status = resultSet.getString("load_status");
				ln_number = resultSet.getString("load_number_float");
				type = resultSet.getString("load_type");
				bill_to_old = NullCheck.check(resultSet.getString("locations.org_name"));
				bill_to_old_id = NullCheck.check(resultSet.getString("bill_to_id"));
				bill_to_old_address = NullCheck.check(resultSet.getString("locations.address"));
				
				carrier_advances = resultSet.getString("advances_total");
				carrier_fee = resultSet.getString("load_carrier_fee");
				carrier_rate = resultSet.getString("carrier_rate");
				other_charges = resultSet.getString("load_other");
				rate = resultSet.getString("load_rate");
				units = resultSet.getString("load_units");
				fsc_rate = resultSet.getString("load_fsc");
				rate_all = resultSet.getString("load_rate_all");
				carrier_name = NullCheck.check(resultSet.getString("trucking_equipment.name"));
				carrier_id = NullCheck.check(resultSet.getString("trucking_equipment.id"));
				carrier_address = NullCheck.check(resultSet.getString("trucking_equipment.city"));
				disList = resultSet.getString("disDetail");
				carrier_type = NullCheck.check(resultSet.getString("carrier_type"));
				slList = resultSet.getString("salDetail");
				bill_to_advances = resultSet.getString("bill_to_advances");
				pds = resultSet.getString("load_pd");
				carrier_phone =  NullCheck.check(resultSet.getString("trucking_equipment.phone"));
				carrier_fax =  NullCheck.check(resultSet.getString("trucking_equipment.fax"));
				carrier_company_name =  NullCheck.check(resultSet.getString("trucking_equipment.company_name"));
				carrier_email =  NullCheck.check(resultSet.getString("trucking_equipment.driver_email"));
				tmpFileName = NullCheck.check(resultSet.getString("load_board_id_pub"));
				if(resultSet.getString("disdetail")!=null && !resultSet.getString("disdetail").equals("")){
					for(int jk =0;jk<resultSet.getString("disdetail").split(":").length;jk++){
						if(user_map.containsKey((resultSet.getString("disdetail").split(":")[jk]))){
							dispatcher_name = NullCheck.check(((String[])user_map.get((resultSet.getString("disdetail").split(":")[jk])))[1]);
							dispatcher_name = dispatcher_name + " " + NullCheck.check(((String[])user_map.get((resultSet.getString("disdetail").split(":")[jk])))[2]);
							dispatcher_phone = NullCheck.check(((String[])user_map.get((resultSet.getString("disdetail").split(":")[jk])))[3]);
							dispatcher_email = NullCheck.check(((String[])user_map.get((resultSet.getString("disdetail").split(":")[jk])))[0]);
						}	
					}	
				}			
			}
				
				psMain = connection.prepareStatement("select * from test.trucking_company where COMPANY_ID = ? ");
				psMain.setString(1, uuid);
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					company_name = NullCheck.check(resultSet.getString("NAME"));
					company_info = company_info + NullCheck.check(resultSet.getString("address")) + "\n";
					company_info = company_info + NullCheck.check(resultSet.getString("email")) + "\n" + NullCheck.check(resultSet.getString("phone"));
				}
				
				psMain = connection.prepareStatement("select * from test.locations right join test.load_board_line on locations.location_id=load_board_line.shipper_id left join test.locations as customs on load_board_line.customs_id=customs.location_id WHERE load_board_line.COMPANY_ID = ? and load_id = ? order by load_board_line.ts asc");
				psMain.setString(1, uuid);
				psMain.setString(2, request.getParameter("load_id"));
				resultSet = psMain.executeQuery();
				int shipCount = 0;
				while (resultSet.next()) {
					String[] tmpRow = new String[13];
					tmpRow[0] = resultSet.getString("load_line_id");
					if(resultSet.getTimestamp("pickup_date")!=null){
						tmpRow[1] = new SimpleDateFormat("MM-dd-yyyy").format(resultSet.getTimestamp("pickup_date"));
						tmpRow[2] = new SimpleDateFormat("HH:mm").format(resultSet.getTimestamp("pickup_date"));
						if(first_ship_date.equals(""))first_ship_date = new SimpleDateFormat("MM-dd-yyyy").format(resultSet.getTimestamp("pickup_date"));
					}
					 
					tmpRow[3] = resultSet.getString("type");
					tmpRow[4] = resultSet.getString("units");
					tmpRow[5] = resultSet.getString("weight");
					tmpRow[6] = "";
					tmpRow[7] = resultSet.getString("po_numbers");
					tmpRow[8] = resultSet.getString("description");
					tmpRow[9] = NullCheck.check(resultSet.getString("locations.org_name"));
					tmpRow[11] = NullCheck.check(resultSet.getString("address2"));
					tmpRow[12] = NullCheck.check(resultSet.getString("address"));
					tmpRow[10] = resultSet.getString("load_board_line.notes");

					shipperList.add(tmpRow);
					totalParties +=1;
				}
				psMain = connection.prepareStatement("select * from test.locations right join test.load_board_line_consignee on locations.location_id=load_board_line_consignee.consignee_id WHERE load_board_line_consignee.COMPANY_ID = ? and load_id = ? order by load_board_line_consignee.ts asc");
				psMain.setString(1, uuid);
				psMain.setString(2, request.getParameter("load_id"));
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					String[] tmpRow = new String[13];
					tmpRow[0] = resultSet.getString("load_line_id");
					if(resultSet.getTimestamp("pickup_date")!=null){
						tmpRow[1] = new SimpleDateFormat("MM-dd-yyyy").format(resultSet.getTimestamp("pickup_date"));
						tmpRow[2] = new SimpleDateFormat("HH:mm").format(resultSet.getTimestamp("pickup_date"));
					}
					tmpRow[3] = resultSet.getString("type");
					tmpRow[4] = resultSet.getString("units");
					tmpRow[5] = resultSet.getString("weight");
					tmpRow[6] = "";
					tmpRow[7] = resultSet.getString("po_numbers");
					tmpRow[8] = resultSet.getString("description");
					tmpRow[9] = NullCheck.check(resultSet.getString("locations.org_name"));
					tmpRow[11] = NullCheck.check(resultSet.getString("address2"));
					tmpRow[12] = NullCheck.check(resultSet.getString("address"));
					tmpRow[10] = resultSet.getString("load_board_line_consignee.notes");

					consigneeList.add(tmpRow);	
					totalParties +=1;
				}	
				psMain = connection.prepareStatement("select * from test.trucking_company_dispatch_terms where COMPANY_ID = ? limit 1 ");
				psMain.setString(1, uuid);
				resultSet = psMain.executeQuery();
				while (resultSet.next()) {
					carrier_terms = resultSet.getString("term");
				}			
				
			connection.close();
			 }catch (Exception ex){
			     %><%="Error Posting " + ex%><%
			     System.out.println(""+ ex);
			 }	         

	         }
        try {
            // step 1
            Document document = new Document(PageSize.LETTER);
            // step 2
            PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream("H:\\maidsSecure\\pdfEmails\\" + tmpFileName+".pdf"));
            // step 3
            document.open();
            // step 4
//            document.add(new Paragraph("My Truck Board Rate and Load Confirmation"));
//            document.add(new Paragraph("Carrier Rate"+ carrier_rate));
//            document.add(new Paragraph("Truck Name: "+ carrier_name));
//            document.add(new Paragraph("Load Number: LN"+ ln_number));        

	   if(totalParties<=2){
	   	totalPageCount = 2;
	   }else {
	   	totalPageCount = ((totalParties - 2)/2) + 2 ;
	   	if((totalParties - 2)%2>0)totalPageCount+=1;
	   }
           if(true){ 
        float[] columnWidth = {10,5,7};
 	PdfPTable table = new PdfPTable(columnWidth);
 	table.setWidthPercentage(100);
 	Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18, Font.BOLD);
        PdfPCell cellTitle = new PdfPCell(new Phrase("Rate and Load Confirmation\n\n", boldFont));
 	cellTitle.setBorder(PdfPCell.NO_BORDER);
 	cellTitle.setColspan(3);
 	cellTitle.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(cellTitle);  
 	
 	Font boldFontName = new Font(Font.FontFamily.TIMES_ROMAN, 16, Font.BOLD);
        PdfPCell cell = new PdfPCell(new Phrase(company_name, boldFontName));
 	cell.setBorder(PdfPCell.NO_BORDER);
 	cell.setRowspan(1);
        table.addCell(cell);    
        table.addCell("Load #");
        table.addCell("LN" + ln_number);

        PdfPCell celladd = new PdfPCell(new Phrase(company_info));
 	celladd.setBorder(PdfPCell.NO_BORDER);
 	celladd.setRowspan(8);
        table.addCell(celladd);        


        table.addCell("Page");
        table.addCell(currentPageCount + " of " + totalPageCount);
        table.addCell("Today's Date");
        table.addCell(today_date);
        table.addCell("Ship Date");
        table.addCell(first_ship_date);
        table.addCell("Dispatcher");
        table.addCell(dispatcher_name);
        table.addCell("Email");
        table.addCell(dispatcher_email);
        table.addCell("Phone");
        table.addCell(dispatcher_phone);
        table.addCell("Fax");
        table.addCell("");
        table.addCell("W/O Num");
        table.addCell(wo_number);
        document.add(table);
        	}
        document.add(new Phrase("\n\n"));
        float[] columnWidthCarrier = {3,2,2,2,2};
 	PdfPTable tableCarrier = new PdfPTable(columnWidthCarrier);
 	tableCarrier.setWidthPercentage(100);
        tableCarrier.addCell("Carrier - $" + currency);
        tableCarrier.addCell("Telephone #");
        tableCarrier.addCell("Fax #");
        tableCarrier.addCell("Equipment");
        tableCarrier.addCell("Agreed Amount");
        tableCarrier.addCell(carrier_company_name);
        tableCarrier.addCell(carrier_phone);
        tableCarrier.addCell(carrier_fax);
        tableCarrier.addCell(carrier_type);
        tableCarrier.addCell("$"+carrier_rate);
        document.add(tableCarrier);

        document.add(new Phrase("\n"));
        Font boldFontTerm = new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.NORMAL); 
        
        
        
  	int partiesCountPrinted = 0;
  	int shpPrintCount = 0;
        for(int j = 0;j<shipperList.size();j++){ 
        if(partiesCountPrinted >1 && (partiesCountPrinted)%2==0){
        	document.newPage();
        	currentPageCount += 1;
           if(true){ 
        float[] columnWidth = {10,5,7};
 	PdfPTable table = new PdfPTable(columnWidth);
 	table.setWidthPercentage(100);
 	Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18, Font.BOLD);
        PdfPCell cellTitle = new PdfPCell(new Phrase("Rate and Load Confirmation\n\n", boldFont));
 	cellTitle.setBorder(PdfPCell.NO_BORDER);
 	cellTitle.setColspan(3);
 	cellTitle.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(cellTitle);  
 	
 	Font boldFontName = new Font(Font.FontFamily.TIMES_ROMAN, 16, Font.BOLD);
        PdfPCell cell = new PdfPCell(new Phrase(company_name, boldFontName));
 	cell.setBorder(PdfPCell.NO_BORDER);
 	cell.setRowspan(1);
        table.addCell(cell);    
        table.addCell("Load #");
        table.addCell("LN" + ln_number);

        PdfPCell celladd = new PdfPCell(new Phrase(company_info));
 	celladd.setBorder(PdfPCell.NO_BORDER);
 	celladd.setRowspan(8);
        table.addCell(celladd);        


        table.addCell("Page");
        table.addCell(currentPageCount + " of " + totalPageCount);
        table.addCell("Today's Date");
        table.addCell(today_date);
        table.addCell("Ship Date");
        table.addCell(first_ship_date);
        table.addCell("Dispatcher");
        table.addCell(dispatcher_name);
        table.addCell("Email");
        table.addCell(dispatcher_email);
        table.addCell("Phone");
        table.addCell(dispatcher_phone);
        table.addCell("Fax");
        table.addCell("");
        table.addCell("W/O Num");
        table.addCell(wo_number);
        document.add(table);
        document.add(new Phrase("\n", boldFontTerm));     
        	}            	
        }
        float[] columntableShipper = {3,2,2,2};
 	PdfPTable tableShipper = new PdfPTable(columntableShipper);
 	tableShipper.setWidthPercentage(100); 	 	
 	shpPrintCount +=1;
        PdfPCell celladdSHPHeader = new PdfPCell(new Phrase("Shipper " + shpPrintCount));
 	celladdSHPHeader.setColspan(5);
        tableShipper.addCell(celladdSHPHeader); 
        
        PdfPCell celladdSHPLoc = new PdfPCell(new Phrase( ((String[])shipperList.get(j))[9] + "\n" + ((String[])shipperList.get(j))[12] ));
 	celladdSHPLoc.setRowspan(6);
        tableShipper.addCell(celladdSHPLoc); 

        tableShipper.addCell("Date");
        tableShipper.addCell(((String[])shipperList.get(j))[1]);

        PdfPCell celladdSHPpo = new PdfPCell(new Phrase(((String[])shipperList.get(j))[7]));
 	celladdSHPpo.setRowspan(2);
        tableShipper.addCell(celladdSHPpo); 
        
        tableShipper.addCell("Time");
        tableShipper.addCell(((String[])shipperList.get(j))[2]);
        
        tableShipper.addCell("Type" );
        tableShipper.addCell(((String[])shipperList.get(j))[3]);
        
        PdfPCell celladdSHPdes = new PdfPCell(new Phrase(((String[])shipperList.get(j))[8]));
 	celladdSHPdes.setRowspan(2);
        tableShipper.addCell(celladdSHPdes); 
        tableShipper.addCell("Units" );
        tableShipper.addCell(((String[])shipperList.get(j))[4] );
        
        tableShipper.addCell("Weight" );
        tableShipper.addCell(((String[])shipperList.get(j))[5]); 	
        
        PdfPCell celladdSHPcrs = new PdfPCell(new Phrase(""));
 	celladdSHPcrs.setRowspan(2);
        tableShipper.addCell(celladdSHPcrs); 
        tableShipper.addCell("Ship Time" );
        tableShipper.addCell("" );
        
        
        tableShipper.addCell(((String[])shipperList.get(j))[11]);
        PdfPCell celladdSHPnote = new PdfPCell(new Phrase(((String[])shipperList.get(j))[10]));
 	celladdSHPnote.setColspan(3);
        tableShipper.addCell(celladdSHPnote); 
        
        document.add(tableShipper);
        document.add(new Phrase("\n"));
        partiesCountPrinted += 1;
 	}   
 	
        document.add(new Phrase("\n"));
        int conPrintCount = 0;
        for(int j = 0;j<consigneeList.size();j++){  
        if(partiesCountPrinted >1 && (partiesCountPrinted)%2==0){
        	document.newPage();
        	currentPageCount += 1;
           if(true){ 
        float[] columnWidth = {10,5,7};
 	PdfPTable table = new PdfPTable(columnWidth);
 	table.setWidthPercentage(100);
 	Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18, Font.BOLD);
        PdfPCell cellTitle = new PdfPCell(new Phrase("Rate and Load Confirmation\n\n", boldFont));
 	cellTitle.setBorder(PdfPCell.NO_BORDER);
 	cellTitle.setColspan(3);
 	cellTitle.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(cellTitle);  
 	
 	Font boldFontName = new Font(Font.FontFamily.TIMES_ROMAN, 16, Font.BOLD);
        PdfPCell cell = new PdfPCell(new Phrase(company_name, boldFontName));
 	cell.setBorder(PdfPCell.NO_BORDER);
 	cell.setRowspan(1);
        table.addCell(cell);    
        table.addCell("Load #");
        table.addCell("LN" + ln_number);

        PdfPCell celladd = new PdfPCell(new Phrase(company_info));
 	celladd.setBorder(PdfPCell.NO_BORDER);
 	celladd.setRowspan(8);
        table.addCell(celladd);        


        table.addCell("Page");
        table.addCell(currentPageCount + " of " + totalPageCount);
        table.addCell("Today's Date");
        table.addCell(today_date);
        table.addCell("Ship Date");
        table.addCell(first_ship_date);
        table.addCell("Dispatcher");
        table.addCell(dispatcher_name);
        table.addCell("Email");
        table.addCell(dispatcher_email);
        table.addCell("Phone");
        table.addCell(dispatcher_phone);
        table.addCell("Fax");
        table.addCell("");
        table.addCell("W/O Num");
        table.addCell(wo_number);
        document.add(table);
        document.add(new Phrase("\n", boldFontTerm));   
        	}            	
        }
        float[] columntableShipper = {3,2,2,2};
 	PdfPTable tableShipper = new PdfPTable(columntableShipper);
 	tableShipper.setWidthPercentage(100); 	 	
 	conPrintCount +=1;
        PdfPCell celladdSHPHeader = new PdfPCell(new Phrase("Consignee " + conPrintCount));
 	celladdSHPHeader.setColspan(5);
        tableShipper.addCell(celladdSHPHeader); 
        
        PdfPCell celladdSHPLoc = new PdfPCell(new Phrase( ((String[])consigneeList.get(j))[9] + "\n" + ((String[])consigneeList.get(j))[12] ));
 	celladdSHPLoc.setRowspan(6);
        tableShipper.addCell(celladdSHPLoc); 

        tableShipper.addCell("Date");
        tableShipper.addCell(((String[])consigneeList.get(j))[1]);

        PdfPCell celladdSHPpo = new PdfPCell(new Phrase(((String[])consigneeList.get(j))[7]));
 	celladdSHPpo.setRowspan(2);
        tableShipper.addCell(celladdSHPpo); 
        
        tableShipper.addCell("Time");
        tableShipper.addCell(((String[])consigneeList.get(j))[2]);
        
        tableShipper.addCell("Type" );
        tableShipper.addCell(((String[])consigneeList.get(j))[3]);
        
        PdfPCell celladdSHPdes = new PdfPCell(new Phrase(((String[])consigneeList.get(j))[8]));
 	celladdSHPdes.setRowspan(2);
        tableShipper.addCell(celladdSHPdes); 
        tableShipper.addCell("Units" );
        tableShipper.addCell(((String[])consigneeList.get(j))[4] );
        
        tableShipper.addCell("Weight" );
        tableShipper.addCell(((String[])consigneeList.get(j))[5]); 	
        
        PdfPCell celladdSHPcrs = new PdfPCell(new Phrase(""));
 	celladdSHPcrs.setRowspan(2);
        tableShipper.addCell(celladdSHPcrs); 
        tableShipper.addCell("Rec. Time" );
        tableShipper.addCell("" );
        
        
        tableShipper.addCell(((String[])consigneeList.get(j))[11]);
        PdfPCell celladdSHPnote = new PdfPCell(new Phrase(((String[])consigneeList.get(j))[10]));
 	celladdSHPnote.setColspan(3);
        tableShipper.addCell(celladdSHPnote); 
        
        document.add(tableShipper); 
        document.add(new Phrase("\n"));
        partiesCountPrinted += 1;
 	}    
 	
        currentPageCount += 1;   
        document.newPage();
           if(true){ 
        float[] columnWidth = {10,5,7};
 	PdfPTable table = new PdfPTable(columnWidth);
 	table.setWidthPercentage(100);
 	Font boldFont = new Font(Font.FontFamily.TIMES_ROMAN, 18, Font.BOLD);
        PdfPCell cellTitle = new PdfPCell(new Phrase("Rate and Load Confirmation\n\n", boldFont));
 	cellTitle.setBorder(PdfPCell.NO_BORDER);
 	cellTitle.setColspan(3);
 	cellTitle.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(cellTitle);  
 	
 	Font boldFontName = new Font(Font.FontFamily.TIMES_ROMAN, 16, Font.BOLD);
        PdfPCell cell = new PdfPCell(new Phrase(company_name, boldFontName));
 	cell.setBorder(PdfPCell.NO_BORDER);
 	cell.setRowspan(1);
        table.addCell(cell);    
        table.addCell("Load #");
        table.addCell("LN" + ln_number);

        PdfPCell celladd = new PdfPCell(new Phrase(company_info));
 	celladd.setBorder(PdfPCell.NO_BORDER);
 	celladd.setRowspan(8);
        table.addCell(celladd);        


        table.addCell("Page");
        table.addCell(currentPageCount + " of " + totalPageCount);
        table.addCell("Today's Date");
        table.addCell(today_date);
        table.addCell("Ship Date");
        table.addCell(first_ship_date);
        table.addCell("Dispatcher");
        table.addCell(dispatcher_name);
        table.addCell("Email");
        table.addCell(dispatcher_email);
        table.addCell("Phone");
        table.addCell(dispatcher_phone);
        table.addCell("Fax");
        table.addCell("");
        table.addCell("W/O Num");
        table.addCell(wo_number);
        document.add(table);
        	}     	
        Font boldFontTermBOLD = new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.BOLD);
        
        document.add(new Phrase("\n", boldFontTerm));  
        document.add(new Phrase("CARRIER PAY: ", boldFontTermBOLD));  
        document.add(new Phrase("Line Haul $" + carrier_rate, boldFontTerm));  
        document.add(new Phrase("\n", boldFontTerm));  
        document.add(new Phrase("DISPATCH NOTES: ", boldFontTermBOLD));  
        document.add(new Phrase(carrier_terms, boldFontTerm));
        document.add(new Phrase("\n", boldFontTerm)); 
        document.add(new Phrase("\n", boldFontTerm)); 
        document.add(new Phrase("\n", boldFontTerm)); 
        document.add(new Phrase("Load Accepted By: ______________________________", boldFontTerm)); 
        document.add(new Phrase("  Date: __________  Signature:____________________________________\n", boldFontTerm)); 
        document.add(new Phrase("\n", boldFontTerm)); 
        document.add(new Phrase("Driver Name: ________________________  Cell Phone:___________________  Truck #: ___________  Trailer #: ______________\n", boldFontTerm)); 
        document.close();
        
        
        
	Properties props = System.getProperties();
	props.put("mail.transport.protocol", "smtp");
	props.put("mail.smtp.port", PORT); 
	props.put("mail.smtp.auth", "true");
	props.put("mail.smtp.starttls.enable", "true");
	props.put("mail.smtp.starttls.required", "true");
	javax.mail.Session sessionMail = javax.mail.Session.getDefaultInstance(props);
	MimeMessage msg = new MimeMessage(sessionMail);
	msg.setFrom(new InternetAddress(FROM));
	msg.setRecipient(Message.RecipientType.TO, new InternetAddress(carrier_email));
	msg.setSubject("Load Confirmation");
	String email_footer = " <BR> This email is sent because it was used to register to Yawadi App.com for more info visit www.Yawadi.com. <BR><B>Please use the following Promo Code to save 20% Off</B>";
	//msg.setContent("Some email Test " + email_footer,"text/html; charset=utf-8");

 // creates message part
     BodyPart part = new MimeBodyPart();
     String myText = "<h1>Load Confirmation</h1>";
     part.setContent(myText, "text/html");
   
     // Add a MIME part to the message
     MimeMultipart mp = new MimeMultipart();
     mp.addBodyPart(part);
     BodyPart attachment = null;
       attachment = new MimeBodyPart();
       DataSource source = new FileDataSource("H:\\maidsSecure\\pdfEmails\\" + tmpFileName+".pdf");
       attachment.setDataHandler(new DataHandler(source));
       attachment.setFileName(source.getName());
       mp.addBodyPart(attachment);
       msg.setContent(mp);
	Transport transport = sessionMail.getTransport();
	System.out.println("Attempting to send an email through the Amazon SES SMTP interface..." + request.getParameter("email"));
	transport.connect(HOST, SMTP_USERNAME, SMTP_PASSWORD);
	transport.sendMessage(msg, msg.getAllRecipients());
	System.out.println("Email sent!");
	transport.close(); 
	%>Email Sent<%
        } catch (DocumentException de) {
            throw new IOException(de.getMessage());
        }
        }%>