<%@ page import="org.apache.http.client.fluent.Form,org.apache.http.client.fluent.Request,org.apache.http.client.methods.HttpGet,org.apache.http.Header,org.apache.http.HttpResponse,org.apache.http.NameValuePair,org.apache.http.client.entity.UrlEncodedFormEntity,org.apache.http.message.BasicNameValuePair,org.apache.http.client.methods.HttpPost,org.apache.http.impl.client.DefaultHttpClient,org.apache.http.client.HttpClient,com.big.util.*,java.text.*,java.util.*,java.io.*,javax.xml.parsers.*,org.w3c.dom.*,java.sql.*,java.text.DateFormat" %>
        <%
			String insONNeeded = "";
			String insONFile = "";
			String addressOnFile = "";
			String address1 = "";
			String city = "";
			String state = "";
			String zip = "";
			String phone = "";
			String fax = "";
			String company_name = "";
			String company_dba = "";
			String mc_number = request.getParameter("MC_NO");
        if(request.getParameter("MC_NO")!=null && !request.getParameter("MC_NO").equals("")){
	  try{
			if(request.getParameter("MC_NO").toUpperCase().startsWith("MC"))mc_number = request.getParameter("MC_NO").substring(2,request.getParameter("MC_NO").length());
			String url420 = "http://safersys.org/query.asp";

			HttpClient client = new DefaultHttpClient();
			HttpPost post = new HttpPost(url420);

			// add header
			post.setHeader("User-Agent", "ios");

			java.util.List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
			urlParameters.add(new BasicNameValuePair("searchType", "ANY"));
			urlParameters.add(new BasicNameValuePair("query_type", "queryCarrierSnapshot"));
			urlParameters.add(new BasicNameValuePair("query_param", "MC_MX"));
			//urlParameters.add(new BasicNameValuePair("query_string", "805232"));
			urlParameters.add(new BasicNameValuePair("query_string", mc_number));



			post.setEntity(new UrlEncodedFormEntity(urlParameters));

			HttpResponse response2 = client.execute(post);
			System.out.println("Post parameters : " + post.getEntity());
			System.out.println("Response Code : " +
	                                    response2.getStatusLine().getStatusCode());

			BufferedReader rd = new BufferedReader(
	                        new InputStreamReader(response2.getEntity().getContent()));

			StringBuffer result = new StringBuffer();
			String line = "";
			while ((line = rd.readLine()) != null) {
				result.append(line);
			}
			String cookieString = new String();
			if(true){
				Header[] cookies = response2.getAllHeaders();
				for(int j=0;j<cookies.length;j++){
					if(cookies[j].getName().equals("Set-Cookie")){
						cookieString = cookies[j].getValue();
					}
				}
			}
			//li-public.fmcsa.dot.gov/LIVIEW/pkg_carrquery.prc_carrlist?n_dotno=2352004&s_prefix=MC&n_docketno=&s_legalname=&s_dbaname=&s_state=

				HttpClient client2 = new DefaultHttpClient();
				String pv_apcant_id= "";
			if(true){
				String insuranceInfo = result.substring(result.indexOf("li-public"), result.indexOf("s_state=")+8);
				HttpGet newget = new HttpGet("http://" + insuranceInfo);
				System.out.println(result.toString());
				System.out.println(insuranceInfo);
				newget.setHeader("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:34.0) Gecko/20100101 Firefox/34.0");
				newget.setHeader("Connection", "keep-alive");
				HttpResponse responseTwo = client2.execute(newget);
				BufferedReader rd2 = new BufferedReader(
		                        new InputStreamReader(responseTwo.getEntity().getContent()));
				StringBuffer result2 = new StringBuffer();
				String line2 = "";
				while ((line2 = rd2.readLine()) != null) {
					result2.append(line2);
				}
				pv_apcant_id = result2.toString().substring(result2.toString().indexOf("pv_apcant_id"), result2.toString().length());
				pv_apcant_id = pv_apcant_id.substring(pv_apcant_id.indexOf("VALUE"), pv_apcant_id.indexOf(">"));
				pv_apcant_id = pv_apcant_id.substring(pv_apcant_id.indexOf("\"")+1, pv_apcant_id.length()-1);
				System.out.println(result2);
				Header[] cookies = responseTwo.getAllHeaders();
				for(int j=0;j<cookies.length;j++){
					if(cookies[j].getName().equals("Set-Cookie")){
						System.out.println(cookies[j].getName());
					}
				}

			}
			if(true){
				HttpClient client3 = new DefaultHttpClient();
				HttpPost newget = new HttpPost("http://li-public.fmcsa.dot.gov/LIVIEW/pkg_carrquery.prc_getdetail");
//				newget.setHeader("Referer", "http://localhost:81/LIVIEW/pkg_carrquery.prc_carrlist?n_dotno=2352004&s_prefix=MC&n_docketno=&s_legalname=&s_dbaname=&s_state=");
				java.util.List<NameValuePair> urlParameters2 = new ArrayList<NameValuePair>();
				urlParameters2.add(new BasicNameValuePair("pv_apcant_id", pv_apcant_id));
				urlParameters2.add(new BasicNameValuePair("pv_vpath", "LIVIEW"));
				urlParameters2.add(new BasicNameValuePair("submit", "HTML"));
				newget.setEntity(new UrlEncodedFormEntity(urlParameters2));
				cookieString = cookieString.substring(0, cookieString.indexOf(";"));
				String insuranceInfo = result.substring(result.indexOf("li-public"), result.indexOf("s_state=")+8);
				System.out.println(cookieString);
				insuranceInfo = insuranceInfo.replace("pkg_carrquery.prc_carrlist", "pkg_carrquery.prc_getdetail");
				insuranceInfo = insuranceInfo.substring(0,insuranceInfo.indexOf("?"));
				//System.out.println(insuranceInfo);


				String urlParameters22 = "pv_apcant_id="+pv_apcant_id+"&pv_vpath=LIVIEW&submit=HTML";
				String insuranceInfoString = Request.Post("http://li-public.fmcsa.dot.gov/LIVIEW/pkg_carrquery.prc_getdetail")
			            .bodyForm(Form.form().add("pv_vpath", "LIVIEW").add("pv_apcant_id", pv_apcant_id).build())
			            .execute()
			            .returnContent() + "";
				System.out.println(insuranceInfoString);
				String mainResponse = insuranceInfoString;
				insuranceInfoString = insuranceInfoString.substring(insuranceInfoString.indexOf("bipd Insurance_required"), insuranceInfoString.length());
				String insNeeded = insuranceInfoString.substring(insuranceInfoString.indexOf("$"), insuranceInfoString.indexOf("</FONT>"));
				String insOnFile = insuranceInfoString.substring(insuranceInfoString.indexOf("bipd Insurance_on_file"), insuranceInfoString.length());
				addressOnFile = mainResponse.substring(mainResponse.indexOf("Undeliverable"), mainResponse.indexOf("Authority Type"));
				addressOnFile = addressOnFile.substring(addressOnFile.indexOf("TR"),addressOnFile.length());				
				addressOnFile = addressOnFile.substring(addressOnFile.indexOf("<TD"),addressOnFile.indexOf("</TD>"));				
				addressOnFile = addressOnFile.substring(addressOnFile.indexOf("<font"),addressOnFile.indexOf("FONT>"));				
				address1 = addressOnFile.substring(addressOnFile.indexOf(">")+1,addressOnFile.indexOf("<div"));				
				address1 = address1.substring(0,address1.indexOf("&nb"));					
				addressOnFile = addressOnFile.substring(addressOnFile.indexOf("<div>")+5,addressOnFile.length());			
				addressOnFile = addressOnFile.substring(addressOnFile.indexOf(">")+1,addressOnFile.length());				
				addressOnFile = addressOnFile.substring(0, addressOnFile.indexOf("<"));	
				zip = addressOnFile.substring(addressOnFile.length()-5,addressOnFile.length());
				state = addressOnFile.substring(addressOnFile.length()-8,addressOnFile.length()-6);
				city = addressOnFile.substring(0, addressOnFile.length()-8);
				phone = mainResponse.substring(mainResponse.indexOf(addressOnFile),mainResponse.length());
				phone = phone.substring(phone.indexOf("TD>"),phone.length());
				fax = phone.substring(phone.indexOf("("), phone.indexOf("&nb"));
				phone = phone.substring(phone.indexOf("("), phone.indexOf("<div>"));			
				phone = phone.substring(0,phone.indexOf("&nb"));
				company_name = mainResponse.substring(mainResponse.indexOf("Legal Name:"), mainResponse.length());
				company_name = company_name.substring(company_name.indexOf("<font"), company_name.length());
				company_name = company_name.substring(company_name.indexOf(">")+1, company_name.indexOf("</"));
				company_name = company_name.substring(company_name.indexOf(";")+1, company_name.length());
				//address1
				//addressOnFile = addressOnFile.substring(addressOnFile.indexOf("<font"), addressOnFile.indexOf("FONT>"));
				
				insOnFile = insOnFile.substring(insOnFile.indexOf("$"), insOnFile.indexOf("</FONT>"));
				System.out.println(insNeeded + " ON FILE " + insOnFile);
				insONNeeded = insNeeded;
				insONFile = insOnFile;
//				newget.setHeader("Host", "li-public.fmcsa.dot.gov");
//				newget.setHeader("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:34.0) Gecko/20100101 Firefox/34.0");
//				newget.setHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");
				//newget.setHeader("Cookie", "__utma=111872281.1865579170.1424719768.1424733394.1424746402.3; __utmc=111872281; __utmz=111872281.1424719768.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); __utmb=111872281.5.10.1424746402; __utmt_GSA_CP=1");
				//newget.setHeader("Connection", "keep-alive");
				//newget.setHeader(HTTP.CONTENT_LEN,"-1");
				HttpResponse responseTwo = client3.execute(newget);
				//pkg_carrquery.prc_getdetail
				BufferedReader rd2 = new BufferedReader(
		                        new InputStreamReader(responseTwo.getEntity().getContent()));
				StringBuffer result2 = new StringBuffer();
				String line2 = "";
				while ((line2 = rd2.readLine()) != null) {
					result2.append(line2);

				}

				//System.out.println(result2.toString());
			}
			//pkg_carrquery.prc_getdetail
			///LIVIEW/pkg_carrquery.prc_carrlist?n_dotno=2352004&s_prefix=MC&n_docketno=&s_legalname=&s_dbaname=&s_state=
	  }catch(Exception Ex){
		  System.out.println("Error BIG" + Ex);
		  %>START<ITEM><%=insONNeeded%><ITEM><%=insONFile%><ITEM><%=address1%><ITEM><%=city%><ITEM><%=state%><ITEM><%=zip%><ITEM><%=phone%><ITEM><%=fax%><ITEM><%=company_name%><ITEM>DONE<%
	  }

    %>
    START<ITEM><%=insONNeeded%><ITEM><%=insONFile%><ITEM><%=address1%><ITEM><%=city%><ITEM><%=state%><ITEM><%=zip%><ITEM><%=phone%><ITEM><%=fax%><ITEM><%=company_name%><ITEM>DONE
    <%}else{
		  %>START<ITEM><%=insONNeeded%><ITEM><%=insONFile%><ITEM><%=address1%><ITEM><%=city%><ITEM><%=state%><ITEM><%=zip%><ITEM><%=phone%><ITEM><%=fax%><ITEM><%=company_name%><ITEM>DONE<%    
    }%>