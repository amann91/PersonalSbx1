({
    getCrewMembers : function(component, event, helper) {
        var action = component.get('c.getAllCrewMembers');
        
        action.setCallback(this,function(response){
            debugger;
            // var r = JSON.stringify(response.getReturnValue());
            
            component.set("v.crewNames", response.getReturnValue());
        });
        $A.enqueueAction(action);
    },
    
    getCompsFullList : function(component, event) {
        var action = component.get('c.getAllComps');
        
        action.setCallback(this,function(response){
            debugger;
            // var r = JSON.stringify(response.getReturnValue());
            var columnData = response.getReturnValue();
            var tableData = "<table class=\"slds-table_bordered slds-table_col-bordered\" style=\"\"><thead><tr>";
            for(var c = 0; c < columnData.length; c++){
                tableData += "<th class=\"\" style=\"width: 15px;\"><div style=\"writing-mode: tb-rl\">" + columnData[c] + "</div></th>";
            }
            tableData += "</tr></thead>";
            
            //component.set("v.columns", response.getReturnValue());
            var compEvent = $A.get("e.c:Finished");
                    compEvent.setParams({"msg" : tableData });
                    compEvent.fire();
            
        });
        $A.enqueueAction(action);
    },
    
    buildTable : function (component, event){
        var tableData = event.getParam("msg");
        var action = component.get('c.getAllCrewCompStatus');
        
        action.setCallback(this,function(response){
            debugger;
            var crewComps = response.getReturnValue();
            var size = Object.keys(crewComps).length;
            var table = tableData;
            for(var c = 0; c < size; c++){
                var tableRowofComps = crewComps[c];
                table += '<tr>';
                for(var t = 0; t < tableRowofComps.length; t++){
                    var compStatus = tableRowofComps[t];
                    //This is where check for formatting will happen
                    
                    /*if(compStatus == "S"){
                        table += '<td class=\"tier-one\">';
                        table += tableRowofComps[t];
                        table += '</td>';
                    }*/
                    if(compStatus == "C"){
                        table += '<td class=\"tier-one\">';
                        table += tableRowofComps[t];
                        table += '</td>';
                    }
                    else if(compStatus == "S"){
                        table += '<td class=\"tier-three\">';
                        table += tableRowofComps[t];
                        table += '</td>';
                    }
                    else if(compStatus == "D"){
                        table += '<td class=\"tier-four\">';
                        table += tableRowofComps[t];
                        table += '</td>';
                    }
                    else if(compStatus == "-"){
                        table += '<td class=\"tier-five\">';
                        table += tableRowofComps[t];
                        table += '</td>';
                    }
                    else{
                        table += '<td>';
                        table += tableRowofComps[t];
                        table += '</td>';
                    }
                }
                table += '</tr>';
            }
            // component.set('v.crewMemberCompMap',response.getReturnValue());
            debugger;
            component.set("v.tableData", table);
            
            //table += '</table>';
            
                var a = component.get("v.tableData")
                component.set("v.richtext", component.get("v.tableData"));
            //document.getElementById("tableBody").innerHTML = table;
            /*var body = component.get("v.body");
            body.push(table);
            component.set("v.body", body);*/
        });
        
        $A.enqueueAction(action);
    },
    
    createChart : function (component) {
        
        var ready = component.get("v.ready");
        if (ready === false) {
            return;
        }
        debugger;
        var chartCanvas = component.find("chart").getElement();
        
        var action = component.get("c.getreport");
        action.setCallback(this, function(response) {
            debugger;
            var state = response.getState();
            if (state === "SUCCESS") {
                debugger;
                var reportResultData = JSON.parse(response.getReturnValue());
                var chartData = [];
                var chartLabels = [];
                for(var i=0; i < (reportResultData.groupingsDown.groupings.length); i++){
                    //Collect all labels for Chart.js data
                    var labelTemp = reportResultData.groupingsDown.groupings[i].label;
                    chartLabels.push(labelTemp);
                    
                    var keyTemp = reportResultData.groupingsDown.groupings[i].key;
                    
                    //Collect all values for Chart.js data
                    var valueTemp = reportResultData.factMap[keyTemp + '!T'].rows[0].dataCells[0].label;
                    chartData.push(valueTemp);
                }
                //Construct chart
                var chart = new Chart(chartCanvas,{
                    type: 'doghnut',
                    data: {
                        labels: chartLabels,
                        datasets: [
                            {
                                label: "test",
                                data: chartData,
                                backgroundColor: [
                                    "#52BE80",
                                    "#76D7C4",
                                    "#1E8449",
                                    "#2ECC71",
                                    "#FFB74D",
                                    "#E67E22",
                                    "#F8C471",
                                    "#3498DB",
                                    "#00BCD4",
                                    "#D32F2F",
                                    "#82E0AA",
                                    "#AFB42B"
                                ]
                            }
                        ]
                    },
                    options: {
                        cutoutPercentage: 75,
                        maintainAspectRatio: false,
                        legend: {
                            display: true,
                            position:'right',
                            fullWidth:false,
                            reverse:true,
                            labels: {
                                fontColor: '#000',
                                fontSize:10,
                                fontFamily:"Salesforce Sans, Arial, sans-serif SANS_SERIF"
                            },
                            layout: {
                                padding: 70,
                            }
                        }
                    }
                });
                
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message on createReport: " +
                                    errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    }
})