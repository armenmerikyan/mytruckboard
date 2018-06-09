<%@ page import="com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat,org.apache.commons.fileupload.servlet.ServletFileUpload,java.text.DateFormat,org.apache.commons.fileupload.FileItemFactory,org.apache.commons.fileupload.FileUploadException,org.apache.commons.fileupload.FileItem,org.apache.commons.fileupload.disk.DiskFileItemFactory,java.io.IOException,java.io.File,java.util.List,java.util.Iterator" %><%
System.out.println("File Name BeingUploaded Executed : ");
String id = ""; 
String maid_id = ""; 
boolean isMultipartContent = ServletFileUpload.isMultipartContent(request);
            String root = getServletContext().getRealPath("/");
            File path = new File("H:\\maidsSecure\\uploadDocs");
            File filePath = new File(path + "/" + id ); 

            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
	    String fileName = new String();
	    boolean isNewFile = false;
            try {
                List items = upload.parseRequest(request);
                Iterator iterator = items.iterator();
                String exp_date = "";
                while (iterator.hasNext()) {
                    FileItem item = (FileItem) iterator.next();

                    if (!item.isFormField()) {
                        	fileName = item.getName();
				isNewFile = true;
				if (!path.exists()) {
				    boolean status = path.mkdirs();
				}
				filePath = new File(path + "/" + id );
				if (!filePath.exists()) {
					filePath.mkdirs();
				}	
					System.out.println(id);
					System.out.println("FILE NAME BEING ID XXXXXXX :" + id);
					File uploadedFile = new File(path + "/" + id +  "/face.pic." + fileName);
					System.out.println("File Name BeingUploaded : " + uploadedFile.getAbsolutePath());
					item.write(uploadedFile);
                       
                    }else{
                    	
				System.out.println("FILE NAME BEING UPLOADED :" + item.getFieldName());
			if(item.getFieldName().equals("CLIENT_ID")){
			 	id = item.getString(); 
				System.out.println("FILE NAME BEING UPLOADED Value :" + id);
			 	
			}else{
				System.out.println("File Name BeingUploaded : " + id);
				System.out.println("File Name BeingUploaded Field Name : " + item.getFieldName());
			
			} 
                    }
                    
                }	
            } catch (Exception e) {
                %><%=e.getMessage() + ""%><%
            }
//}    
			
%><%=id%>