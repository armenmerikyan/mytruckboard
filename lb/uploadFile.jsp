<%@ page import="com.big.util.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,org.apache.commons.fileupload.servlet.ServletFileUpload,java.text.DateFormat,org.apache.commons.fileupload.FileItemFactory,org.apache.commons.fileupload.FileUploadException,org.apache.commons.fileupload.FileItem,org.apache.commons.fileupload.disk.DiskFileItemFactory,java.io.IOException,java.io.File,java.util.List,java.util.Iterator" %>
<%@ page import="java.util.*" %>

<%
            String root = getServletContext().getRealPath("/");

        String UUID = (String)session.getAttribute("uuid");
	    response.setContentType("application/json");
            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
	    String fileName = new String();
	    String fileSize = "0";
	    String fileNameNew = new String();
        String underScore = "_";
        String fileNameNew1 = new String ();

            try {
                List items = upload.parseRequest(request);
                Iterator iterator = items.iterator();
                while (iterator.hasNext()) {
                    FileItem item = (FileItem) iterator.next();

                    if (!item.isFormField()) {
                        fileName = item.getName();
                        fileNameNew1 = UUID.concat(underScore);
                        fileNameNew = fileNameNew1.concat(fileName);

                        File path = new File("D://Working_ART//");
                        if (!path.exists()) {
                            boolean status = path.mkdirs();
                        }

                        File uploadedFile = new File(path + "/" + fileNameNew);
                        System.out.println(uploadedFile.getAbsolutePath());
                        item.write(uploadedFile);
                        fileSize = "" + uploadedFile.length();
                    }
                }
                %>{"files": [
                {
                "name": "<%=fileNameNew%>",
                "size": "<%=fileSize%>",
                "url": "http:\/\/example.org\/files\/picture1.jpg",
                "thumbnailUrl": "http:\/\/example.org\/files\/thumbnail\/picture1.jpg",
                "deleteUrl": "http:\/\/example.org\/files\/picture1.jpg",
                "deleteType": "DELETE"
                }
                ]}<%
            } catch (Exception e) {
                System.out.println(e.getMessage() + "");
                %>{"files": [
                {
		    "name": "picture2.jpg",
		    "size": 841946,
		    "error": "Filetype not allowed"
                }
                ]}<%
            }
            
%>
                 