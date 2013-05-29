<div class="filters">
	<g:form method="POST" controller="consumption" action="show">
		<div class="box">
            <h2><warehouse:message code="default.filters.label"/></h2>
            <table border="0">
                <tr class="prop">
                    <td class="middle">
                        <label>
                            <warehouse:message code="consumption.afterDate.label" default="Consumed after"/>
                        </label>
                    </td>
                    <td class="right middle">
                        <g:jqueryDatePicker id="fromDate" name="fromDate" value="${command?.fromDate}" format="MM/dd/yyyy"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td>
                        <label>
                            <warehouse:message code="consumption.beforeDate.label" default="Consumed before"/>
                        </label>
                    </td>
                    <td class="right middle">
                        <g:jqueryDatePicker id="toDate" name="toDate" value="${command?.toDate}" format="MM/dd/yyyy"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td colspan="2">
                        <label>
                            <warehouse:message code="consumption.fromLocations.label" default="From location(s)"/>
                        </label>
                    </td>
                </tr>
                <tr class="">
                    <td colspan="2">
                        <g:selectLocation name="fromLocations" value="${command?.fromLocations?.id}" multiple="true" class="chzn-select-deselect"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td colspan="2">
                        <label>
                            <warehouse:message code="consumption.products.label" default="Products"/>
                        </label>
                    </td>
                </tr>
                <tr class="">
                    <td colspan="2">
                        <g:selectTag name="selectedTags" value="${command?.selectedTags?.id}" multiple="true" class="chzn-select-deselect"/>
                    </td>
                </tr>
                <tr class="">
                    <td colspan="2">
                        <g:selectCategory name="selectedCategories" value="${command?.selectedCategories?.id}" multiple="true" class="chzn-select-deselect"
                        style="height: 30px;"/>
                    </td>
                </tr>

                <%--
                <tr class="prop">
                    <td>
                        <label>
                            <warehouse:message code="consumption.transactionType.label" default="transaction types"/>
                        </label>
                    </td>
                    <td>
                        <g:each var="transactionType" in="${command.transactionTypes}">
                            <div>
                                <format:metadata obj="${transactionType}"/>
                            </div>
                        </g:each>


                    </td>
                </tr>
                --%>

                <g:if test="${command?.toLocations}">
                    <tr class="prop">
                        <td colspan="2" class="bottom">
                            <label>
                                <warehouse:message code="consumption.toLocation.label" default="To location(s)"/>
                            </label>
                            <div class="right">
                                <a id="selectAllLocations">Select all</a>&nbsp;|&nbsp;
                                <a id="selectNoLocations">Select none</a>
                            </div>
                        </td>
                    </tr>
                    <tr class="">
                        <td colspan="2">
                            <div style="overflow: auto; max-height: 200px;" class="list">
                                <g:set var="count" value="${0}"/>
                                <g:each var="entry" in="${command.toLocations.groupBy {it.locationGroup}}" >
                                    <div class="">
                                        <h3>${entry.key?:warehouse.message(code:'default.other.label', default: 'Other')}</h3>
                                        <g:each var="toLocation" in="${entry.value}">
                                            <div>
                                                <g:set var="selected" value="${command.selectedLocations.contains(toLocation)}"/>
                                                <g:checkBox name="selectedLocation_${toLocation?.id}" checked="${selected}" class="toLocation"/>
                                                <g:hiddenField name="toLocations[${count++}].id" value="${toLocation?.id}"/>
                                                <format:metadata obj="${toLocation}"/>
                                                <span class="fade">
                                                    <format:metadata obj="${toLocation?.locationType}"/>
                                                </span>
                                            </div>
                                        </g:each>
                                    </div>
                                </g:each>
                                <%--
                                <g:each var="toLocation" in="${command.toLocations}" status="i">
                                    <div>
                                        <g:set var="selected" value="${command.selectedLocations.contains(toLocation)}"/>
                                        <g:checkBox name="selectedLocation_${toLocation?.id}" checked="${selected}" class="toLocation"/>
                                        <g:hiddenField name="toLocations[${i}].id" value="${toLocation?.id}"/>
                                        <b><format:metadata obj="${toLocation?.locationType}"/></b>
                                        <format:metadata obj="${toLocation}"/>
                                    </div>
                                </g:each>
                                --%>

                            </div>
                            <g:unless test="${command.toLocations}">
                                <div class="empty center">
                                    <warehouse:message code="default.empty.label"/>
                                </div>
                            </g:unless>
                        </td>
                    </tr>
                </g:if>
                <tr class="prop">
                    <td>
                        <label>
                            <warehouse:message code="product.properties.label" default="Additional columns"/>
                        </label>
                    </td>
                    <td>
                        <div class="right">
                            <a id="selectAllProperties">Select all</a>&nbsp;|&nbsp;
                            <a id="selectNoProperties">Select none</a>
                        </div>
                    </td>
                </tr>
                <tr class="">
                    <td colspan="2">
                        <div style="overflow: auto; max-height: 200px;" class="list">
                            <g:each var="property" in="${command.productDomain.properties}">
                                <g:if test="${!property.isAssociation()}">
                                    <div class="middle">
                                        <g:checkBox name="selectedProperties" value="${property.name}"
                                            checked="${command.selectedProperties?.toList()?.contains(property.name)}"
                                            class="property"/>
                                            ${property.naturalName}
                                            <span class="fade">${property.typePropertyName}</span>

                                    </div>
                                </g:if>
                            </g:each>
                        </div>
                    </td>
                </tr>
                <tr class="prop">
                    <td colspan="2">
                        <g:checkBox name="includeLocationBreakdown" value="${command.includeLocationBreakdown}"/>
                        <label>
                            <warehouse:message code="consumption.includeLocationBreakdown.label" default="Include location breakdown"/>
                        </label>
                    </td>
                </tr>
                <tr class="prop">
                    <td>
                        <label>
                            <warehouse:message code="consumption.format.label" default="Format"/>
                        </label>
                    </td>
                    <td>
                        <span class="middle">
                            <g:radio name="format" value="html" checked="${params.format=='html'||!params.format}"/> HTML
                        </span>
                        <span class="middle">
                            <g:radio name="format" value="csv" checked="${false}" /> CSV
                        </span>
                    </td>
                </tr>

                <tr class="prop">
                    <td class="center" colspan="2">
                        <button class="button icon search">
                            <warehouse:message code="default.runReport.label" default="Run report"/>
                        </button>

                        <g:link controller="consumption" action="show" class="button icon reload">Reset</g:link>
                        <%--
                        <g:link params="[format:'csv']" controller="${controllerName}" action="${actionName}" class="button icon file">Download .csv</g:link>
                        --%>
                    </td>
                </tr>
            </table>

        </div>
	</g:form>
</div>
<script>
    $(document).ready(function() {
        $("#selectAllLocations").click(function(event) {
            //var checked = ($(this).attr("checked") == 'checked');
            $("input.toLocation[type='checkbox']").attr("checked", true);
        });
        $("#selectNoLocations").click(function(event) {
            //var checked = ($(this).attr("checked") == 'checked');
            $("input.toLocation[type='checkbox']").attr("checked", false);
        });
        $("#selectAllProperties").click(function(event) {
            //var checked = ($(this).attr("checked") == 'checked');
            $("input.property[type='checkbox']").attr("checked", true);
        });
        $("#selectNoProperties").click(function(event) {
            //var checked = ($(this).attr("checked") == 'checked');
            $("input.property[type='checkbox']").attr("checked", false);
        });
        //$("#selectNone").click(function(event) {
        //    var checked = ($(this).attr("checked") == 'checked');
        //    $(".checkbox").attr("checked", checked);
        //});

    });
</script>
