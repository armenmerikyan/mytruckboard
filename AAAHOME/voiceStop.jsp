<Response>
<%if(request.getParameter("Digits").equals("1")) { %>
    <Dial>+13109036014</Dial>
    <Say>The call failed or the remote party hung up. Goodbye.</Say>
<%}else{%>
    <Say>Record your message after the tone and hang up.</Say>
    <Record maxLength="30" action="voiceStop.jsp" />
<%}%>
</Response>