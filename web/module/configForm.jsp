<%@ include file="/WEB-INF/template/include.jsp" %>

<openmrs:require privilege="View Patients, View Patient Cohorts" otherwise="/login.htm" redirect="/module/patientmatching/config.list" />

<%@ include file="/WEB-INF/template/header.jsp" %>
<%@ include file="localHeader.jsp" %>

<br />

<script type="text/javascript">
    function selectOnly(fieldName) {
        var blocking = "blocking";
        var selected = "selected";
        
        var fieldSep = fieldName.indexOf(".");
        var objectName = fieldName.substring(0, fieldSep + 1);
        
        var selectedField = document.getElementById(objectName + selected);
        var blockingField = document.getElementById(objectName + blocking);
        
        if (fieldName == selectedField.name) {
            if(selectedField.checked) {
                blockingField.checked = false;
            }
        } else {
            if(blockingField.checked) {
                selectedField.checked = false;
            }
        }
    }
</script>

<form method="post">
<b class="boxHeader"><spring:message code="patientmatching.config.new"/></b>
<div class="box">
    <table cellspacing="2" cellpadding="2">
        <tr>
            <td><spring:message code="patientmatching.config.new.name"/></td>
            <td>
            <spring:bind path="patientMatchingConfig.configName">
                <input type="text" 
                    name="${status.expression}" id="${status.expression}"
                    value="${status.value}" size="40" />
            </spring:bind>
            </td>
        </tr>
    </table>
    <table cellspacing="2" cellpadding="2">
        <tr>
            <td colspan="2">
            <spring:bind path="patientMatchingConfig.useRandomSampling">
                <input type="hidden" name="_<c:out value="${status.expression}"/>">
                <input type="checkbox" name="<c:out value="${status.expression}"/>" value="true"
                    <c:if test="${status.value}">checked</c:if>/>
            </spring:bind><spring:message code="patientmatching.config.new.useRandomSampling"/>
            </td>
        </tr>
        <tr>
            <td><spring:message code="patientmatching.config.new.randomSampleSize"/></td>
            <td>
            <spring:bind path="patientMatchingConfig.randomSampleSize">
                <input type="text" 
                    name="${status.expression}" id="${status.expression}"
                    value="${status.value}" size="10" />
            </spring:bind>
            </td>
        </tr>
    </table>
    <table table cellspacing="2" cellpadding="2">
        <tr>
            <td valign="top">
                <b class="boxHeader"><spring:message code="patientmatching.config.new.availableField"/></b>
                <div class="box">
                    <table cellspacing="2" cellpadding="2">
                        <tr>
                            <th><spring:message code="patientmatching.config.new.fieldName"/></th>
                            <th><spring:message code="patientmatching.config.new.fieldNameInclude"/></th>
                            <th><spring:message code="patientmatching.config.new.fieldNameBlocking"/></th>
                        </tr>
                        <c:forEach items="${patientMatchingConfig.configEntries}" var="configEntry" varStatus="entriesIndex">
                            <tr>
                                <td nowrap="nowrap">
                                    <spring:message code="${configEntry.fieldName}"/>
                                </td>
                                <td align="center">
                                <spring:bind path="patientMatchingConfig.configEntries[${entriesIndex.count - 1}].selected">
                                    <input type="hidden" name="_<c:out value="${status.expression}"/>">
                                    <input type="checkbox"
                                        name="<c:out value="${status.expression}"/>" value="true"
                                        id="<c:out value="${status.expression}"/>"
                                        onClick="selectOnly('<c:out value="${status.expression}"/>')"
                                        <c:if test="${status.value}">checked</c:if>/>
                                </spring:bind>
                                </td>
                                <td align="center">
                                <spring:bind path="patientMatchingConfig.configEntries[${entriesIndex.count - 1}].blocking">
                                    <input type="hidden" name="_<c:out value="${status.expression}"/>">
                                    <input type="checkbox"
                                        name="<c:out value="${status.expression}"/>" value="true"
                                        id="<c:out value="${status.expression}"/>"
                                        onClick="selectOnly('<c:out value="${status.expression}"/>')"
                                        <c:if test="${status.value}">checked</c:if>/>
                                </spring:bind>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </td>
        </tr>
    </table>
</div>
<br/><input type="submit" value="<spring:message code="general.save" />" />
</form>

<%@ include file="/WEB-INF/template/footer.jsp" %>
